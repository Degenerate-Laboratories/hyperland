'use client';

import { useState, useEffect } from 'react';
import { useAccount, useSignMessage } from 'wagmi';
import { ConnectButton } from '@rainbow-me/rainbowkit';

interface AuthUser {
  userId: string;
  walletAddress: string;
  rank: number;
  name: string;
  isNewUser: boolean;
}

export function WalletAuth() {
  const { address, isConnected } = useAccount();
  const { signMessageAsync } = useSignMessage();
  const [authToken, setAuthToken] = useState<string | null>(null);
  const [user, setUser] = useState<AuthUser | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Check for existing auth token on mount
  useEffect(() => {
    const storedToken = localStorage.getItem('authToken');
    const storedUser = localStorage.getItem('authUser');

    if (storedToken && storedUser) {
      setAuthToken(storedToken);
      setUser(JSON.parse(storedUser));
    }
  }, []);

  const handleAuth = async () => {
    if (!address) return;

    setLoading(true);
    setError(null);

    try {
      // 1. Get challenge from backend
      const challengeRes = await fetch('/api/auth/challenge', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ address }),
      });

      if (!challengeRes.ok) {
        throw new Error('Failed to get challenge');
      }

      const { message, nonce } = await challengeRes.json();

      // 2. Sign message with wallet
      const signature = await signMessageAsync({ message });

      // 3. Verify signature and get JWT
      const verifyRes = await fetch('/api/auth/verify', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ address, signature, message }),
      });

      if (!verifyRes.ok) {
        const errorData = await verifyRes.json();
        throw new Error(errorData.error || 'Verification failed');
      }

      const { authToken: token, user: userData } = await verifyRes.json();

      // 4. Store auth data
      setAuthToken(token);
      setUser(userData);
      localStorage.setItem('authToken', token);
      localStorage.setItem('authUser', JSON.stringify(userData));

      console.log('✅ Authenticated:', userData);
    } catch (err: any) {
      console.error('Authentication failed:', err);
      setError(err.message || 'Authentication failed');
    } finally {
      setLoading(false);
    }
  };

  const handleLogout = () => {
    setAuthToken(null);
    setUser(null);
    localStorage.removeItem('authToken');
    localStorage.removeItem('authUser');
  };

  const handleEnterWorld = () => {
    if (!authToken || !user) return;

    const hyperfyUrl = process.env.NEXT_PUBLIC_HYPERFY_URL || 'http://localhost:3000';
    const url = `${hyperfyUrl}/?authToken=${encodeURIComponent(authToken)}&playAs=${encodeURIComponent(user.userId)}`;

    window.location.href = url;
  };

  return (
    <div className="space-y-4">
      {!isConnected ? (
        <div className="text-center">
          <p className="text-gray-600 dark:text-gray-300 mb-4">
            Connect your wallet to authenticate
          </p>
          <ConnectButton />
        </div>
      ) : !authToken ? (
        <div className="space-y-4">
          <div className="bg-blue-50 dark:bg-blue-900/20 p-4 rounded-lg">
            <p className="text-sm text-gray-700 dark:text-gray-300">
              <strong>Connected:</strong> {address?.slice(0, 6)}...{address?.slice(-4)}
            </p>
            <p className="text-xs text-gray-600 dark:text-gray-400 mt-2">
              Sign a message to prove wallet ownership (no gas fees)
            </p>
          </div>

          {error && (
            <div className="bg-red-50 dark:bg-red-900/20 p-4 rounded-lg">
              <p className="text-sm text-red-600 dark:text-red-400">{error}</p>
            </div>
          )}

          <button
            onClick={handleAuth}
            disabled={loading}
            className="w-full bg-blue-600 hover:bg-blue-700 disabled:bg-gray-400 disabled:cursor-not-allowed text-white font-semibold py-3 rounded-lg transition-colors"
          >
            {loading ? (
              <span className="flex items-center justify-center">
                <svg className="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                  <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                  <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                </svg>
                Signing...
              </span>
            ) : (
              'Sign to Authenticate'
            )}
          </button>

          <button
            onClick={handleLogout}
            className="w-full bg-gray-600 hover:bg-gray-700 text-white py-2 rounded-lg text-sm"
          >
            Disconnect Wallet
          </button>
        </div>
      ) : (
        <div className="space-y-4">
          <div className="bg-green-50 dark:bg-green-900/20 p-4 rounded-lg border border-green-200 dark:border-green-800">
            <div className="flex items-start justify-between">
              <div>
                <p className="text-sm font-semibold text-green-900 dark:text-green-100 flex items-center">
                  <svg className="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20">
                    <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" />
                  </svg>
                  Authenticated
                </p>
                <p className="text-xs text-gray-700 dark:text-gray-300 mt-2">
                  <strong>Name:</strong> {user?.name}
                  <br />
                  <strong>Wallet:</strong> {user?.walletAddress.slice(0, 6)}...{user?.walletAddress.slice(-4)}
                  <br />
                  <strong>Rank:</strong> {user?.rank === 2 ? 'Admin' : user?.rank === 1 ? 'Builder' : 'Visitor'}
                </p>
              </div>
            </div>
          </div>

          <button
            onClick={handleEnterWorld}
            className="w-full bg-gradient-to-r from-purple-600 to-blue-600 hover:from-purple-700 hover:to-blue-700 text-white font-bold py-4 rounded-lg text-lg transition-all transform hover:scale-105"
          >
            🌍 Enter HyperLand World
          </button>

          <button
            onClick={handleLogout}
            className="w-full bg-gray-600 hover:bg-gray-700 text-white py-2 rounded-lg text-sm"
          >
            Sign Out
          </button>
        </div>
      )}
    </div>
  );
}
