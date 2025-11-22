import { NextRequest, NextResponse } from 'next/server'
import { getPostgresDB } from '@/lib/db-postgres'
import { AuthService } from '@/lib/auth-service'
import { createJWT } from '@/lib/jwt'

export async function POST(req: NextRequest) {
  try {
    const { address, signature, message } = await req.json()

    if (!address || !signature || !message) {
      return NextResponse.json(
        { error: 'Missing required fields: address, signature, message' },
        { status: 400 }
      )
    }

    const pool = await getPostgresDB()
    const authService = new AuthService(pool)
    const userData = await authService.verifySignature(address, signature, message)

    // Create JWT with user data
    const authToken = await createJWT({
      userId: userData.userId,
      walletAddress: userData.walletAddress,
      rank: userData.rank,
    })

    return NextResponse.json({
      authToken,
      user: userData,
    })
  } catch (err: any) {
    console.error('Verification error:', err)
    return NextResponse.json(
      { error: err.message || 'Verification failed' },
      { status: 401 }
    )
  }
}
