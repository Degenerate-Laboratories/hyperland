import { NextRequest, NextResponse } from 'next/server'
import { getPostgresDB } from '@/lib/db-postgres'
import { AuthService } from '@/lib/auth-service'

export async function POST(req: NextRequest) {
  try {
    const { address } = await req.json()

    if (!address || !/^0x[a-fA-F0-9]{40}$/.test(address)) {
      return NextResponse.json({ error: 'Invalid Ethereum address' }, { status: 400 })
    }

    const pool = await getPostgresDB()
    const authService = new AuthService(pool)
    const challenge = await authService.generateChallenge(address)

    return NextResponse.json(challenge)
  } catch (err) {
    console.error('Challenge generation error:', err)
    return NextResponse.json(
      { error: 'Failed to generate challenge' },
      { status: 500 }
    )
  }
}
