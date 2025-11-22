'use client';

import { useState } from 'react';
import { useHyperLand } from '@/lib/hyperland-context';

export function MiniDex() {
  const { address, ethBalance, landBalance, buyLand } = useHyperLand();
  const [ethAmount, setEthAmount] = useState('');
  const [landAmount, setLandAmount] = useState('');
  const [isSwapping, setIsSwapping] = useState(false);

  // Exchange rate: 1 ETH = 1000 LAND (example rate)
  const EXCHANGE_RATE = 1000;

  const handleEthChange = (value: string) => {
    setEthAmount(value);
    const eth = parseFloat(value) || 0;
    setLandAmount((eth * EXCHANGE_RATE).toFixed(2));
  };

  const handleLandChange = (value: string) => {
    setLandAmount(value);
    const land = parseFloat(value) || 0;
    setEthAmount((land / EXCHANGE_RATE).toFixed(6));
  };

  const handleSwap = async () => {
    if (!address) {
      alert('Please connect your wallet');
      return;
    }

    if (!ethAmount || parseFloat(ethAmount) <= 0) {
      alert('Please enter a valid amount');
      return;
    }

    setIsSwapping(true);
    try {
      await buyLand(ethAmount);
      alert(`Successfully swapped ${ethAmount} ETH for ${landAmount} LAND!`);
      setEthAmount('');
      setLandAmount('');
    } catch (error) {
      console.error('Swap failed:', error);
      alert('Swap failed: ' + (error instanceof Error ? error.message : 'Unknown error'));
    } finally {
      setIsSwapping(false);
    }
  };

  return (
    <div className="glass rounded-lg p-6 border border-cyan-500/30">
      <div className="flex items-center justify-between mb-4">
        <h3 className="text-lg font-bold text-gradient-cyan-purple">Quick Swap</h3>
        <div className="text-xs text-white/60">
          1 ETH = {EXCHANGE_RATE} LAND
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
            <input
              type="number"
              value={landAmount}
              onChange={(e) => handleLandChange(e.target.value)}
              placeholder="0.0"
              className="flex-1 bg-transparent text-2xl font-bold text-white outline-none"
            />
            <div className="flex items-center gap-2 px-3 py-2 bg-gradient-to-br from-cyan-500/20 to-purple-600/20 rounded-lg border border-cyan-500/30">
              <span className="text-sm font-bold text-gradient-cyan-purple">LAND</span>
            </div>
          </div>
        </div>

        {/* Swap Button */}
        <button
          onClick={handleSwap}
          disabled={!address || isSwapping || !ethAmount || parseFloat(ethAmount) <= 0}
          className="w-full py-4 rounded-lg font-bold text-lg bg-gradient-to-br from-cyan-500 to-purple-600 hover:from-cyan-400 hover:to-purple-500 disabled:opacity-50 disabled:cursor-not-allowed text-white transition-all duration-200 uppercase tracking-wide"
        >
          {!address ? 'Connect Wallet' : isSwapping ? 'Swapping...' : 'Swap Now'}
        </button>
      </div>

      {/* Info */}
      <div className="mt-4 pt-4 border-t border-white/10">
        <div className="flex items-center justify-between text-xs text-white/60">
          <span>Treasury Split</span>
          <span>80% You • 20% Treasury</span>
        </div>
      </div>
    </div>
  );
}
