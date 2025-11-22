# Wallet Authentication - Quick Start Guide

## 🎯 What We Built

A **signature-based wallet authentication system** where users sign a message with their wallet (MetaMask/KeepKey) to prove ownership, then receive a JWT that works across both the Landing page and Hyperfy service.

## 📦 What's Ready

### Infrastructure ✅
- PostgreSQL database with Docker
- Complete schema for users/wallets/challenges
- Makefile commands for easy management

### Core Services ✅
- `AuthService` - Signature verification logic
- `db-postgres.js` - PostgreSQL connection utilities
- Shared between both services

### Dependencies ✅
- `ethers@6` - Signature verification
- `pg` - PostgreSQL client
- `wagmi`, `viem` - Frontend wallet integration

## 🚀 Next Implementation Steps

### 1. Start Database (1 minute)

```bash
# Start PostgreSQL
make db-up

# Verify it's running
make db-shell
# Inside psql:
\dt                    # List tables
SELECT * FROM users;   # Should be empty
\q                     # Exit
```

### 2. Add Backend Auth Endpoints (15 minutes)

**File**: `projects/hypery-hyperland/src/server/index.js`

Add near the top after imports:
```javascript
import { AuthService } from '../../shared/auth-service.js'
import { getPostgresDB } from '../../shared/db-postgres.js'

// After: const db = await getDB(worldDir)
const postgresDb = await getPostgresDB(process.env.DATABASE_URL)
const authService = new AuthService(postgresDb)
```

Add before `fastify.listen()`:
```javascript
// Challenge endpoint
fastify.post('/api/auth/challenge', async (req, reply) => {
  const { address } = req.body
  if (!address || !/^0x[a-fA-F0-9]{40}$/.test(address)) {
    return reply.code(400).send({ error: 'Invalid address' })
  }
  try {
    const challenge = await authService.generateChallenge(address)
    return reply.send(challenge)
  } catch (err) {
    console.error('Challenge error:', err)
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
    const authToken = await createJWT({
      userId: userData.userId,
      walletAddress: userData.walletAddress,
      rank: userData.rank,
    })
    return reply.send({ authToken, user: userData })
  } catch (err) {
    console.error('Verify error:', err)
    return reply.code(401).send({ error: err.message })
  }
})
```

### 3. Update Environment Variables (2 minutes)

**File**: `projects/hypery-hyperland/.env`

Add:
```env
DATABASE_URL=postgresql://hyperland:hyperland_password@localhost:5432/hyperland_dev
```

**File**: `projects/frontend/.env.local` (create if missing)

```env
DATABASE_URL=postgresql://hyperland:hyperland_password@localhost:5432/hyperland_dev
NEXT_PUBLIC_API_URL=http://localhost:4000
JWT_SECRET=your-super-secret-jwt-key-minimum-32-characters
```

### 4. Test Backend (5 minutes)

```bash
# Start Hyperfy
cd projects/hypery-hyperland
npm run dev

# In another terminal, test challenge:
curl -X POST http://localhost:4000/api/auth/challenge \
  -H "Content-Type: application/json" \
  -d '{"address":"0x742d35Cc6634C0532925a3b844Bc9e7595f0beb"}'

# Should return: {"message":"Welcome to HyperLand!...","nonce":"..."}
```

### 5. Add Frontend API Routes (10 minutes)

Create these files with the code from `docs/wallet-auth-setup-summary.md` Phase 1C:

- `projects/frontend/app/api/auth/challenge/route.ts`
- `projects/frontend/app/api/auth/verify/route.ts`
- `projects/frontend/lib/db-postgres.ts` (copy from shared, convert to TS)
- `projects/frontend/lib/auth-service.ts` (copy from shared, convert to TS)

### 6. Add Wallet UI (15 minutes)

1. Copy files from Phase 2 in `docs/wallet-auth-setup-summary.md`:
   - `projects/frontend/components/WalletConnect.tsx`
   - `projects/frontend/app/providers.tsx`

2. Update `projects/frontend/app/layout.tsx`:
```tsx
import { Providers } from './providers'

export default function RootLayout({ children }) {
  return (
    <html>
      <body>
        <Providers>
          {children}
        </Providers>
      </body>
    </html>
  )
}
```

3. Update `projects/frontend/app/page.tsx` to use `<WalletConnect />`

### 7. Test Full Flow (5 minutes)

```bash
# Terminal 1: Start database
make db-up

# Terminal 2: Start Hyperfy
cd projects/hypery-hyperland && npm run dev

# Terminal 3: Start Frontend
cd projects/frontend && npm run dev

# Open browser: http://localhost:4001
# 1. Click "Connect Wallet"
# 2. Approve MetaMask connection
# 3. Click "Sign to Authenticate"
# 4. Sign the message
# 5. Should see "✓ Authenticated"

# Check database:
make db-shell
SELECT * FROM users;
SELECT * FROM wallet_addresses;
\q
```

## 🔍 Verification Checklist

- [ ] PostgreSQL running (`make db-up` works)
- [ ] Challenge endpoint returns nonce (`curl` test passes)
- [ ] Frontend connects to wallet (MetaMask popup appears)
- [ ] User can sign message (no errors in console)
- [ ] JWT stored in localStorage (`authToken` key)
- [ ] User and wallet in database (`SELECT * FROM users`)
- [ ] Hyperfy accepts JWT (connect to world works)

## 📚 Documentation

- **Full Implementation**: `docs/wallet-auth-implementation.md`
- **Setup Summary**: `docs/wallet-auth-setup-summary.md`
- **Architecture Diagram**: See implementation doc

## 🐛 Troubleshooting

### "Connection refused" on PostgreSQL
```bash
make db-up
# Wait 5 seconds
make db-shell
```

### "Invalid signature" error
- Make sure challenge message matches exactly
- Check address is lowercase normalized
- Verify signature format is correct

### Frontend can't connect to backend
- Check CORS settings in Hyperfy
- Verify ports (4000=Hyperfy, 4001=Frontend)
- Check `NEXT_PUBLIC_API_URL` in `.env.local`

### JWT not working in Hyperfy
- Update `ServerNetwork.js` to read new JWT structure
- Check JWT includes `walletAddress` field
- Verify PostgreSQL connection in Hyperfy

## 🎮 Using the System

### As a User:
1. Visit landing page
2. Click "Connect Wallet"
3. Sign the authentication message (no gas fees!)
4. Receive JWT automatically
5. Access Hyperfy world with verified identity

### As a Developer:
```javascript
// Get user's wallet from JWT
const { userId, walletAddress, rank } = await readJWT(token)

// Check if address is linked
const wallet = await db('wallet_addresses')
  .where({ address: walletAddress.toLowerCase() })
  .first()

// Get user's primary wallet
const primary = await db('wallet_addresses')
  .where({ user_id: userId, is_primary: true })
  .first()
```

## 🔐 Security Notes

- ✅ Challenges expire after 5 minutes
- ✅ One-time use (deleted after verification)
- ✅ Signature verification via `ethers.verifyMessage`
- ✅ Address normalization (lowercase)
- ✅ No private keys ever transmitted
- ✅ No blockchain transactions required

## 📊 Database Quick Reference

```sql
-- View all users
SELECT u.name, u.rank, w.address, w.is_primary
FROM users u
LEFT JOIN wallet_addresses w ON u.id = w.user_id;

-- Find user by wallet
SELECT u.* FROM users u
JOIN wallet_addresses w ON u.id = w.user_id
WHERE w.address = '0x...';

-- Clean up expired challenges
DELETE FROM auth_challenges WHERE expires_at < NOW();
```

## ⚡ Performance Tips

- Challenge cleanup runs automatically in AuthService
- Database indexes on address and user_id for fast lookups
- Connection pooling (2-10 connections)
- JWT verification is stateless (no DB lookup needed)

---

**Time to Complete**: ~1 hour for full implementation + testing

**Need Help?** See full documentation in `docs/` folder
