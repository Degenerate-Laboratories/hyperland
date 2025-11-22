# HyperLand Infrastructure Migration Plan

## Overview
Migrate HyperLand from local development to production-ready infrastructure with:
- S3 asset storage (DigitalOcean Spaces)
- PostgreSQL database
- Twitter OAuth authentication
- Docker containerization
- CI/CD pipeline

**Reference Implementation**: DegenCity project (sister project with proven production deployment)

---

## 1. S3 Asset Storage Migration

### Current State
- Assets stored locally
- `.env` already has S3 configuration:
  - `ASSETS=s3`
  - `ASSETS_BASE_URL=https://degencity.nyc3.digitaloceanspaces.com/assets`
  - `ASSETS_S3_URI=s3://DO00FXP8KK64LCXYAEZP:...@nyc3.digitaloceanspaces.com/degencity/assets`

### Implementation Steps

#### 1.1 Copy S3 Implementation Files
```bash
# Files to implement/copy from reference project:
projects/hypery-hyperland/src/server/AssetsS3.js       # S3 storage implementation
projects/hypery-hyperland/src/server/AssetsLocal.js    # Local storage fallback
projects/hypery-hyperland/src/server/assets.js         # Asset system router
projects/hypery-hyperland/scripts/sync-s3.mjs          # S3 sync utility
projects/hypery-hyperland/scripts/s3-cleanup.js        # S3 cleanup utility
```

#### 1.2 Install Dependencies
```bash
npm install @aws-sdk/client-s3
```

#### 1.3 Update .env Configuration
```bash
# Asset storage (s3 or local)
ASSETS=s3
ASSETS_BASE_URL=https://hyperland.nyc3.cdn.digitaloceanspaces.com/assets

# S3 URI format: s3://access_key:secret_key@endpoint/bucket/prefix
ASSETS_S3_URI=s3://DO00FXP8KK64LCXYAEZP:Uyw%2Fcq63rrQmFV9yy1HbovTSMNhLkEwImqPa88N%2FE%2Fs@nyc3.digitaloceanspaces.com/hyperland/assets
```

#### 1.4 Integration Points
- `src/server/index.js` - Initialize assets system
- Asset upload/download endpoints
- World asset synchronization

#### 1.5 npm Scripts (add to package.json)
```json
{
  "scripts": {
    "sync:s3": "node scripts/sync-s3.mjs",
    "s3:cleanup": "node scripts/s3-cleanup.js",
    "s3:list": "node scripts/s3-cleanup.js list",
    "s3:purge": "node scripts/s3-cleanup.js purge"
  }
}
```

---

## 2. PostgreSQL Database Migration

### Current State
- Using local SQLite (`world.db`)
- Docker Compose already configured:
  - PostgreSQL 16 Alpine
  - Port 5432
  - Database: `hyperland_dev`

### Implementation Steps

#### 2.1 Copy Database Implementation
```bash
# File to implement/copy from reference:
projects/hypery-hyperland/src/server/db.js    # Database abstraction with migrations
```

#### 2.2 Install Dependencies
```bash
npm install knex pg better-sqlite3
```

#### 2.3 Update .env Configuration
```bash
# Database Configuration
# local = SQLite in world folder
# postgres://... = PostgreSQL connection
DB_URI=postgres://hyperland:hyperland_password@localhost:5432/hyperland_dev
DB_SCHEMA=public
```

#### 2.4 Key Features from Reference
- **Knex.js** for database abstraction (supports both SQLite and PostgreSQL)
- **Migration system** with versioning
- **Auto-detection**: `DB_URI` starting with `postgres://` or `postgresql://` switches to PostgreSQL
- **Fallback**: Defaults to SQLite if `DB_URI=local`

#### 2.5 Database Tables (from degencity migrations)
```sql
-- Core tables
config              # Key-value configuration
users               # User accounts with OAuth
blueprints          # Game blueprints/templates
entities            # Game entities/objects
assets_metadata     # Asset tracking with votes
asset_votes         # DEGEN voting system
hex_ownership       # Land ownership
```

#### 2.6 Start Database
```bash
make db-up          # Start PostgreSQL
make db-down        # Stop PostgreSQL
make db-reset       # Reset database (WARNING: deletes data)
make db-logs        # View logs
make db-shell       # Connect to psql
```

---

## 3. Twitter OAuth Authentication

### Current State
- `.env` has Twitter credentials:
  - `TWITTER_CLIENT_ID`
  - `TWITTER_CLIENT_SECRET`

### Implementation Steps

#### 3.1 Copy Auth Implementation
```bash
# Files to implement/copy from reference:
projects/hypery-hyperland/src/server/auth.js                    # OAuth backend
projects/hypery-hyperland/src/client/components/TwitterLogin.js # OAuth frontend
```

#### 3.2 Install Dependencies
```bash
npm install @auth/core
```

#### 3.3 Update .env Configuration
```bash
# Twitter OAuth 2.0 Configuration
TWITTER_CLIENT_ID=NmRfM3NqR1VhOUZRY2R2RWxtaFc6MTpjaQ
TWITTER_CLIENT_SECRET=kQYYe5blc-STiqREoOY4VgvPmSWIAYDcJi9wHgOAjuRWO5L1uK
PUBLIC_URL=http://localhost:4000
```

For production:
```bash
PUBLIC_URL=https://hyperland.io  # or your production domain
```

#### 3.4 Key Features from Reference
- **OAuth 2.0** with PKCE flow (secure for public clients)
- **State parameter** for CSRF protection
- **JWT tokens** for session management
- **User database** integration
- **Callback handling** at `/api/auth/callback/twitter`

#### 3.5 Database Migration Required
```javascript
// Add to db.js migrations array
async db => {
  await db.schema.alterTable('users', table => {
    table.string('provider').nullable().defaultTo('local')
    table.string('providerId').nullable()
    table.string('email').nullable()
    table.string('profileImage').nullable()
    table.timestamp('lastLogin').nullable()
  })
}
```

#### 3.6 API Endpoints to Add
```javascript
// In src/server/index.js
app.get('/api/auth/twitter', twitterAuth.getAuthorizationUrl)
app.get('/api/auth/callback/twitter', twitterAuth.handleCallback)
app.get('/api/auth/me', authenticateUser)
app.post('/api/auth/logout', logout)
```

---

## 4. Docker Image Building

### Current State
- No Dockerfile in hyperland
- Makefile exists for development

### Implementation Steps

#### 4.1 Copy Dockerfile
```bash
# Files to implement/copy from reference:
projects/hypery-hyperland/Dockerfile      # Multi-stage Docker build
projects/hypery-hyperland/.dockerignore   # Docker ignore patterns
```

#### 4.2 Update Dockerfile for HyperLand
```dockerfile
# Key differences from reference:
# - World directory: /app/hyperland (not /app/degencity)
# - Port: 4000 (not 3000)
# - Health endpoint: http://localhost:4000/status
```

Changes needed:
```dockerfile
# Line 74: Update world directory
RUN mkdir -p /app/hyperland && \
    chown -R nodeuser:nodeuser /app/hyperland

# Line 81: Update port
EXPOSE 4000

# Line 84-85: Update health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD curl -f http://localhost:4000/status || exit 1
```

#### 4.3 npm Scripts (add to package.json)
```json
{
  "scripts": {
    "docker:build": "docker build -t hyperland:latest .",
    "docker:tag": "docker tag hyperland:latest registry.digitalocean.com/pioneer/hyperland:latest",
    "docker:run": "docker run --env-file .env -p 4000:4000 hyperland:latest",
    "docker:push": "docker push registry.digitalocean.com/pioneer/hyperland:latest",
    "docker:push:all": "npm run docker:build && npm run docker:tag && npm run docker:push"
  }
}
```

#### 4.4 Multi-Stage Build Benefits
- **Stage 1 (deps)**: Production dependencies only
- **Stage 2 (builder)**: All dependencies + build process
- **Stage 3 (production)**: Minimal final image
- **BuildKit cache**: Faster subsequent builds
- **Non-root user**: Security best practice
- **Health check**: Kubernetes/Docker Swarm compatibility

---

## 5. CI/CD Pipeline (GitHub Actions)

### Implementation Steps

#### 5.1 Create GitHub Actions Workflow
```bash
mkdir -p .github/workflows
```

#### 5.2 Copy Workflow Files
```bash
# File to implement/copy from reference:
.github/workflows/digitalocean.yml    # CI/CD pipeline for DigitalOcean
```

#### 5.3 Update Workflow for HyperLand
Key changes:
```yaml
env:
  IMAGE_NAME: hyperland  # Change from degencity

# Update branches (lines 6-8)
branches:
  - main
  - develop
  - master

# Update port in health check if needed
# Update deployment name if using Kubernetes
```

#### 5.4 GitHub Secrets Required
Add these to GitHub repository settings (`Settings` → `Secrets and variables` → `Actions`):

```bash
DIGITALOCEAN_TOKEN=dop_v1_...  # DigitalOcean API token for registry access
```

#### 5.5 Workflow Features
- **Auto-trigger** on push to main/develop branches
- **Version tagging** from package.json
- **Multi-platform** support (currently linux/amd64)
- **Docker BuildKit** caching for faster builds
- **Image metadata** extraction
- **Automatic cleanup** of old images

#### 5.6 Deployment Script (Optional)
```bash
# Copy deployment script if using Kubernetes
# File: deploy-to-prod.sh
chmod +x deploy-to-prod.sh
```

Update script:
```bash
# Line 45: Update image name
IMAGE_NAME="registry.digitalocean.com/pioneer/hyperland:${IMAGE_TAG}"

# Line 87-90: Update deployment name
kubectl get deployment hyperland-xxx...
kubectl set image deployment/hyperland-xxx...

# Line 124: Update health endpoint
HEALTH=$(curl -s https://hyperland.io/health)
```

---

## 6. Environment Configuration Management

### Development (.env)
```bash
# Local development with PostgreSQL
WORLD=hyperland
PORT=4000
DB_URI=postgres://hyperland:hyperland_password@localhost:5432/hyperland_dev
ASSETS=local  # or s3 for testing
PUBLIC_URL=http://localhost:4000
PUBLIC_WS_URL=ws://localhost:4000/ws
PUBLIC_API_URL=http://localhost:4000/api
```

### Production (.env.production)
```bash
# Production with S3 and PostgreSQL
WORLD=hyperland
PORT=4000
DB_URI=postgres://user:pass@production-db-host:5432/hyperland_prod
DB_SCHEMA=public
ASSETS=s3
ASSETS_BASE_URL=https://hyperland.nyc3.cdn.digitaloceanspaces.com/assets
ASSETS_S3_URI=s3://KEY:SECRET@nyc3.digitaloceanspaces.com/hyperland/assets
PUBLIC_URL=https://hyperland.io
PUBLIC_WS_URL=wss://hyperland.io/ws
PUBLIC_API_URL=https://hyperland.io/api
TWITTER_CLIENT_ID=...
TWITTER_CLIENT_SECRET=...
JWT_SECRET=<generate-secure-secret>
ADMIN_CODE=<generate-secure-code>
```

### Docker Secrets (Production Best Practice)
For sensitive credentials in production, use:
- **Kubernetes Secrets**
- **DigitalOcean App Platform** environment variables
- **Docker Secrets** for Swarm
- **Vault** or other secret management tools

---

## 7. Migration Execution Timeline

### Phase 1: Database Migration (Day 1)
1. ✅ PostgreSQL already running via docker-compose
2. Copy `db.js` implementation
3. Install dependencies (`knex`, `pg`)
4. Test local PostgreSQL connection
5. Run migrations
6. Verify data integrity

### Phase 2: S3 Asset Migration (Day 2)
1. Copy S3 implementation files
2. Install dependencies (`@aws-sdk/client-s3`)
3. Test S3 connection
4. Sync existing local assets to S3
5. Switch `ASSETS=s3` in .env
6. Test asset upload/download

### Phase 3: Twitter Auth (Day 3)
1. Copy auth implementation
2. Install dependencies (`@auth/core`)
3. Add user table migrations
4. Set up Twitter app callback URLs
5. Test OAuth flow locally
6. Integrate with frontend

### Phase 4: Docker & CI/CD (Day 4)
1. Copy and customize Dockerfile
2. Test local Docker build
3. Set up DigitalOcean Container Registry
4. Configure GitHub Actions
5. Test automated builds
6. Deploy test version

### Phase 5: Production Deployment (Day 5)
1. Set up production database
2. Configure production S3 bucket
3. Update DNS/domain settings
4. Deploy to production
5. Monitor and validate
6. Set up backups

---

## 8. Testing Checklist

### Database
- [ ] PostgreSQL connection successful
- [ ] Migrations run without errors
- [ ] Data persists across restarts
- [ ] SQLite fallback works

### S3 Assets
- [ ] S3 bucket connection successful
- [ ] Asset upload works
- [ ] Asset download/CDN works
- [ ] Asset deduplication works
- [ ] Local fallback works

### Twitter Auth
- [ ] OAuth flow completes
- [ ] User data saves to database
- [ ] JWT tokens generate correctly
- [ ] Session persistence works
- [ ] Logout works

### Docker
- [ ] Image builds successfully
- [ ] Container starts and runs
- [ ] Health check passes
- [ ] Environment variables work
- [ ] Volume mounts work (if needed)

### CI/CD
- [ ] GitHub Actions triggers
- [ ] Image pushes to registry
- [ ] Version tagging works
- [ ] Deployment succeeds

---

## 9. Rollback Plan

### Database
```bash
# Switch back to SQLite
DB_URI=local

# Or restore from backup
psql -U hyperland -d hyperland_dev < backup.sql
```

### Assets
```bash
# Switch back to local storage
ASSETS=local
```

### Deployment
```bash
# Kubernetes rollback
kubectl rollout undo deployment/hyperland-xxx

# Or redeploy previous tag
kubectl set image deployment/hyperland-xxx hyperland=registry.../hyperland:v0.14.0
```

---

## 10. Monitoring & Observability

### Health Endpoints
```javascript
// Add to src/server/index.js
app.get('/health', (req, res) => {
  res.json({
    status: 'healthy',
    version: process.env.VERSION || 'unknown',
    commit: process.env.COMMIT_HASH || 'unknown',
    uptime: process.uptime(),
    database: db ? 'connected' : 'disconnected',
    assets: process.env.ASSETS
  })
})

app.get('/status', (req, res) => {
  res.json({ status: 'ok' })
})
```

### Logging
- Application logs: `kubectl logs -f deployment/hyperland-xxx`
- Database logs: `make db-logs`
- S3 access logs: Enable in DigitalOcean Spaces settings

### Metrics to Track
- Response times
- Database query performance
- S3 upload/download times
- WebSocket connection count
- Error rates
- User authentication success/failure

---

## 11. Security Considerations

### Secrets Management
- ✅ Never commit `.env` files
- ✅ Use `.env.example` for documentation
- ✅ Rotate secrets regularly
- ✅ Use strong JWT secrets (64+ characters)
- ✅ Use environment-specific credentials

### Database
- ✅ Use connection pooling
- ✅ Enable SSL for production
- ✅ Regular backups
- ✅ Least privilege access

### S3
- ✅ Use IAM/Spaces access keys (not root)
- ✅ Enable CDN for public assets
- ✅ Set appropriate CORS policies
- ✅ Enable versioning for critical assets

### Docker
- ✅ Non-root user in container
- ✅ Multi-stage builds
- ✅ Minimal base image (Alpine)
- ✅ Regular security updates

---

## 12. Cost Estimates (DigitalOcean)

### Spaces (S3)
- Storage: $5/month for 250GB
- Bandwidth: $0.01/GB after 1TB included

### Database
- Managed PostgreSQL: $15/month (1GB RAM, 10GB storage)
- OR: Self-hosted Droplet: $6/month (1GB RAM)

### Container Registry
- Free tier: 500MB storage
- Paid: $20/month for 10GB

### Compute (for hosting)
- App Platform: $5-12/month (Basic)
- Kubernetes: $12/month (1 node) + droplet costs

**Estimated Total**: $26-52/month depending on configuration

---

## Reference Implementation Files
Reference project structure (DegenCity) showing proven patterns:
```
reference-project/
├── Dockerfile                          # Multi-stage Docker build
├── .dockerignore                       # Docker ignore patterns
├── package.json                        # npm scripts for Docker
├── deploy-to-prod.sh                   # Deployment script
├── .github/workflows/
│   └── digitalocean.yml                # CI/CD pipeline
├── src/server/
│   ├── auth.js                         # Twitter OAuth implementation
│   ├── db.js                           # Database with migrations
│   ├── AssetsS3.js                     # S3 asset storage
│   ├── AssetsLocal.js                  # Local asset fallback
│   └── assets.js                       # Asset system router
└── scripts/
    ├── sync-s3.mjs                     # S3 sync utility
    └── s3-cleanup.js                   # S3 cleanup utility
```

---

## Next Steps

1. **Review this plan** with team
2. **Set up DigitalOcean resources**:
   - Container Registry
   - Spaces bucket for assets
   - Managed PostgreSQL (or droplet)
3. **Configure GitHub repository**:
   - Add `DIGITALOCEAN_TOKEN` secret
4. **Begin Phase 1** (Database Migration)
5. **Test each phase** thoroughly before proceeding
6. **Document any deviations** from plan

---

## Support & Documentation

- **Hyperfy Docs**: https://hyperfy.io/docs
- **Knex.js**: https://knexjs.org/
- **AWS SDK S3**: https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/clients/client-s3/
- **Twitter OAuth 2.0**: https://developer.twitter.com/en/docs/authentication/oauth-2-0
- **DigitalOcean**: https://docs.digitalocean.com/
- **Docker Multi-stage**: https://docs.docker.com/build/building/multi-stage/
