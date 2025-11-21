# Wallet Authentication Setup Summary

## ✅ Completed

### 1. **Architecture & Design**
- Designed signature-based authentication flow
- Planned PostgreSQL schema for user/wallet management
- Created shared auth service architecture
- Documented full implementation in `wallet-auth-implementation.md`

### 2. **Infrastructure**
- ✅ Created `docker-compose.yml` for PostgreSQL
- ✅ Created `db/init.sql` with complete schema
- ✅ Updated `Makefile` with database commands
- ✅ Installed dependencies: `ethers@6`, `pg`, `wagmi`, `viem`

### 3. **Shared Services**
- ✅ Created `projects/shared/auth-service.js` - Signature verification logic
- ✅ Created `projects/shared/db-postgres.js` - Database connection utilities

## 📋 Database Schema

```sql
users                  # User accounts
├── id (UUID, PK)
├── name
├── avatar
├── rank
├── created_at
└── updated_at

wallet_addresses       # Linked wallets (one-to-many)
├── id (UUID, PK)
├── user_id (FK → users)
├── address (UNIQUE)
├── is_primary
├── verified_at
└── created_at

auth_challenges        # Temporary auth challenges
├── id (UUID, PK)
├── address
├── nonce (UNIQUE)
├── message
├── expires_at
└── created_at
```

## 🚀 Next Steps (Remaining Implementation)

### Phase 1: Backend API Endpoints

#### A. Update Hyperfy Service (`projects/hypery-hyperland/src/server/index.js`)

```javascript
import { AuthService } from '../../shared/auth-service.js'
import { getPostgresDB } from '../../shared/db-postgres.js'
import { createJWT, readJWT } from '../core/utils-server'

// Initialize PostgreSQL
const postgresDb = await getPostgresDB(process.env.DATABASE_URL)
const authService = new AuthService(postgresDb)

// Challenge endpoint
fastify.post('/api/auth/challenge', async (req, reply) => {
  const { address } = req.body

  if (!address || !/^0x[a-fA-F0-9]{40}$/.test(address)) {
    return reply.code(400).send({ error: 'Invalid Ethereum address' })
  }

  try {
    const challenge = await authService.generateChallenge(address)
    return reply.send(challenge)
  } catch (err) {
    console.error('Challenge generation error:', err)
    return reply.code(500).send({ error: 'Failed to generate challenge' })
  }
})

// Verify endpoint
fastify.post('/api/auth/verify', async (req, reply) => {
  const { address, signature, message } = req.body

  if (!address || !signature || !message) {
    return reply.code(400).send({ error: 'Missing required fields' })
  }

  try {
    const userData = await authService.verifySignature(address, signature, message)

    // Create JWT with wallet address
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
    console.error('Verification error:', err)
    return reply.code(401).send({ error: err.message })
  }
})
```

#### B. Update JWT Verification in ServerNetwork.js

```javascript
// projects/hypery-hyperland/src/core/systems/ServerNetwork.js
// Line ~229 in onConnection method

if (authToken) {
  try {
    const decoded = await readJWT(authToken)
    const { userId, walletAddress, rank } = decoded

    // Get user from PostgreSQL
    user = await postgresDb('users').where('id', userId).first()

    // Verify wallet still linked
    if (walletAddress) {
      const wallet = await postgresDb('wallet_addresses')
        .where({ user_id: userId, address: walletAddress.toLowerCase() })
        .first()

      if (!wallet) {
        throw new Error('Wallet no longer linked')
      }
    }
  } catch (err) {
    console.error('JWT verification failed:', err)
    user = null
  }
}
```

#### C. Create Frontend API Routes

**`projects/frontend/app/api/auth/challenge/route.ts`**:
```typescript
import { NextRequest, NextResponse } from 'next/server'
import { getPostgresDB } from '@/lib/db-postgres'
import { AuthService } from '@/lib/auth-service'

export async function POST(req: NextRequest) {
  try {
    const { address } = await req.json()

    if (!address || !/^0x[a-fA-F0-9]{40}$/.test(address)) {
      return NextResponse.json(
        { error: 'Invalid Ethereum address' },
        { status: 400 }
      )
    }

    const db = await getPostgresDB(process.env.DATABASE_URL!)
    const authService = new AuthService(db)
    const challenge = await authService.generateChallenge(address)

    return NextResponse.json(challenge)
  } catch (err: any) {
    console.error('Challenge error:', err)
    return NextResponse.json(
      { error: 'Failed to generate challenge' },
      { status: 500 }
    )
  }
}
```

**`projects/frontend/app/api/auth/verify/route.ts`**:
```typescript
import { NextRequest, NextResponse } from 'next/server'
import { getPostgresDB } from '@/lib/db-postgres'
import { AuthService } from '@/lib/auth-service'
import { createJWT } from '@/lib/jwt'

export async function POST(req: NextRequest) {
  try {
    const { address, signature, message } = await req.json()

    const db = await getPostgresDB(process.env.DATABASE_URL!)
    const authService = new AuthService(db)
    const userData = await authService.verifySignature(address, signature, message)

    const authToken = await createJWT({
      userId: userData.userId,
      walletAddress: userData.walletAddress,
      rank: userData.rank,
    })

    return NextResponse.json({ authToken, user: userData })
  } catch (err: any) {
    console.error('Verify error:', err)
    return NextResponse.json(
      { error: err.message },
      { status: 401 }
    )
  }
}
```

### Phase 2: Frontend Wallet UI

#### A. Create WalletConnect Component

```tsx
// projects/frontend/components/WalletConnect.tsx
'use client'

import { useState } from 'react'
import { useAccount, useSignMessage, useConnect, useDisconnect } from 'wagmi'
import { InjectedConnector } from 'wagmi/connectors/injected'

export function WalletConnect() {
  const { address, isConnected } = useAccount()
  const { connect } = useConnect({
    connector: new InjectedConnector(),
  })
  const { disconnect } = useDisconnect()
  const { signMessageAsync } = useSignMessage()
  const [authToken, setAuthToken] = useState<string | null>(null)
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)

  const handleAuth = async () => {
    if (!address) return

    setLoading(true)
    setError(null)

    try {
      // 1. Get challenge
      const challengeRes = await fetch('/api/auth/challenge', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ address }),
      })

      if (!challengeRes.ok) {
        throw new Error('Failed to get challenge')
      }

      const { message } = await challengeRes.json()

      // 2. Sign message
      const signature = await signMessageAsync({ message })

      // 3. Verify and get JWT
      const verifyRes = await fetch('/api/auth/verify', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ address, signature, message }),
      })

      if (!verifyRes.ok) {
        const errData = await verifyRes.json()
        throw new Error(errData.error || 'Verification failed')
      }

      const { authToken: token, user } = await verifyRes.json()

      setAuthToken(token)
      localStorage.setItem('authToken', token)
      console.log('Authenticated user:', user)
    } catch (err: any) {
      console.error('Auth error:', err)
      setError(err.message || 'Authentication failed')
    } finally {
      setLoading(false)
    }
  }

  if (isConnected) {
    return (
      <div className="space-y-4">
        <div className="text-sm">
          <span className="text-gray-600">Connected: </span>
          <span className="font-mono">{address}</span>
        </div>

        {error && (
          <div className="text-red-600 text-sm">{error}</div>
        )}

        {!authToken ? (
          <button
            onClick={handleAuth}
            disabled={loading}
            className="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded disabled:opacity-50"
          >
            {loading ? 'Signing...' : 'Sign to Authenticate'}
          </button>
        ) : (
          <div className="text-green-600 font-semibold">
            ✓ Authenticated
          </div>
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
    <button
      onClick={() => connect()}
      className="bg-blue-600 hover:bg-blue-700 text-white px-6 py-3 rounded-lg font-semibold"
    >
      Connect Wallet
    </button>
  )
}
```

#### B. Set up Wagmi Provider

```tsx
// projects/frontend/app/providers.tsx
'use client'

import { WagmiProvider, createConfig, http } from 'wagmi'
import { mainnet, sepolia } from 'wagmi/chains'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'

const config = createConfig({
  chains: [mainnet, sepolia],
  transports: {
    [mainnet.id]: http(),
    [sepolia.id]: http(),
  },
})

const queryClient = new QueryClient()

export function Providers({ children }: { children: React.ReactNode }) {
  return (
    <WagmiProvider config={config}>
      <QueryClientProvider client={queryClient}>
        {children}
      </QueryClientProvider>
    </WagmiProvider>
  )
}
```

### Phase 3: Environment Configuration

#### Update `.env` files:

**`projects/hypery-hyperland/.env`**:
```env
# Database
DATABASE_URL=postgresql://hyperland:hyperland_password@localhost:5432/hyperland_dev

# Existing vars...
WORLD=world
PORT=4000
JWT_SECRET=your-super-secret-jwt-key-minimum-32-characters
```

**`projects/frontend/.env.local`**:
```env
# Database
DATABASE_URL=postgresql://hyperland:hyperland_password@localhost:5432/hyperland_dev

# API URLs
NEXT_PUBLIC_API_URL=http://localhost:4000
NEXT_PUBLIC_HYPERFY_WS_URL=ws://localhost:4000/ws

# JWT
JWT_SECRET=your-super-secret-jwt-key-minimum-32-characters
```

## 🧪 Testing Checklist

```bash
# 1. Start PostgreSQL
make db-up

# 2. Verify database is running
make db-shell
\dt  # List tables
\q   # Quit

# 3. Start services
make dev

# 4. Test auth flow:
# - Connect wallet on frontend (http://localhost:4001)
# - Sign message
# - Verify JWT is stored
# - Test Hyperfy connection with JWT
```

### Manual Testing Steps:

1. **Challenge Generation**:
   ```bash
   curl -X POST http://localhost:4000/api/auth/challenge \
     -H "Content-Type: application/json" \
     -d '{"address":"0x742d35Cc6634C0532925a3b844Bc9e7595f0beb"}'
   ```

2. **Frontend Flow**:
   - Open http://localhost:4001
   - Click "Connect Wallet"
   - Sign the challenge message
   - Verify authentication success

3. **Hyperfy Connection**:
   - Use JWT from localStorage
   - Connect to Hyperfy WebSocket with `authToken` param
   - Verify user is authenticated with wallet address

## 📁 File Summary

### Created Files:
- ✅ `docker-compose.yml` - PostgreSQL service
- ✅ `db/init.sql` - Database schema
- ✅ `projects/shared/auth-service.js` - Auth logic
- ✅ `projects/shared/db-postgres.js` - DB connection
- ✅ `docs/wallet-auth-implementation.md` - Full docs
- ✅ `Makefile` - Updated with DB commands

### Files to Modify:
- ⏳ `projects/hypery-hyperland/src/server/index.js` - Add auth endpoints
- ⏳ `projects/hypery-hyperland/src/core/systems/ServerNetwork.js` - Update JWT handling
- ⏳ `projects/hypery-hyperland/src/core/utils-server.js` - Support new JWT structure
- ⏳ `projects/frontend/app/api/auth/challenge/route.ts` - Challenge endpoint
- ⏳ `projects/frontend/app/api/auth/verify/route.ts` - Verify endpoint
- ⏳ `projects/frontend/components/WalletConnect.tsx` - Wallet UI
- ⏳ `projects/frontend/app/providers.tsx` - Wagmi setup
- ⏳ `projects/frontend/app/page.tsx` - Use WalletConnect component

## 🎯 Current State

**Infrastructure**: ✅ Complete
**Dependencies**: ✅ Installed
**Shared Services**: ✅ Created
**Backend APIs**: ⏳ Ready to implement
**Frontend UI**: ⏳ Ready to implement
**Testing**: ⏳ Pending

## 🚀 Quick Start Commands

```bash
# Start database
make db-up

# Install any missing dependencies
cd projects/hypery-hyperland && npm install
cd projects/frontend && npm install

# Start development
make dev

# View database
make db-shell

# Stop everything
make db-down
```

---

**Ready to proceed with Phase 1: Backend API Implementation!**
