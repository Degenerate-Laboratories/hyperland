'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { useHyperLand } from '@/lib/hyperland-context';
import { ConnectButton } from '@rainbow-me/rainbowkit';

export default function BuyLand() {
  const router = useRouter();
  const { buyLAND, landBalance, ethBalance, isConnected, address, isMockMode } = useHyperLand();

  const [ethAmount, setEthAmount] = useState('');
  const [isProcessing, setIsProcessing] = useState(false);

  // Calculate LAND tokens to receive (80% of 1000 LAND per ETH)
  const landToReceive = ethAmount ? (parseFloat(ethAmount) * 1000 * 0.8).toFixed(2) : '0';
  const protocolFee = ethAmount ? (parseFloat(ethAmount) * 1000 * 0.2).toFixed(2) : '0';

  async function handleBuy() {
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

    setIsProcessing(true);

    try {
      await buyLAND(ethAmount);
      alert(`Successfully purchased ${landToReceive} LAND tokens!`);
      setEthAmount('');

      // Redirect to marketplace after successful purchase
      router.push('/marketplace');
    } catch (error) {
      console.error('Purchase failed:', error);
      alert('Purchase failed: ' + (error instanceof Error ? error.message : 'Unknown error'));
    } finally {
      setIsProcessing(false);
    }
  }

  return (
    <div className="max-w-2xl mx-auto space-y-6">
      {/* Header */}
      <div className="text-center">
        <h1 className="text-4xl font-bold mb-4">Buy LAND Tokens</h1>
        <p className="text-xl text-gray-600 dark:text-gray-300">
          Purchase LAND tokens with ETH to buy land parcels
        </p>
        {isMockMode && (
          <p className="text-sm text-orange-600 mt-2">
            🟠 Running in mock mode (simulated transactions)
          </p>
        )}
      </div>

      {/* Wallet Connection Required */}
      {!isConnected ? (
        <div className="bg-white dark:bg-gray-800 rounded-lg p-8 text-center border-2 border-dashed border-gray-300 dark:border-gray-600">
          <h2 className="text-2xl font-bold mb-4">Connect Your Wallet</h2>
          <p className="text-gray-600 dark:text-gray-300 mb-6">
            You need to connect your wallet to purchase LAND tokens
          </p>
          <ConnectButton />
        </div>
      ) : (
        <>
          {/* Balance Display */}
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div className="bg-gradient-to-br from-blue-500 to-purple-600 text-white rounded-lg p-6">
              <p className="text-sm opacity-90 mb-1">Your LAND Balance</p>
              <p className="text-3xl font-bold">{parseFloat(landBalance).toLocaleString()} LAND</p>
            </div>
            <div className="bg-gradient-to-br from-green-500 to-teal-600 text-white rounded-lg p-6">
              <p className="text-sm opacity-90 mb-1">Your ETH Balance</p>
              <p className="text-3xl font-bold">{parseFloat(ethBalance).toFixed(4)} ETH</p>
            </div>
          </div>

          {/* Purchase Form */}
          <div className="bg-white dark:bg-gray-800 rounded-lg p-8 border border-gray-200 dark:border-gray-700">
            <h2 className="text-2xl font-bold mb-6">Purchase LAND Tokens</h2>

            {/* ETH Input */}
            <div className="mb-6">
              <label className="block text-sm font-medium mb-2">
                Amount (ETH)
              </label>
              <div className="relative">
                <input
                  type="number"
                  min="0"
                  step="0.01"
                  value={ethAmount}
                  onChange={(e) => setEthAmount(e.target.value)}
                  placeholder="0.0"
                  className="w-full px-4 py-3 rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                  disabled={isProcessing}
                />
                <button
                  onClick={() => setEthAmount(ethBalance)}
                  className="absolute right-3 top-1/2 -translate-y-1/2 text-sm font-medium text-blue-600 hover:text-blue-700"
                  disabled={isProcessing}
                >
                  MAX
                </button>
              </div>
            </div>

            {/* Conversion Display */}
            <div className="bg-gray-50 dark:bg-gray-900 rounded-lg p-6 mb-6 space-y-3">
              <div className="flex justify-between items-center">
                <span className="text-gray-600 dark:text-gray-400">Exchange Rate</span>
                <span className="font-semibold">1 ETH = 1,000 LAND</span>
              </div>
              <div className="border-t border-gray-200 dark:border-gray-700 pt-3">
                <div className="flex justify-between items-center mb-2">
                  <span className="text-gray-600 dark:text-gray-400">You Receive (80%)</span>
                  <span className="font-semibold text-green-600">{landToReceive} LAND</span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-gray-600 dark:text-gray-400">Protocol Fee (20%)</span>
                  <span className="font-semibold text-gray-500">{protocolFee} LAND</span>
                </div>
              </div>
            </div>

            {/* Purchase Button */}
            <button
              onClick={handleBuy}
              disabled={isProcessing || !ethAmount || parseFloat(ethAmount) <= 0}
              className="w-full bg-blue-600 hover:bg-blue-700 disabled:bg-gray-400 disabled:cursor-not-allowed text-white font-semibold py-4 rounded-lg text-lg transition-colors"
            >
              {isProcessing ? (
                <span className="flex items-center justify-center">
                  <svg className="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                    <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                    <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                  </svg>
                  Processing...
                </span>
              ) : (
                'Buy LAND Tokens'
              )}
            </button>
          </div>

          {/* Info Section */}
          <div className="bg-blue-50 dark:bg-blue-900/20 rounded-lg p-6 border border-blue-200 dark:border-blue-800">
            <h3 className="text-lg font-bold mb-3 flex items-center">
              <svg className="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20">
                <path fillRule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clipRule="evenodd" />
              </svg>
              How It Works
            </h3>
            <ul className="space-y-2 text-sm text-gray-700 dark:text-gray-300">
              <li className="flex items-start">
                <span className="mr-2">•</span>
                <span>Exchange ETH for LAND tokens at a fixed rate of 1 ETH = 1,000 LAND</span>
              </li>
              <li className="flex items-start">
                <span className="mr-2">•</span>
                <span>You receive 80% of the LAND tokens (800 per ETH)</span>
              </li>
              <li className="flex items-start">
                <span className="mr-2">•</span>
                <span>20% goes to the protocol treasury for ecosystem sustainability</span>
              </li>
              <li className="flex items-start">
                <span className="mr-2">•</span>
                <span>Use LAND tokens to purchase land parcels and pay property taxes</span>
              </li>
            </ul>
          </div>
        </>
      )}
    </div>
  );
}
