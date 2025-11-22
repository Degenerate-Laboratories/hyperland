# Twitter Authentication Integration

Twitter (X) OAuth 2.0 authentication has been successfully integrated into Hyperland from the degen-city project.

## What Was Added

### Backend Components

1. **`src/server/auth.js`** - Twitter OAuth 2.0 authentication module
   - PKCE-based OAuth flow for enhanced security
   - State parameter validation for CSRF protection
   - User creation/update with Twitter profile data
   - JWT token generation and verification

2. **Server Endpoints** (`src/server/index.js`)
   - `GET /api/auth/twitter` - Initiates OAuth flow
   - `GET /api/auth/callback/twitter` - Handles OAuth callback

3. **Database Migration** (already exists in `src/server/db.js`, migration #17)
   - `provider` - Authentication provider (twitter/local)
   - `providerId` - Twitter user ID
   - `email` - User email (if available)
   - `profileImage` - Twitter profile image URL
   - `lastLogin` - Last login timestamp

### Frontend Components

1. **`src/client/components/TwitterLogin.js`** - Login UI component
   - Minimal, unobtrusive "Sign in with X" button
   - Positioned in top-right corner
   - Auto-handles OAuth callback and token storage
   - Hides when user is authenticated

2. **Integration** (`src/client/components/CoreUI.js`)
   - TwitterLogin component added to main UI
   - Only shows when user is not authenticated

## Setup Instructions

### 1. Create a Twitter App

1. Go to [Twitter Developer Portal](https://developer.twitter.com/en/portal/dashboard)
2. Create a new app or select an existing one
3. Navigate to your app's settings
4. Under "User authentication settings", click "Set up"
5. Configure:
   - **App permissions**: Read
   - **Type of App**: Web App
   - **Callback URI**: `http://localhost:3000/api/auth/callback/twitter` (for dev)
   - **Website URL**: Your website URL

### 2. Configure Environment Variables

Add to your `.env` file:

```env
TWITTER_CLIENT_ID=your_twitter_client_id_here
TWITTER_CLIENT_SECRET=your_twitter_client_secret_here
PUBLIC_URL=http://localhost:3000
```

### 3. For Production Deployment

1. Update `PUBLIC_URL` in `.env` to your production domain
2. Add production callback URL in Twitter app settings:
   - `https://yourdomain.com/api/auth/callback/twitter`
3. Keep localhost URL for local development

## How It Works

### Authentication Flow

1. User clicks "Sign in with X" button
2. Redirected to Twitter authorization page
3. User authorizes the app
4. Twitter redirects back to `/api/auth/callback/twitter`
5. Server exchanges auth code for access token (with PKCE verification)
6. Server fetches Twitter user profile
7. Server creates/updates user in database
8. Server generates JWT token
9. Client receives token via URL parameter
10. Client stores token in localStorage
11. Page reloads with authenticated session

### Security Features

- **PKCE (Proof Key for Code Exchange)** - Protects against authorization code interception
- **State Parameter** - Prevents CSRF attacks
- **JWT Tokens** - Secure session management with 30-day expiration
- **HTTPS Required** - Production should always use HTTPS

## User Experience

- Clean, minimal UI that doesn't obstruct gameplay
- Button appears in top-right corner only when not authenticated
- Seamless login flow with automatic redirect
- Token persists across sessions in localStorage

## Database Schema

Twitter users are stored in the `users` table with:
- `id` - Unique user ID (UUID)
- `name` - Twitter display name or username
- `provider` - Set to 'twitter'
- `providerId` - Twitter user ID
- `email` - Email (if available from Twitter)
- `profileImage` - Twitter profile picture URL
- `avatar` - Custom VRM avatar (nullable)
- `rank` - User rank/role
- `createdAt` - Account creation timestamp
- `lastLogin` - Last login timestamp

## Future Enhancements

Potential improvements:
1. Profile display in UI showing Twitter avatar
2. Link Twitter to existing accounts
3. Add more OAuth providers (Discord, Google, etc.)
4. Refresh token support for long-lived sessions
5. Role-based permissions for Twitter verified users

## Testing

### Local Testing

1. Start the server: `npm run dev`
2. Open `http://localhost:3000`
3. Click "Sign in with X"
4. Authorize the app on Twitter
5. Verify successful authentication and redirect

### Verify Database

Check the `users` table for new Twitter-authenticated users with `provider='twitter'`.

## Troubleshooting

**"Invalid callback URL" error**
- Ensure callback URL in `.env` matches Twitter app settings exactly
- Check that `PUBLIC_URL` is set correctly

**"Failed to exchange code for token" error**
- Verify Client ID and Client Secret are correct
- Check app permissions in Twitter Developer Portal

**User not staying logged in**
- Verify `JWT_SECRET` is set in `.env`
- Check browser console for errors
- Ensure localStorage is not being cleared

## Files Changed

- ✅ Created: `src/server/auth.js`
- ✅ Modified: `src/server/index.js`
- ✅ Created: `src/client/components/TwitterLogin.js`
- ✅ Modified: `src/client/components/CoreUI.js`
- ✅ Modified: `.env.example`
- ✅ Exists: Database migration in `src/server/db.js` (migration #17)

## References

- [Twitter OAuth 2.0 Documentation](https://developer.twitter.com/en/docs/authentication/oauth-2-0)
- [PKCE RFC 7636](https://tools.ietf.org/html/rfc7636)
- Original implementation: `/Users/highlander/gamedev/degencity/projects/degen-city`
