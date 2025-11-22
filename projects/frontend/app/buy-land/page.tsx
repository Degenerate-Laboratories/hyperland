'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { useHyperLand } from '@/lib/hyperland-context';
import { ConnectButton } from '@rainbow-me/rainbowkit';
import { useBuyLand } from '@/lib/services/land-trading';
import { useLandPrice } from '@/lib/services/price-oracle';

export default function BuyLand() {
  const router = useRouter();
  const { landBalance, ethBalance, isConnected, address } = useHyperLand();
  const { buyLand, getQuote, isPending } = useBuyLand();
  const { landPriceUSD, landPriceETH, isLoading: priceLoading, error: priceError } = useLandPrice();

  const [ethAmount, setEthAmount] = useState('');
  const [isProcessing, setIsProcessing] = useState(false);

  // Get real quote from DEX
  const quote = ethAmount && parseFloat(ethAmount) > 0 ? getQuote(ethAmount) : null;

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

    if (!quote) {
      alert('Unable to get price quote. Please try again.');
      return;
    }

    setIsProcessing(true);

    try {
      // This will prompt wallet for signature and wait for user approval
      const txHash = await buyLand(ethAmount, 500, address as `0x${string}`);

      // Only reaches here if transaction was signed and submitted
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
      console.error('Purchase failed:', error);

      // Show detailed error message
      const errorMessage = error instanceof Error ? error.message : 'Unknown error';

      if (errorMessage.includes('User rejected') || errorMessage.includes('User denied')) {
        alert('Transaction cancelled - You rejected the transaction in your wallet');
      } else {
        alert('Purchase failed: ' + errorMessage);
      }
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

            {/* Live Market Price */}
            <div className="bg-blue-50 dark:bg-blue-900/20 rounded-lg p-4 mb-6">
              <div className="flex justify-between items-center">
                <span className="text-sm text-gray-600 dark:text-gray-400">💰 Live Market Price</span>
                {priceLoading ? (
                  <span className="text-sm">Loading...</span>
                ) : priceError ? (
                  <span className="text-sm text-red-600">{priceError}</span>
                ) : (
                  <span className="font-semibold">
                    ${landPriceUSD.toFixed(6)} / LAND ({landPriceETH.toExponential(2)} ETH)
                  </span>
                )}
              </div>
            </div>

            {/* Swap Quote */}
            <div className="bg-gray-50 dark:bg-gray-900 rounded-lg p-6 mb-6 space-y-3">
              {quote ? (
                <>
                  <div className="flex justify-between items-center">
                    <span className="text-gray-600 dark:text-gray-400">You Receive</span>
                    <span className="font-semibold text-green-600 text-lg">
                      {parseFloat(quote.amountOut).toFixed(2)} LAND
                    </span>
                  </div>
                  <div className="border-t border-gray-200 dark:border-gray-700 pt-3 space-y-2">
                    <div className="flex justify-between items-center text-sm">
                      <span className="text-gray-600 dark:text-gray-400">Minimum Received (5% slippage)</span>
                      <span className="font-medium">{parseFloat(quote.minimumReceived).toFixed(2)} LAND</span>
                    </div>
                    <div className="flex justify-between items-center text-sm">
                      <span className="text-gray-600 dark:text-gray-400">Price Impact</span>
                      <span className={`font-medium ${quote.priceImpact > 10 ? 'text-red-600' : quote.priceImpact > 5 ? 'text-orange-600' : 'text-green-600'}`}>
                        {quote.priceImpact.toFixed(2)}%
                      </span>
                    </div>
                    <div className="flex justify-between items-center text-sm">
                      <span className="text-gray-600 dark:text-gray-400">Rate</span>
                      <span className="font-medium">
                        1 ETH = {(parseFloat(quote.amountOut) / parseFloat(ethAmount)).toFixed(2)} LAND
                      </span>
                    </div>
                  </div>
                  {quote.priceImpact > 10 && (
                    <div className="mt-3 text-sm text-red-600 dark:text-red-400 bg-red-50 dark:bg-red-900/20 p-3 rounded">
                      ⚠️ High price impact! Consider buying a smaller amount.
                    </div>
                  )}
                </>
              ) : (
                <div className="text-center text-gray-500 py-4">
                  Enter an ETH amount to see quote
                </div>
              )}
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
                  Waiting for wallet approval...
                </span>
              ) : (
                'Buy LAND Tokens'
              )}
            </button>

            {/* Transaction Status Info */}
            <div className="text-xs text-gray-500 dark:text-gray-400 text-center mt-2">
              Clicking "Buy" will prompt your wallet to approve the transaction
            </div>
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
                <span className="mr-2">💱</span>
                <span>Swap ETH for LAND tokens via BaseSwap DEX at live market prices</span>
              </li>
              <li className="flex items-start">
                <span className="mr-2">📊</span>
                <span>Prices are determined by supply and demand in the liquidity pool</span>
              </li>
              <li className="flex items-start">
                <span className="mr-2">⚡</span>
                <span>Instant swaps with 5% slippage protection for small pool liquidity</span>
              </li>
              <li className="flex items-start">
                <span className="mr-2">🎯</span>
                <span>Use LAND tokens to purchase land parcels and pay property taxes</span>
              </li>
              <li className="flex items-start">
                <span className="mr-2">⚠️</span>
                <span>Note: Small liquidity pool means higher price impact on larger trades</span>
              </li>
            </ul>
          </div>
        </>
      )}
    </div>
  );
}
