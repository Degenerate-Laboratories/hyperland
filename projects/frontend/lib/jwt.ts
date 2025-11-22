import jwt from 'jsonwebtoken'

const JWT_SECRET = process.env.JWT_SECRET || 'your-super-secret-jwt-key-minimum-32-characters'

export interface JWTPayload {
  userId: string
  walletAddress: string
  rank: number
  iat?: number
  exp?: number
}

export function createJWT(data: Omit<JWTPayload, 'iat' | 'exp'>): Promise<string> {
  return new Promise((resolve, reject) => {
    jwt.sign(data, JWT_SECRET, { expiresIn: '7d' }, (err, token) => {
      if (err || !token) return reject(err)
      resolve(token)
    })
  })
}

export function readJWT(token: string): Promise<JWTPayload | null> {
  return new Promise((resolve) => {
    jwt.verify(token, JWT_SECRET, (err, decoded) => {
      resolve(err ? null : (decoded as JWTPayload))
    })
  })
}
