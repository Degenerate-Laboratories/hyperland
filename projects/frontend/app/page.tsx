'use client';

import Link from "next/link";
import Image from "next/image";
import { useHyperLand } from '@/lib/hyperland-context';
import { WalletAuth } from '@/components/WalletAuth';

export default function Home() {
  return (
    <div className="space-y-8 pb-8">
      {/* Hero Section with Banner Image */}
      <section className="relative text-center rounded-lg mt-8 overflow-hidden">
        <div className="relative w-full h-[400px]">
          <Image
            src="/HyperBanner.png"
            alt="HyperLand Banner"
            fill
            priority
            className="object-cover"
          />
          <div className="absolute inset-0 bg-black/40 flex flex-col items-center justify-center">
            <h1 className="text-5xl font-bold mb-4 text-white">Welcome to HyperLand</h1>
            <p className="text-xl mb-8 text-white">
              Own, trade, and manage virtual land parcels on the blockchain
            </p>
            <div className="space-x-4">
              <Link
                href="/buy-land"
                className="bg-gradient-to-br from-green-500 to-emerald-600 hover:from-green-400 hover:to-emerald-500 text-white px-8 py-4 rounded-lg font-bold text-lg transition-all duration-200 inline-block shadow-lg hover:shadow-xl"
              >
                🪙 Buy LAND Tokens
              </Link>
              <Link
                href="/marketplace"
                className="bg-gradient-to-br from-cyan-500 to-purple-600 hover:from-cyan-400 hover:to-purple-500 text-white px-6 py-3 rounded-lg font-semibold transition-all duration-200 inline-block"
              >
                Explore Marketplace
              </Link>
              <Link
                href="/my-lands"
                className="bg-gradient-to-br from-cyan-500 to-purple-600 hover:from-cyan-400 hover:to-purple-500 text-white px-6 py-3 rounded-lg font-semibold transition-all duration-200 inline-block"
              >
                View My Lands
              </Link>
              <Link
                href="/brc-map"
                className="bg-gradient-to-br from-cyan-500 to-purple-600 hover:from-cyan-400 hover:to-purple-500 text-white px-6 py-3 rounded-lg font-semibold transition-all duration-200 inline-block"
              >
                View BRC Map
              </Link>
            </div>
          </div>
        </div>
      </section>

      {/* Features */}
      <section>
        <h2 className="text-3xl font-bold mb-6 text-white">How It Works</h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div className="glass rounded-lg p-6 border border-white/20 hover:border-cyan-400 transition-all duration-300">
            <h3 className="text-xl font-bold mb-2 text-white">1. Buy LAND Tokens</h3>
            <p className="text-white/80">
              Purchase LAND tokens with ETH. 80% goes to you, 20% to the treasury
              for ecosystem sustainability.
            </p>
          </div>
          <div className="glass rounded-lg p-6 border border-white/20 hover:border-cyan-400 transition-all duration-300">
            <h3 className="text-xl font-bold mb-2 text-white">2. Acquire Parcels</h3>
            <p className="text-white/80">
              Use LAND tokens to buy land parcels from the marketplace or other
              users. All transactions use LAND tokens.
            </p>
          </div>
          <div className="glass rounded-lg p-6 border border-white/20 hover:border-cyan-400 transition-all duration-300">
            <h3 className="text-xl font-bold mb-2 text-white">3. Manage & Trade</h3>
            <p className="text-white/80">
              Pay property taxes, list your parcels for sale, or hold long-term.
              Delinquent parcels go to auction!
            </p>
          </div>
        </div>
      </section>

      {/* Stats */}
      <section className="glass rounded-lg p-8 border border-white/20">
        <h2 className="text-3xl font-bold mb-6 text-center text-white">Platform Stats</h2>
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6 text-center">
          <div>
            <p className="text-4xl font-bold text-blue-400">1200</p>
            <p className="text-white/80">Total Parcels</p>
          </div>
          <div>
            <p className="text-4xl font-bold text-green-400">0</p>
            <p className="text-white/80">Active Owners</p>
          </div>
          <div>
            <p className="text-4xl font-bold text-purple-400">0</p>
            <p className="text-white/80">Parcels for Sale</p>
          </div>
          <div>
            <p className="text-4xl font-bold text-orange-400">0</p>
            <p className="text-white/80">Active Auctions</p>
          </div>
        </div>
      </section>

      {/* Authentication & World Entry */}
      <section className="text-center py-12">
        <h2 className="text-3xl font-bold mb-4 text-white">Ready to Enter HyperLand?</h2>
        <p className="text-xl text-white/80 mb-8">
          Connect your wallet and authenticate to enter the 3D world
        </p>
        <div className="max-w-md mx-auto">
          <WalletAuth />
        </div>
      </section>
    </div>
  );
}
