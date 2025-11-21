# Wallet Authentication Implementation Plan

## Overview

Implement signature-based wallet authentication with PostgreSQL for both the landing frontend and Hyperfy service. Users must sign a message and link their wallet address before receiving a JWT.

## Architecture

### Authentication Flow

```
1. User → Connect Wallet (MetaMask/KeepKey)
2. Frontend → POST /api/auth/challenge { address }
3. Backend → Generate nonce, return challenge message
4. User → Sign message with wallet
5. Frontend → POST /api/auth/verify { address, signature, message }
6. Backend → Verify signature, create/link user, issue JWT
7. JWT includes: { userId, walletAddress, rank }
8. User → Access both services with verified JWT
```

### Database Schema (PostgreSQL)

```sql
-- Users table
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL DEFAULT 'Anonymous',
  avatar TEXT,
  rank INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Wallet addresses (one-to-many with users)
CREATE TABLE wallet_addresses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  address VARCHAR(42) NOT NULL UNIQUE,
  is_primary BOOLEAN NOT NULL DEFAULT true,
  verified_at TIMESTAMP NOT NULL DEFAULT NOW(),
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Auth challenges (for signature verification)
CREATE TABLE auth_challenges (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  address VARCHAR(42) NOT NULL,
  nonce VARCHAR(64) NOT NULL UNIQUE,
  message TEXT NOT NULL,
  expires_at TIMESTAMP NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Indexes
CREATE INDEX idx_wallet_addresses_user_id ON wallet_addresses(user_id);
CREATE INDEX idx_wallet_addresses_address ON wallet_addresses(address);
CREATE INDEX idx_auth_challenges_nonce ON auth_challenges(nonce);
CREATE INDEX idx_auth_challenges_address_expires ON auth_challenges(address, expires_at);
CREATE UNIQUE INDEX idx_wallet_primary ON wallet_addresses(user_id, is_primary) WHERE is_primary = true;
```

### Migration from SQLite

The Hyperfy service currently uses SQLite. We'll:
1. Add PostgreSQL support via Knex
2. Create migration to copy existing users to PostgreSQL
3. Keep both DBs during transition (optional)
4. Update connection logic to use PostgreSQL

## Implementation Tasks

### 1. PostgreSQL Setup

**Database Configuration**:
```env
# .env for both services
DATABASE_URL=postgresql://hyperland:password@localhost:5432/hyperland_dev
DATABASE_POOL_MIN=2
DATABASE_POOL_MAX=10
```

**Docker Compose** (local development):
```yaml
version: '3.8'
services:
  postgres:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: hyperland_dev
      POSTGRES_USER: hyperland
      POSTGRES_PASSWORD: password
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

### 2. Dependencies

**For both services**:
```bash
npm install pg ethers@6
```

**Frontend additional**:
```bash
npm install wagmi viem @web3modal/ethereum @web3modal/react
```

### 3. Backend Implementation

#### Auth Service (`projects/shared/auth-service.js`)

```javascript
import { ethers } from 'ethers'
import crypto from 'crypto'

export class AuthService {
  constructor(db) {
    this.db = db
  }

  // Generate challenge for wallet signature
  async generateChallenge(address) {
    const nonce = crypto.randomBytes(32).toString('hex')
    const message = `Sign this message to authenticate with HyperLand\n\nNonce: ${nonce}\nAddress: ${address}`
    const expiresAt = new Date(Date.now() + 5 * 60 * 1000) // 5 minutes

    await this.db('auth_challenges').insert({
      address: address.toLowerCase(),
      nonce,
      message,
      expires_at: expiresAt,
    })

    return { message, nonce }
  }

  // Verify signature and create/update user
  async verifySignature(address, signature, message) {
    // Recover signer address from signature
    const recoveredAddress = ethers.verifyMessage(message, signature)

    if (recoveredAddress.toLowerCase() !== address.toLowerCase()) {
      throw new Error('Invalid signature')
    }

    // Verify challenge exists and not expired
    const challenge = await this.db('auth_challenges')
      .where({ address: address.toLowerCase() })
      .where('expires_at', '>', new Date())
      .orderBy('created_at', 'desc')
      .first()

    if (!challenge || challenge.message !== message) {
      throw new Error('Invalid or expired challenge')
    }

    // Delete used challenge
    await this.db('auth_challenges').where({ id: challenge.id }).delete()

    // Get or create user
    let wallet = await this.db('wallet_addresses')
      .where({ address: address.toLowerCase() })
      .first()

    let user
    if (wallet) {
      // Existing wallet - get user
      user = await this.db('users').where({ id: wallet.user_id }).first()
    } else {
      // New wallet - create user
      const [userId] = await this.db('users').insert({
        name: 'Anonymous',
        rank: 0,
      }).returning('id')

      await this.db('wallet_addresses').insert({
        user_id: userId,
        address: address.toLowerCase(),
        is_primary: true,
      })

      user = await this.db('users').where({ id: userId }).first()
    }

    return {
      userId: user.id,
      walletAddress: address.toLowerCase(),
      rank: user.rank,
      name: user.name,
    }
  }

  // Link additional wallet to existing user
  async linkWallet(userId, address, signature, message) {
    // Verify signature
    await this.verifySignature(address, signature, message)

    // Check if wallet already linked to another user
    const existing = await this.db('wallet_addresses')
      .where({ address: address.toLowerCase() })
      .first()

    if (existing && existing.user_id !== userId) {
      throw new Error('Wallet already linked to another account')
    }

    if (!existing) {
      await this.db('wallet_addresses').insert({
        user_id: userId,
        address: address.toLowerCase(),
        is_primary: false,
      })
    }

    return true
  }
}
```

#### API Endpoints

**For Hyperfy** (`projects/hypery-hyperland/src/server/index.js`):

```javascript
import { AuthService } from '../shared/auth-service.js'

const authService = new AuthService(db)

// Challenge endpoint
fastify.post('/api/auth/challenge', async (req, reply) => {
  const { address } = req.body

  if (!address || !/^0x[a-fA-F0-9]{40}$/.test(address)) {
    return reply.code(400).send({ error: 'Invalid address' })
  }

  const challenge = await authService.generateChallenge(address)
  return reply.send(challenge)
})

// Verify endpoint
fastify.post('/api/auth/verify', async (req, reply) => {
  try {
    const { address, signature, message } = req.body

    const userData = await authService.verifySignature(address, signature, message)
    const authToken = await createJWT({
      userId: userData.userId,
      walletAddress: userData.walletAddress,
      rank: userData.rank,
    })

    return reply.send({
      authToken,
      user: userData,
    })
  } catch (err) {
    console.error('Verify error:', err)
    return reply.code(401).send({ error: err.message })
  }
})
```

**For Landing Frontend** (Next.js API Routes):

```typescript
// projects/frontend/app/api/auth/challenge/route.ts
import { NextRequest, NextResponse } from 'next/server'
import { getDB } from '@/lib/db'
import { AuthService } from '@/lib/auth-service'

export async function POST(req: NextRequest) {
  const { address } = await req.json()

  if (!address || !/^0x[a-fA-F0-9]{40}$/.test(address)) {
    return NextResponse.json({ error: 'Invalid address' }, { status: 400 })
  }

  const db = await getDB()
  const authService = new AuthService(db)
  const challenge = await authService.generateChallenge(address)

  return NextResponse.json(challenge)
}

// projects/frontend/app/api/auth/verify/route.ts
export async function POST(req: NextRequest) {
  try {
    const { address, signature, message } = await req.json()

    const db = await getDB()
    const authService = new AuthService(db)
    const userData = await authService.verifySignature(address, signature, message)

    // Create JWT
    const authToken = await createJWT({
      userId: userData.userId,
      walletAddress: userData.walletAddress,
      rank: userData.rank,
    })

    return NextResponse.json({ authToken, user: userData })
  } catch (err) {
    return NextResponse.json({ error: err.message }, { status: 401 })
  }
}
```

### 4. Frontend Implementation

#### Wallet Connect Component

```tsx
// projects/frontend/components/WalletConnect.tsx
'use client'

import { useState } from 'react'
import { useAccount, useSignMessage, useConnect, useDisconnect } from 'wagmi'

export function WalletConnect() {
  const { address, isConnected } = useAccount()
  const { connect, connectors } = useConnect()
  const { disconnect } = useDisconnect()
  const { signMessageAsync } = useSignMessage()
  const [authToken, setAuthToken] = useState<string | null>(null)
  const [loading, setLoading] = useState(false)

  const handleAuth = async () => {
    if (!address) return

    setLoading(true)
    try {
      // 1. Get challenge
      const challengeRes = await fetch('/api/auth/challenge', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ address }),
      })
      const { message, nonce } = await challengeRes.json()

      // 2. Sign message
      const signature = await signMessageAsync({ message })

      // 3. Verify and get JWT
      const verifyRes = await fetch('/api/auth/verify', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ address, signature, message }),
      })
      const { authToken: token, user } = await verifyRes.json()

      setAuthToken(token)
      localStorage.setItem('authToken', token)
      console.log('Authenticated:', user)
    } catch (err) {
      console.error('Auth failed:', err)
    } finally {
      setLoading(false)
    }
  }

  if (isConnected) {
    return (
      <div className="space-y-4">
        <p className="text-sm">Connected: {address}</p>
        {!authToken ? (
          <button
            onClick={handleAuth}
            disabled={loading}
            className="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded"
          >
            {loading ? 'Signing...' : 'Sign to Authenticate'}
          </button>
        ) : (
          <p className="text-green-600">✓ Authenticated</p>
        )}
        <button
          onClick={() => disconnect()}
          className="bg-gray-600 hover:bg-gray-700 text-white px-4 py-2 rounded"
        >
          Disconnect
        </button>
      </div>
    )
  }

  return (
    <div className="space-y-2">
      {connectors.map(connector => (
        <button
          key={connector.id}
          onClick={() => connect({ connector })}
          className="bg-blue-600 hover:bg-blue-700 text-white px-6 py-3 rounded"
        >
          Connect with {connector.name}
        </button>
      ))}
    </div>
  )
}
```

### 5. Updated JWT Structure

```javascript
// OLD JWT (current)
{
  userId: "abc-123"
}

// NEW JWT (with wallet)
{
  userId: "abc-123",
  walletAddress: "0x742d35cc6634c0532925a3b844bc9e7595f0beb",
  rank: 0,
  iat: 1234567890,
  exp: 1234657890
}
```

### 6. Hyperfy Connection Update

Update `ServerNetwork.js` to handle the new JWT structure:

```javascript
// projects/hypery-hyperland/src/core/systems/ServerNetwork.js

async onConnection(ws, params) {
  // ... existing code ...

  if (authToken) {
    try {
      const decoded = await readJWT(authToken)
      // Now includes walletAddress!
      const { userId, walletAddress, rank } = decoded

      // Get user by ID
      user = await this.db('users').where('id', userId).first()

      // Verify wallet still linked
      if (walletAddress) {
        const wallet = await this.db('wallet_addresses')
          .where({ user_id: userId, address: walletAddress.toLowerCase() })
          .first()

        if (!wallet) {
          throw new Error('Wallet no longer linked to this account')
        }
      }
    } catch (err) {
      console.error('JWT verification failed:', err)
      user = null
    }
  }

  // ... rest of existing code ...
}
```

## Migration Strategy

### Phase 1: Add PostgreSQL (parallel to SQLite)
1. Set up PostgreSQL
2. Create shared auth service
3. Run both DBs in parallel
4. New users → PostgreSQL
5. Existing users → stay in SQLite until they re-auth

### Phase 2: Migrate Existing Users
1. Script to copy SQLite users → PostgreSQL
2. Keep user IDs consistent
3. Create placeholder wallet entries (verified on first login)

### Phase 3: Remove SQLite
1. Update all DB calls to PostgreSQL
2. Remove SQLite dependency
3. Archive old SQLite DB

## Security Considerations

1. **Nonce Expiry**: Challenges expire after 5 minutes
2. **One-time Use**: Challenges deleted after verification
3. **Address Normalization**: Always lowercase for consistency
4. **Signature Verification**: Use ethers.verifyMessage
5. **JWT Secret**: Use strong secret (32+ chars)
6. **HTTPS Only**: All auth requests over HTTPS in production
7. **Rate Limiting**: Add rate limits on challenge/verify endpoints

## Testing Checklist

- [ ] Local PostgreSQL setup works
- [ ] Challenge generation and expiry
- [ ] Signature verification (valid/invalid)
- [ ] New user creation with wallet
- [ ] Existing user wallet linking
- [ ] JWT includes wallet address
- [ ] Hyperfy accepts new JWT format
- [ ] Frontend wallet connect flow
- [ ] Landing page authentication
- [ ] Cross-service JWT usage

## Environment Variables

```env
# Shared by both services
DATABASE_URL=postgresql://hyperland:password@localhost:5432/hyperland_dev
JWT_SECRET=your-super-secret-jwt-key-min-32-chars

# Hyperfy-specific (existing)
PORT=4000
WORLD=world
SAVE_INTERVAL=60

# Frontend-specific
NEXT_PUBLIC_API_URL=http://localhost:4000
NEXT_PUBLIC_HYPERFY_URL=http://localhost:4000
```

## File Structure

```
hyperland/
├── projects/
│   ├── shared/
│   │   ├── db.js                 # Shared DB connection
│   │   └── auth-service.js       # Shared auth logic
│   ├── frontend/
│   │   ├── app/
│   │   │   └── api/auth/
│   │   │       ├── challenge/route.ts
│   │   │       └── verify/route.ts
│   │   ├── components/
│   │   │   └── WalletConnect.tsx
│   │   └── lib/
│   │       ├── db.ts
│   │       └── auth-service.ts
│   └── hypery-hyperland/
│       └── src/server/
│           └── index.js          # Updated with auth endpoints
├── db/
│   ├── schema.sql               # PostgreSQL schema
│   └── migrations/              # Knex migrations
└── docker-compose.yml           # PostgreSQL service
```

## Next Steps

1. Set up local PostgreSQL with Docker
2. Create schema and migrations
3. Install dependencies
4. Implement AuthService
5. Add API endpoints
6. Build frontend wallet UI
7. Update Hyperfy to accept new JWT
8. Test end-to-end flow
