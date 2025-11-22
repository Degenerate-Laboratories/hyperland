'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { useHyperLand } from '@/lib/hyperland-context';
import { useBuyLand } from '@/lib/services/land-trading';
import { useLandPrice } from '@/lib/services/price-oracle';

export function MiniDex() {
  const router = useRouter();
  const { address, ethBalance, landBalance } = useHyperLand();
  const { buyLand, getQuote, isPending } = useBuyLand();
  const { landPriceUSD, landPriceETH, isLoading: priceLoading } = useLandPrice();

  const [ethAmount, setEthAmount] = useState('');
  const [isSwapping, setIsSwapping] = useState(false);

  // Get real quote from DEX
  const quote = ethAmount && parseFloat(ethAmount) > 0 ? getQuote(ethAmount) : null;

  const handleEthChange = (value: string) => {
    setEthAmount(value);
  };

  const handleSwap = async () => {
    if (!address) {
      alert('Please connect your wallet');
      return;
    }

    if (!ethAmount || parseFloat(ethAmount) <= 0) {
      alert('Please enter a valid ETH amount');
      return;
    }

    const ethValue = parseFloat(ethAmount);
    if (ethValue > parseFloat(ethBalance)) {
      alert('Insufficient ETH balance');
      return;
    }

    if (!quote) {
      alert('Unable to get price quote. Please try again.');
      return;
    }

    setIsSwapping(true);
    try {
      // This will prompt wallet for signature and wait for user approval
      const txHash = await buyLand(ethAmount, 500, address as `0x${string}`);

      const explorerUrl = `https://basescan.org/tx/${txHash}`;

      alert(
        `✅ Transaction Submitted to Base Mainnet!\n\n` +
        `Transaction Hash:\n${txHash}\n\n` +
        `Expected LAND: ${parseFloat(quote.amountOut).toFixed(2)} tokens\n\n` +
        `Verify on BaseScan:\n${explorerUrl}\n\n` +
        `Opening BaseScan in new tab...`
      );

      // Open BaseScan in new tab
      window.open(explorerUrl, '_blank');

      setEthAmount('');

      // Redirect to marketplace after successful purchase
      setTimeout(() => router.push('/marketplace'), 3000);
    } catch (error) {
      console.error('Swap failed:', error);
      const errorMessage = error instanceof Error ? error.message : 'Unknown error';

      if (errorMessage.includes('User rejected') || errorMessage.includes('User denied')) {
        alert('Transaction cancelled - You rejected the transaction in your wallet');
      } else {
        alert('Swap failed: ' + errorMessage);
      }
    } finally {
      setIsSwapping(false);
    }
  };

  return (
    <div className="glass rounded-lg p-6 border border-cyan-500/30">
      <div className="flex items-center justify-between mb-4">
        <h3 className="text-lg font-bold text-gradient-cyan-purple">Quick Swap</h3>
        <div className="text-xs text-white/60">
          {priceLoading ? (
            'Loading price...'
          ) : (
            <>
              ${landPriceUSD.toFixed(6)} / LAND
            </>
          )}
        </div>
      </div>

      <div className="space-y-3">
        {/* ETH Input */}
        <div className="glass-hover rounded-lg p-4 border border-white/10">
          <div className="flex items-center justify-between mb-2">
            <label className="text-xs text-white/60">You Pay</label>
            <div className="text-xs text-white/60">
              Balance: {parseFloat(ethBalance).toFixed(4)} ETH
            </div>
          </div>
          <div className="flex items-center gap-3">
            <input
              type="number"
              value={ethAmount}
              onChange={(e) => handleEthChange(e.target.value)}
              placeholder="0.0"
              step="0.000001"
              className="flex-1 bg-transparent text-2xl font-bold text-white outline-none"
            />
            <div className="flex items-center gap-2 px-3 py-2 bg-white/5 rounded-lg border border-white/10">
              <span className="text-sm font-bold text-white">ETH</span>
            </div>
          </div>
        </div>

        {/* Swap Arrow */}
        <div className="flex justify-center">
          <div className="w-10 h-10 rounded-full glass flex items-center justify-center border border-cyan-500/30">
            <svg className="w-5 h-5 text-cyan-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 14l-7 7m0 0l-7-7m7 7V3" />
            </svg>
          </div>
        </div>

        {/* LAND Output */}
        <div className="glass-hover rounded-lg p-4 border border-white/10">
          <div className="flex items-center justify-between mb-2">
            <label className="text-xs text-white/60">You Receive</label>
            <div className="text-xs text-white/60">
              Balance: {parseFloat(landBalance).toFixed(2)} LAND
            </div>
          </div>
          <div className="flex items-center gap-3">
            <div className="flex-1 text-2xl font-bold text-green-400">
              {quote ? parseFloat(quote.amountOut).toFixed(2) : '0.0'}
            </div>
            <div className="flex items-center gap-2 px-3 py-2 bg-gradient-to-br from-cyan-500/20 to-purple-600/20 rounded-lg border border-cyan-500/30">
              <span className="text-sm font-bold text-gradient-cyan-purple">LAND</span>
            </div>
          </div>
        </div>

        {/* Quote Details */}
        {quote && (
          <div className="glass-hover rounded-lg p-3 border border-white/10 space-y-2 text-xs">
            <div className="flex justify-between items-center text-white/70">
              <span>Minimum Received (5% slippage)</span>
              <span className="font-medium text-white">{parseFloat(quote.minimumReceived).toFixed(2)} LAND</span>
            </div>
            <div className="flex justify-between items-center text-white/70">
              <span>Price Impact</span>
              <span className={`font-medium ${quote.priceImpact > 10 ? 'text-red-400' : quote.priceImpact > 5 ? 'text-orange-400' : 'text-green-400'}`}>
                {quote.priceImpact.toFixed(2)}%
              </span>
            </div>
            {quote.priceImpact > 10 && (
              <div className="text-xs text-red-400 bg-red-500/10 p-2 rounded border border-red-500/30">
                ⚠️ High price impact! Consider buying a smaller amount.
              </div>
            )}
          </div>
        )}

        {/* Swap Button */}
        <button
          onClick={handleSwap}
          disabled={!address || isSwapping || !ethAmount || parseFloat(ethAmount) <= 0}
          className="w-full py-4 rounded-lg font-bold text-lg bg-gradient-to-br from-cyan-500 to-purple-600 hover:from-cyan-400 hover:to-purple-500 disabled:opacity-50 disabled:cursor-not-allowed text-white transition-all duration-200 uppercase tracking-wide"
        >
          {!address ? 'Connect Wallet' : isSwapping ? (
            <span className="flex items-center justify-center">
              <svg className="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
              </svg>
              Waiting for wallet...
            </span>
          ) : 'Swap Now'}
        </button>
      </div>

      {/* Info */}
      <div className="mt-4 pt-4 border-t border-white/10 space-y-2">
        <div className="flex items-center justify-between text-xs text-white/60">
          <span>DEX</span>
          <span className="text-cyan-400 font-medium">Aerodrome on Base</span>
        </div>
        <div className="flex items-center justify-between text-xs text-white/60">
          <span>Slippage Tolerance</span>
          <span>5%</span>
        </div>
      </div>
    </div>
  );
}
