'use client';

import { MiniDex } from '@/components/MiniDex';

export default function BuyLandPage() {
  return (
    <div className="space-y-8 pb-8">
      {/* Hero Section */}
      <section className="text-center pt-8">
        <h1 className="text-5xl font-display font-bold mb-4 text-gradient-cyan-purple">
          Buy LAND Tokens
        </h1>
        <p className="text-xl text-white/70 mb-8">
          Exchange ETH for LAND tokens to purchase parcels in HyperLand
        </p>
      </section>

      {/* DEX Section */}
      <section className="max-w-md mx-auto">
        <MiniDex />
      </section>

      {/* Info Section */}
      <section className="max-w-4xl mx-auto">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div className="glass rounded-lg p-6 border border-cyan-500/30 flex items-start gap-4">
            <svg className="w-10 h-10 text-cyan-400 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            <div>
              <h3 className="text-lg font-bold text-cyan-400 mb-2">Fair Distribution</h3>
              <p className="text-sm text-white/70">
                80% of ETH goes to you in LAND tokens, 20% supports the ecosystem treasury
              </p>
            </div>
          </div>

          <div className="glass rounded-lg p-6 border border-purple-500/30 flex items-start gap-4">
            <svg className="w-10 h-10 text-purple-400 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
            </svg>
            <div>
              <h3 className="text-lg font-bold text-purple-400 mb-2">Use LAND Tokens</h3>
              <p className="text-sm text-white/70">
                Purchase land parcels, pay property taxes, and participate in the HyperLand economy
              </p>
            </div>
          </div>

          <div className="glass rounded-lg p-6 border border-pink-500/30 flex items-start gap-4">
            <svg className="w-10 h-10 text-pink-400 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 10V3L4 14h7v7l9-11h-7z" />
            </svg>
            <div>
              <h3 className="text-lg font-bold text-pink-400 mb-2">Instant Swap</h3>
              <p className="text-sm text-white/70">
                No waiting - swap ETH for LAND instantly and start buying parcels right away
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* How It Works */}
      <section className="max-w-4xl mx-auto">
        <h2 className="text-3xl font-display font-bold text-gradient-purple-pink mb-6 text-center">
          How It Works
        </h2>

        <div className="glass rounded-lg p-8 border border-white/20">
          <div className="space-y-6">
            <div className="flex items-start gap-4">
              <div className="w-10 h-10 rounded-full bg-gradient-to-br from-cyan-500 to-purple-600 flex items-center justify-center font-bold text-white flex-shrink-0">
                1
              </div>
              <div>
                <h4 className="font-bold text-white mb-1">Connect Your Wallet</h4>
                <p className="text-sm text-white/70">
                  Connect your Web3 wallet to get started. We support MetaMask, WalletConnect, and more.
                </p>
              </div>
            </div>

            <div className="flex items-start gap-4">
              <div className="w-10 h-10 rounded-full bg-gradient-to-br from-cyan-500 to-purple-600 flex items-center justify-center font-bold text-white flex-shrink-0">
                2
              </div>
              <div>
                <h4 className="font-bold text-white mb-1">Enter Amount</h4>
                <p className="text-sm text-white/70">
                  Enter the amount of ETH you want to swap, or the amount of LAND you want to receive.
                </p>
              </div>
            </div>

            <div className="flex items-start gap-4">
              <div className="w-10 h-10 rounded-full bg-gradient-to-br from-cyan-500 to-purple-600 flex items-center justify-center font-bold text-white flex-shrink-0">
                3
              </div>
              <div>
                <h4 className="font-bold text-white mb-1">Confirm Transaction</h4>
                <p className="text-sm text-white/70">
                  Review the swap details and confirm the transaction in your wallet.
                </p>
              </div>
            </div>

            <div className="flex items-start gap-4">
              <div className="w-10 h-10 rounded-full bg-gradient-to-br from-cyan-500 to-purple-600 flex items-center justify-center font-bold text-white flex-shrink-0">
                4
              </div>
              <div>
                <h4 className="font-bold text-white mb-1">Start Buying Parcels</h4>
                <p className="text-sm text-white/70">
                  Once confirmed, your LAND tokens will be available to purchase land parcels in the marketplace!
                </p>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* FAQ */}
      <section className="max-w-4xl mx-auto">
        <h2 className="text-3xl font-display font-bold text-gradient-cyan-purple mb-6 text-center">
          Frequently Asked Questions
        </h2>

        <div className="space-y-4">
          <div className="glass rounded-lg p-6 border border-white/20">
            <h4 className="font-bold text-white mb-2">What is LAND?</h4>
            <p className="text-sm text-white/70">
              LAND is the native utility token of HyperLand. It's used for all transactions within the ecosystem,
              including purchasing parcels, paying taxes, and trading on the marketplace.
            </p>
          </div>

          <div className="glass rounded-lg p-6 border border-white/20">
            <h4 className="font-bold text-white mb-2">What's the exchange rate?</h4>
            <p className="text-sm text-white/70">
              The current exchange rate is displayed in the swap interface above. Rates may vary based on market conditions.
            </p>
          </div>

          <div className="glass rounded-lg p-6 border border-white/20">
            <h4 className="font-bold text-white mb-2">Where does the 20% treasury fee go?</h4>
            <p className="text-sm text-white/70">
              The 20% treasury fee supports the HyperLand ecosystem, including development, maintenance,
              community events, and long-term sustainability of the platform.
            </p>
          </div>

          <div className="glass rounded-lg p-6 border border-white/20">
            <h4 className="font-bold text-white mb-2">Can I sell LAND back to ETH?</h4>
            <p className="text-sm text-white/70">
              Yes! You can swap LAND back to ETH at any time using the same interface.
              Simply adjust the swap direction by entering values in the LAND field.
            </p>
          </div>
        </div>
      </section>
    </div>
  );
}
