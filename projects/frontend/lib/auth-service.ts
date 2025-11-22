import { verifyMessage } from 'viem'
import { randomBytes } from 'crypto'
import { Pool } from 'pg'

export class AuthService {
  private pool: Pool
  private readonly CHALLENGE_EXPIRY = 5 * 60 * 1000 // 5 minutes

  constructor(pool: Pool) {
    this.pool = pool
  }

  /**
   * Generate a challenge message for wallet signature
   */
  async generateChallenge(address: string): Promise<{ message: string; nonce: string }> {
    const normalizedAddress = address.toLowerCase()
    const nonce = randomBytes(32).toString('hex')
    const message = this.buildChallengeMessage(address, nonce)
    const expiresAt = new Date(Date.now() + this.CHALLENGE_EXPIRY)

    // Clean up expired challenges for this address
    await this.pool.query(
      'DELETE FROM auth_challenges WHERE address = $1 AND expires_at < NOW()',
      [normalizedAddress]
    )

    // Insert new challenge
    await this.pool.query(
      'INSERT INTO auth_challenges (address, nonce, message, expires_at) VALUES ($1, $2, $3, $4)',
      [normalizedAddress, nonce, message, expiresAt]
    )

    return { message, nonce }
  }

  /**
   * Build the challenge message text
   */
  private buildChallengeMessage(address: string, nonce: string): string {
    return `Welcome to HyperLand!

Sign this message to authenticate your wallet.

Address: ${address}
Nonce: ${nonce}

This signature will not trigger any blockchain transaction or cost gas fees.`
  }

  /**
   * Verify wallet signature and create or link user
   */
  async verifySignature(
    address: string,
    signature: string,
    message: string
  ): Promise<{
    userId: string
    walletAddress: string
    rank: number
    name: string
    avatar: string | null
    isNewUser: boolean
  }> {
    const normalizedAddress = address.toLowerCase()

    // Verify signature
    try {
      const isValid = await verifyMessage({
        address: address as `0x${string}`,
        message,
        signature: signature as `0x${string}`,
      })

      if (!isValid) {
        throw new Error('Invalid signature')
      }
    } catch (err) {
      console.error('Signature verification error:', err)
      throw new Error('Invalid signature')
    }

    // Verify challenge exists and not expired
    const challengeResult = await this.pool.query(
      `SELECT * FROM auth_challenges
       WHERE address = $1 AND expires_at > NOW()
       ORDER BY created_at DESC LIMIT 1`,
      [normalizedAddress]
    )

    const challenge = challengeResult.rows[0]

    if (!challenge) {
      throw new Error('Challenge not found or expired')
    }

    if (challenge.message !== message) {
      throw new Error('Challenge message mismatch')
    }

    // Delete used challenge (one-time use)
    await this.pool.query('DELETE FROM auth_challenges WHERE id = $1', [challenge.id])

    // Check if wallet already linked
    const walletResult = await this.pool.query(
      'SELECT * FROM wallet_addresses WHERE address = $1',
      [normalizedAddress]
    )

    let user
    let isNewUser = false

    if (walletResult.rows.length > 0) {
      // Existing wallet - get user
      const wallet = walletResult.rows[0]
      const userResult = await this.pool.query('SELECT * FROM users WHERE id = $1', [
        wallet.user_id,
      ])
      user = userResult.rows[0]
    } else {
      // New wallet - create user
      isNewUser = true
      const userResult = await this.pool.query(
        `INSERT INTO users (name, rank) VALUES ($1, $2) RETURNING *`,
        ['Anonymous', 0]
      )
      user = userResult.rows[0]

      // Link wallet to new user
      await this.pool.query(
        'INSERT INTO wallet_addresses (user_id, address, is_primary) VALUES ($1, $2, $3)',
        [user.id, normalizedAddress, true]
      )
    }

    return {
      userId: user.id,
      walletAddress: normalizedAddress,
      rank: user.rank,
      name: user.name,
      avatar: user.avatar,
      isNewUser,
    }
  }

  /**
   * Clean up expired challenges (run periodically)
   */
  async cleanupExpiredChallenges(): Promise<number> {
    const result = await this.pool.query('DELETE FROM auth_challenges WHERE expires_at < NOW()')
    return result.rowCount || 0
  }
}
