'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { ConnectButton } from '@rainbow-me/rainbowkit';
import { useHyperLand } from '@/lib/hyperland-context';
import { usePurchaseParcel, useBondingCurveStats } from '@/lib/services/parcel-sale';
import { formatEther } from 'viem';

export default function BuyLandPage() {
  const router = useRouter();
  const { isConnected, address } = useHyperLand();
  const { purchaseParcel, currentPrice, currentPriceETH, isPending } = usePurchaseParcel();
  const { stats } = useBondingCurveStats();
  const [isPurchasing, setIsPurchasing] = useState(false);

  const handlePurchase = async () => {
    if (!address || !isConnected) {
      alert('Please connect your wallet first');
      return;
    }

    if (!currentPrice) {
      alert('Unable to fetch current price. Please try again.');
      return;
    }

    setIsPurchasing(true);
    try {
      // Purchase next available HyperDeed
      const txHash = await purchaseParcel(0);

      const explorerUrl = `https://basescan.org/tx/${txHash}`;

      alert(
        `✅ HyperDeed Purchase Submitted!\n\n` +
        `Transaction Hash:\n${txHash}\n\n` +
        `Price Paid: ${currentPriceETH} ETH\n\n` +
        `Verify on BaseScan:\n${explorerUrl}\n\n` +
        `Opening BaseScan in new tab...`
      );

      window.open(explorerUrl, '_blank');

      // Redirect to my-lands after successful purchase
      setTimeout(() => router.push('/my-lands'), 3000);
    } catch (error) {
      console.error('Purchase failed:', error);
      const errorMessage = error instanceof Error ? error.message : 'Unknown error';

      if (errorMessage.includes('User rejected') || errorMessage.includes('User denied')) {
        alert('Transaction cancelled - You rejected the transaction in your wallet');
      } else {
        alert('Purchase failed: ' + errorMessage);
      }
    } finally {
      setIsPurchasing(false);
    }
  };

  // Calculate phase info
  const getPhaseInfo = () => {
    if (!stats) return { phase: 1, description: 'Loading...', progress: 0 };

    if (stats.soldCount < 100) {
      return {
        phase: 1,
        description: `Phase 1: Early Discovery ($0.50 → $300)`,
        progress: (stats.soldCount / 100) * 100
      };
    } else if (stats.soldCount < 500) {
      return {
        phase: 2,
        description: `Phase 2: Rapid Expansion ($300 → $1,000)`,
        progress: ((stats.soldCount - 100) / 400) * 100
      };
    } else {
      return {
        phase: 3,
        description: `Phase 3: Steady Growth (~$9/deed)`,
        progress: 100
      };
    }
  };

  const phaseInfo = getPhaseInfo();

  return (
    <div className="space-y-8 pb-8">
      {/* Hero Section */}
      <section className="text-center pt-8">
        <h1 className="text-5xl font-display font-bold mb-4 text-gradient-cyan-purple">
          Buy HyperDeeds
        </h1>
        <p className="text-xl text-white/70 mb-8">
          Own land in HyperLand with bonding curve pricing
        </p>
      </section>

      {/* Bonding Curve Purchase Section */}
      <section className="max-w-md mx-auto">
        <div className="glass rounded-lg p-6 border border-cyan-500/30">
          <div className="flex items-center justify-between mb-4">
            <h3 className="text-lg font-bold text-gradient-cyan-purple">Next Deed Price</h3>
            <div className="text-xs text-white/60">
              {stats ? `${stats.soldCount} / ${stats.totalParcels} sold` : 'Loading...'}
            </div>
          </div>

          <div className="space-y-4">
            {/* Current Price Display */}
            <div className="glass-hover rounded-lg p-6 border border-white/10 text-center">
              <div className="text-sm text-white/60 mb-2">Current Price</div>
              <div className="text-4xl font-bold text-gradient-cyan-purple mb-1">
                {currentPrice ? `${parseFloat(currentPriceETH).toFixed(6)} ETH` : 'Loading...'}
              </div>
              {currentPrice && (
                <div className="text-xs text-white/50">
                  ≈ ${(parseFloat(currentPriceETH) * 3000).toFixed(2)} USD @ $3,000/ETH
                </div>
              )}
            </div>

            {/* Phase Progress */}
            {stats && (
              <div className="glass-hover rounded-lg p-4 border border-white/10">
                <div className="flex items-center justify-between mb-2">
                  <span className="text-xs text-white/60">{phaseInfo.description}</span>
                  <span className="text-xs text-cyan-400 font-medium">Phase {phaseInfo.phase}</span>
                </div>
                <div className="w-full bg-white/10 rounded-full h-2">
                  <div
                    className="bg-gradient-to-r from-cyan-500 to-purple-600 h-2 rounded-full transition-all duration-500"
                    style={{ width: `${phaseInfo.progress}%` }}
                  />
                </div>
              </div>
            )}

            {/* Connect or Purchase Button */}
            {!isConnected ? (
              <div className="text-center">
                <ConnectButton />
              </div>
            ) : (
              <button
                onClick={handlePurchase}
                disabled={isPurchasing || !currentPrice}
                className="w-full py-4 rounded-lg font-bold text-lg bg-gradient-to-br from-cyan-500 to-purple-600 hover:from-cyan-400 hover:to-purple-500 disabled:opacity-50 disabled:cursor-not-allowed text-white transition-all duration-200 uppercase tracking-wide"
              >
                {isPurchasing ? (
                  <span className="flex items-center justify-center">
                    <svg className="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                      <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                      <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                    </svg>
                    Processing...
                  </span>
                ) : (
                  'Purchase HyperDeed'
                )}
              </button>
            )}

            {/* Stats */}
            {stats && stats.totalETHCollected !== undefined && stats.totalLiquidityCreated !== undefined && (
              <div className="pt-4 border-t border-white/10 space-y-2 text-xs">
                <div className="flex items-center justify-between text-white/60">
                  <span>Total ETH Collected</span>
                  <span className="text-cyan-400 font-medium">
                    {parseFloat(formatEther(stats.totalETHCollected || 0n)).toFixed(4)} ETH
                  </span>
                </div>
                <div className="flex items-center justify-between text-white/60">
                  <span>Liquidity Created</span>
                  <span className="text-purple-400 font-medium">
                    {parseFloat(formatEther(stats.totalLiquidityCreated || 0n)).toFixed(4)} ETH
                  </span>
                </div>
              </div>
            )}
          </div>
        </div>
      </section>

      {/* Info Section */}
      <section className="max-w-4xl mx-auto">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div className="glass rounded-lg p-6 border border-cyan-500/30 flex items-start gap-4">
            <svg className="w-10 h-10 text-cyan-400 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6" />
            </svg>
            <div>
              <h3 className="text-lg font-bold text-cyan-400 mb-2">Bonding Curve</h3>
              <p className="text-sm text-white/70">
                Fair price discovery through exponential bonding curve. Early buyers get better prices!
              </p>
            </div>
          </div>

          <div className="glass rounded-lg p-6 border border-purple-500/30 flex items-start gap-4">
            <svg className="w-10 h-10 text-purple-400 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
            </svg>
            <div>
              <h3 className="text-lg font-bold text-purple-400 mb-2">Own Virtual Land</h3>
              <p className="text-sm text-white/70">
                Each HyperDeed is a unique NFT representing ownership of virtual land in HyperLand
              </p>
            </div>
          </div>

          <div className="glass rounded-lg p-6 border border-pink-500/30 flex items-start gap-4">
            <svg className="w-10 h-10 text-pink-400 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            <div>
              <h3 className="text-lg font-bold text-pink-400 mb-2">Automatic Liquidity</h3>
              <p className="text-sm text-white/70">
                50% of your payment adds liquidity to LAND/ETH pool, permanently locked via LP burn
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
                <h4 className="font-bold text-white mb-1">Check Current Price</h4>
                <p className="text-sm text-white/70">
                  See the current price for the next HyperDeed. Prices increase with each sale following the bonding curve.
                </p>
              </div>
            </div>

            <div className="flex items-start gap-4">
              <div className="w-10 h-10 rounded-full bg-gradient-to-br from-cyan-500 to-purple-600 flex items-center justify-center font-bold text-white flex-shrink-0">
                3
              </div>
              <div>
                <h4 className="font-bold text-white mb-1">Purchase HyperDeed</h4>
                <p className="text-sm text-white/70">
                  Click purchase and confirm the transaction in your wallet. Your HyperDeed NFT will be minted instantly.
                </p>
              </div>
            </div>

            <div className="flex items-start gap-4">
              <div className="w-10 h-10 rounded-full bg-gradient-to-br from-cyan-500 to-purple-600 flex items-center justify-center font-bold text-white flex-shrink-0">
                4
              </div>
              <div>
                <h4 className="font-bold text-white mb-1">Start Building</h4>
                <p className="text-sm text-white/70">
                  Your HyperDeed grants you ownership of virtual land. Build, trade, and participate in the HyperLand metaverse!
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
            <h4 className="font-bold text-white mb-2">What is a HyperDeed?</h4>
            <p className="text-sm text-white/70">
              A HyperDeed is an NFT representing ownership of virtual land in HyperLand. Each deed is unique
              and gives you full control over your parcel in the metaverse.
            </p>
          </div>

          <div className="glass rounded-lg p-6 border border-white/20">
            <h4 className="font-bold text-white mb-2">How does the bonding curve work?</h4>
            <p className="text-sm text-white/70">
              Prices start at ~$0.50 and increase exponentially as more deeds are sold. Phase 1 (0-100): $0.50 → $300,
              Phase 2 (100-500): $300 → $1,000, Phase 3 (500+): Linear growth at ~$9 per deed.
            </p>
          </div>

          <div className="glass rounded-lg p-6 border border-white/20">
            <h4 className="font-bold text-white mb-2">Where does my ETH payment go?</h4>
            <p className="text-sm text-white/70">
              50% of your payment is used to buy LAND tokens for your assessed value. The other 50% creates
              permanent liquidity in the LAND/ETH pool (LP tokens are burned).
            </p>
          </div>

          <div className="glass rounded-lg p-6 border border-white/20">
            <h4 className="font-bold text-white mb-2">Can I sell my HyperDeed later?</h4>
            <p className="text-sm text-white/70">
              Yes! HyperDeeds are NFTs that can be traded on the marketplace or any NFT platform.
              You fully own your deed and can sell it whenever you want.
            </p>
          </div>
        </div>
      </section>
    </div>
  );
}
