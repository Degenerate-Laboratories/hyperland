'use client';

import Link from "next/link";
import { useHyperLand } from '@/lib/hyperland-context';
import { WalletAuth } from '@/components/WalletAuth';

export default function Home() {
  const { stats, isMockMode, isConnected } = useHyperLand();

  return (
    <div className="space-y-8">
      {/* Hero Section */}
      <section className="text-center py-12 bg-gradient-to-r from-blue-500 to-purple-600 text-white rounded-lg">
        <h1 className="text-5xl font-bold mb-4">Welcome to HyperLand</h1>
        <p className="text-xl mb-8">
          Own, trade, and manage virtual land parcels on the blockchain
        </p>
        {isMockMode && (
          <p className="text-sm text-orange-200 mb-4">
            🟠 Running in mock mode - Connect wallet for blockchain features
          </p>
        )}
        <div className="space-x-4">
          <Link
            href="/buy-land"
            className="bg-white text-blue-600 px-6 py-3 rounded-lg font-semibold hover:bg-gray-100 inline-block"
          >
            Buy LAND Tokens
          </Link>
          <Link
            href="/marketplace"
            className="bg-blue-700 text-white px-6 py-3 rounded-lg font-semibold hover:bg-blue-800 inline-block"
          >
            Explore Marketplace
          </Link>
          <Link
            href="/my-lands"
            className="bg-blue-700 text-white px-6 py-3 rounded-lg font-semibold hover:bg-blue-800 inline-block"
          >
            View My Lands
          </Link>
        </div>
      </section>

      {/* Features */}
      <section>
        <h2 className="text-3xl font-bold mb-6">How It Works</h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div className="border rounded-lg p-6 bg-white dark:bg-gray-800">
            <h3 className="text-xl font-bold mb-2">1. Buy LAND Tokens</h3>
            <p className="text-gray-600 dark:text-gray-300">
              Purchase LAND tokens with ETH. 80% goes to you, 20% to the treasury
              for ecosystem sustainability.
            </p>
          </div>
          <div className="border rounded-lg p-6 bg-white dark:bg-gray-800">
            <h3 className="text-xl font-bold mb-2">2. Acquire Parcels</h3>
            <p className="text-gray-600 dark:text-gray-300">
              Use LAND tokens to buy land parcels from the marketplace or other
              users. All transactions use LAND tokens.
            </p>
          </div>
          <div className="border rounded-lg p-6 bg-white dark:bg-gray-800">
            <h3 className="text-xl font-bold mb-2">3. Manage & Trade</h3>
            <p className="text-gray-600 dark:text-gray-300">
              Pay property taxes, list your parcels for sale, or hold long-term.
              Delinquent parcels go to auction!
            </p>
          </div>
        </div>
      </section>

      {/* Stats */}
      <section className="bg-gray-100 dark:bg-gray-800 rounded-lg p-8">
        <h2 className="text-3xl font-bold mb-6 text-center">Platform Stats</h2>
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6 text-center">
          <div>
            <p className="text-4xl font-bold text-blue-600">{stats.totalParcels}</p>
            <p className="text-gray-600 dark:text-gray-300">Total Parcels</p>
          </div>
          <div>
            <p className="text-4xl font-bold text-green-600">{stats.activeOwners}</p>
            <p className="text-gray-600 dark:text-gray-300">Active Owners</p>
          </div>
          <div>
            <p className="text-4xl font-bold text-purple-600">{stats.listedParcels}</p>
            <p className="text-gray-600 dark:text-gray-300">Parcels for Sale</p>
          </div>
          <div>
            <p className="text-4xl font-bold text-orange-600">{stats.auctionParcels}</p>
            <p className="text-gray-600 dark:text-gray-300">Active Auctions</p>
          </div>
        </div>
      </section>

      {/* Authentication & World Entry */}
      <section className="text-center py-12">
        <h2 className="text-3xl font-bold mb-4">Ready to Enter HyperLand?</h2>
        <p className="text-xl text-gray-600 dark:text-gray-300 mb-8">
          Connect your wallet and authenticate to enter the 3D world
        </p>
        <div className="max-w-md mx-auto">
          <WalletAuth />
        </div>
      </section>
    </div>
  );
}
