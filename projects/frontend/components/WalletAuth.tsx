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
          <ConnectButton />
        </div>
      ) : !authToken ? (
        <div className="space-y-4">
          <div className="glass p-4 rounded-lg border border-cyan-500/30 text-center">
            <p className="text-xs text-white/70">
              <strong className="text-cyan-400">Connected:</strong> {address?.slice(0, 6)}...{address?.slice(-4)}
            </p>
          </div>

          {error && (
            <div className="glass p-4 rounded-lg border border-red-500/50">
              <p className="text-sm text-red-400">{error}</p>
            </div>
          )}
        </div>
      ) : (
        <div className="space-y-4">
          <div className="glass p-6 rounded-lg border border-cyan-500/50 glow-cyan">
            <div className="flex items-start justify-between">
              <div className="w-full">
                <p className="text-sm font-bold text-cyan-400 flex items-center mb-3">
                  <svg className="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20">
                    <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" />
                  </svg>
                  Authenticated
                </p>
                <p className="text-xs text-white/80 space-y-1">
                  <span className="block"><strong className="text-white/60">Name:</strong> <span className="text-purple-400">{user.name}</span></span>
                  <span className="block"><strong className="text-white/60">Wallet:</strong> <span className="font-mono">{user.walletAddress.slice(0, 6)}...{user.walletAddress.slice(-4)}</span></span>
                  <span className="block"><strong className="text-white/60">Rank:</strong> <span className="text-cyan-400">{user.rank === 2 ? 'Admin' : user.rank === 1 ? 'Builder' : 'Visitor'}</span></span>
                </p>
              </div>
            </div>
          </div>

          <button
            onClick={handleEnterWorld}
            className="w-full bg-gradient-to-br from-cyan-500 to-purple-600 hover:from-cyan-400 hover:to-purple-500 text-white font-bold py-4 rounded-lg text-lg transition-all duration-200 transform hover:scale-105 uppercase tracking-wide glow-purple"
          >
            🌍 Enter HyperLand World
          </button>

          <button
            onClick={handleLogout}
            className="w-full glass-hover border border-white/20 text-white/80 hover:text-white py-3 rounded-lg text-sm font-semibold transition-all duration-200"
          >
            Sign Out
          </button>
        </div>
      )}
    </div>
  );
}
