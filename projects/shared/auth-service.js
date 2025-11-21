import { ethers } from 'ethers'
import crypto from 'crypto'

/**
 * Shared Authentication Service
 * Handles wallet signature verification and user management
 * Used by both Landing Frontend and Hyperfy service
 */
export class AuthService {
  constructor(db) {
    this.db = db
    this.CHALLENGE_EXPIRY = 5 * 60 * 1000 // 5 minutes
  }

  /**
   * Generate a challenge message for wallet signature
   * @param {string} address - Ethereum wallet address
   * @returns {Promise<{message: string, nonce: string}>}
   */
  async generateChallenge(address) {
    const normalizedAddress = address.toLowerCase()
    const nonce = crypto.randomBytes(32).toString('hex')
    const message = this.buildChallengeMessage(address, nonce)
    const expiresAt = new Date(Date.now() + this.CHALLENGE_EXPIRY)

    // Clean up expired challenges for this address
    await this.db('auth_challenges')
      .where('address', normalizedAddress)
      .where('expires_at', '<', new Date())
      .delete()

    // Insert new challenge
    await this.db('auth_challenges').insert({
      address: normalizedAddress,
      nonce,
      message,
      expires_at: expiresAt,
    })

    return { message, nonce }
  }

  /**
   * Build the challenge message text
   * @param {string} address
   * @param {string} nonce
   * @returns {string}
   */
  buildChallengeMessage(address, nonce) {
    return `Welcome to HyperLand!

Sign this message to authenticate your wallet.

Address: ${address}
Nonce: ${nonce}

This signature will not trigger any blockchain transaction or cost gas fees.`
  }

  /**
   * Verify wallet signature and create or link user
   * @param {string} address - Wallet address that signed
   * @param {string} signature - The signature
   * @param {string} message - The message that was signed
   * @returns {Promise<{userId: string, walletAddress: string, rank: number, name: string, isNewUser: boolean}>}
   */
  async verifySignature(address, signature, message) {
    const normalizedAddress = address.toLowerCase()

    // Verify signature
    try {
      const recoveredAddress = ethers.verifyMessage(message, signature)
      if (recoveredAddress.toLowerCase() !== normalizedAddress) {
        throw new Error('Signature verification failed: address mismatch')
      }
    } catch (err) {
      console.error('Signature verification error:', err)
      throw new Error('Invalid signature')
    }

    // Verify challenge exists and not expired
    const challenge = await this.db('auth_challenges')
      .where({ address: normalizedAddress })
      .where('expires_at', '>', new Date())
      .orderBy('created_at', 'desc')
      .first()

    if (!challenge) {
      throw new Error('Challenge not found or expired')
    }

    if (challenge.message !== message) {
      throw new Error('Challenge message mismatch')
    }

    // Delete used challenge (one-time use)
    await this.db('auth_challenges').where({ id: challenge.id }).delete()

    // Check if wallet already linked
    let wallet = await this.db('wallet_addresses')
      .where({ address: normalizedAddress })
      .first()

    let user
    let isNewUser = false

    if (wallet) {
      // Existing wallet - get user
      user = await this.db('users').where({ id: wallet.user_id }).first()
    } else {
      // New wallet - create user
      isNewUser = true
      const [newUser] = await this.db('users')
        .insert({
          name: 'Anonymous',
          rank: 0,
        })
        .returning('*')

      user = newUser

      // Link wallet to new user
      await this.db('wallet_addresses').insert({
        user_id: user.id,
        address: normalizedAddress,
        is_primary: true,
      })
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
   * Link an additional wallet to an existing user
   * @param {string} userId - Existing user ID
   * @param {string} address - New wallet address
   * @param {string} signature - Signature proof
   * @param {string} message - Signed message
   * @returns {Promise<boolean>}
   */
  async linkWallet(userId, address, signature, message) {
    const normalizedAddress = address.toLowerCase()

    // Verify signature
    const userData = await this.verifySignature(address, signature, message)

    // Check if wallet already linked to another user
    const existing = await this.db('wallet_addresses')
      .where({ address: normalizedAddress })
      .first()

    if (existing && existing.user_id !== userId) {
      throw new Error('Wallet already linked to another account')
    }

    if (!existing) {
      // Link wallet to user (not primary)
      await this.db('wallet_addresses').insert({
        user_id: userId,
        address: normalizedAddress,
        is_primary: false,
      })
    }

    return true
  }

  /**
   * Get user by wallet address
   * @param {string} address
   * @returns {Promise<object|null>}
   */
  async getUserByWallet(address) {
    const normalizedAddress = address.toLowerCase()

    const wallet = await this.db('wallet_addresses')
      .where({ address: normalizedAddress })
      .first()

    if (!wallet) {
      return null
    }

    const user = await this.db('users').where({ id: wallet.user_id }).first()
    return user
  }

  /**
   * Get all wallets for a user
   * @param {string} userId
   * @returns {Promise<Array>}
   */
  async getUserWallets(userId) {
    const wallets = await this.db('wallet_addresses')
      .where({ user_id: userId })
      .orderBy('is_primary', 'desc')

    return wallets
  }

  /**
   * Clean up expired challenges (run periodically)
   */
  async cleanupExpiredChallenges() {
    const deleted = await this.db('auth_challenges')
      .where('expires_at', '<', new Date())
      .delete()

    return deleted
  }
}
