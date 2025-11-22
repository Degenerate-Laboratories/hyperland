'use client'

import Link from "next/link"
import Image from "next/image"
import { ConnectButton } from '@rainbow-me/rainbowkit'
import { usePathname } from 'next/navigation'

export function Navbar() {
  const pathname = usePathname()

  const isActive = (path: string) => pathname === path

  return (
    <nav className="fixed top-0 left-0 right-0 z-50 h-16 bg-black/95 backdrop-blur-md border-b border-white/20 shadow-lg shadow-cyan-500/10">
      <div className="container mx-auto h-full px-4 md:px-8 flex items-center justify-between gap-2 md:gap-6">
        {/* Left: Logo */}
        <Link href="/" className="flex items-center gap-2 md:gap-3 hover:opacity-90 transition-all duration-200 flex-shrink-0 ml-2 md:ml-4">
          <Image
            src="/HyperLogo.png"
            alt="HyperLand Logo"
            width={28}
            height={28}
            className="flex-shrink-0 md:w-8 md:h-8"
          />
          <span className="hidden md:block text-lg font-bold text-gradient-cyan-purple whitespace-nowrap">
            HYPERLAND
          </span>
        </Link>

        {/* Center: Navigation Links */}
        <div className="flex items-center gap-4 md:gap-6 flex-1 justify-center">
          {/* Home */}
          <Link
            href="/"
            className="flex items-center justify-center p-2 md:p-0 transition-all"
            title="Home"
          >
            <span className={`hidden md:block text-sm font-bold whitespace-nowrap ${
              isActive('/') ? 'text-gradient-cyan-purple' : 'text-white hover:opacity-80'
            }`}>Home</span>
            <svg className="w-8 h-8 md:hidden transition-all" fill="none" viewBox="0 0 24 24" stroke={isActive('/') ? 'url(#iconGradient)' : 'currentColor'} strokeWidth={2}>
              <defs>
                <linearGradient id="iconGradient" x1="0%" y1="0%" x2="100%" y2="100%">
                  <stop offset="0%" style={{stopColor: '#06b6d4', stopOpacity: 1}} />
                  <stop offset="100%" style={{stopColor: '#8b5cf6', stopOpacity: 1}} />
                </linearGradient>
              </defs>
              <path className={isActive('/') ? '' : 'text-white'} strokeLinecap="round" strokeLinejoin="round" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
            </svg>
          </Link>

          {/* Explorer */}
          <Link
            href="/explorer"
            className="flex items-center justify-center p-2 md:p-0 transition-all"
            title="Explorer"
          >
            <span className={`hidden md:block text-sm font-bold whitespace-nowrap ${
              isActive('/explorer') ? 'text-gradient-cyan-purple' : 'text-white hover:opacity-80'
            }`}>Explorer</span>
            <svg className="w-8 h-8 md:hidden transition-all" fill="none" viewBox="0 0 24 24" stroke={isActive('/explorer') ? 'url(#iconGradient)' : 'currentColor'} strokeWidth={2}>
              <defs>
                <linearGradient id="iconGradient" x1="0%" y1="0%" x2="100%" y2="100%">
                  <stop offset="0%" style={{stopColor: '#06b6d4', stopOpacity: 1}} />
                  <stop offset="100%" style={{stopColor: '#8b5cf6', stopOpacity: 1}} />
                </linearGradient>
              </defs>
              <path className={isActive('/explorer') ? '' : 'text-white'} strokeLinecap="round" strokeLinejoin="round" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
            </svg>
          </Link>

          {/* Map */}
          <Link
            href="/brc-map"
            className="flex items-center justify-center p-2 md:p-0 transition-all"
            title="Map"
          >
            <span className={`hidden md:block text-sm font-bold whitespace-nowrap ${
              isActive('/brc-map') ? 'text-gradient-cyan-purple' : 'text-white hover:opacity-80'
            }`}>Map</span>
            <svg className="w-8 h-8 md:hidden transition-all" fill="none" viewBox="0 0 24 24" stroke={isActive('/brc-map') ? 'url(#iconGradient)' : 'currentColor'} strokeWidth={2}>
              <defs>
                <linearGradient id="iconGradient" x1="0%" y1="0%" x2="100%" y2="100%">
                  <stop offset="0%" style={{stopColor: '#06b6d4', stopOpacity: 1}} />
                  <stop offset="100%" style={{stopColor: '#8b5cf6', stopOpacity: 1}} />
                </linearGradient>
              </defs>
              <path className={isActive('/brc-map') ? '' : 'text-white'} strokeLinecap="round" strokeLinejoin="round" d="M9 20l-5.447-2.724A1 1 0 013 16.382V5.618a1 1 0 011.447-.894L9 7m0 13l6-3m-6 3V7m6 10l4.553 2.276A1 1 0 0021 18.382V7.618a1 1 0 00-.553-.894L15 4m0 13V4m0 0L9 7" />
            </svg>
          </Link>

          {/* Marketplace */}
          <Link
            href="/marketplace"
            className="flex items-center justify-center p-2 md:p-0 transition-all"
            title="Marketplace"
          >
            <span className={`hidden md:block text-sm font-bold whitespace-nowrap ${
              isActive('/marketplace') ? 'text-gradient-cyan-purple' : 'text-white hover:opacity-80'
            }`}>Marketplace</span>
            <svg className="w-8 h-8 md:hidden transition-all" fill="none" viewBox="0 0 24 24" stroke={isActive('/marketplace') ? 'url(#iconGradient)' : 'currentColor'} strokeWidth={2}>
              <defs>
                <linearGradient id="iconGradient" x1="0%" y1="0%" x2="100%" y2="100%">
                  <stop offset="0%" style={{stopColor: '#06b6d4', stopOpacity: 1}} />
                  <stop offset="100%" style={{stopColor: '#8b5cf6', stopOpacity: 1}} />
                </linearGradient>
              </defs>
              <path className={isActive('/marketplace') ? '' : 'text-white'} strokeLinecap="round" strokeLinejoin="round" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" />
            </svg>
          </Link>

          {/* My Lands */}
          <Link
            href="/my-lands"
            className="flex items-center justify-center p-2 md:p-0 transition-all"
            title="My Lands"
          >
            <span className={`hidden md:block text-sm font-bold whitespace-nowrap ${
              isActive('/my-lands') ? 'text-gradient-cyan-purple' : 'text-white hover:opacity-80'
            }`}>My Lands</span>
            <svg className="w-8 h-8 md:hidden transition-all" fill="none" viewBox="0 0 24 24" stroke={isActive('/my-lands') ? 'url(#iconGradient)' : 'currentColor'} strokeWidth={2}>
              <defs>
                <linearGradient id="iconGradient" x1="0%" y1="0%" x2="100%" y2="100%">
                  <stop offset="0%" style={{stopColor: '#06b6d4', stopOpacity: 1}} />
                  <stop offset="100%" style={{stopColor: '#8b5cf6', stopOpacity: 1}} />
                </linearGradient>
              </defs>
              <path className={isActive('/my-lands') ? '' : 'text-white'} strokeLinecap="round" strokeLinejoin="round" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
            </svg>
          </Link>
        </div>

        {/* Right: Buy Land + Wallet */}
        <div className="flex items-center gap-1 md:gap-4 flex-shrink-0">
          <Link
            href="/buy-land"
            className="px-1.5 py-1 md:px-4 md:py-2 rounded-md md:rounded-lg font-bold text-[10px] md:text-sm bg-gradient-to-br from-cyan-500 to-purple-600 hover:from-cyan-400 hover:to-purple-500 text-white transition-all duration-200 whitespace-nowrap"
          >
            Buy LAND
          </Link>
          <ConnectButton.Custom>
            {({
              account,
              chain,
              openAccountModal,
              openChainModal,
              openConnectModal,
              mounted,
            }) => {
              const ready = mounted;
              const connected = ready && account && chain;

              return (
                <div
                  {...(!ready && {
                    'aria-hidden': true,
                    'style': {
                      opacity: 0,
                      pointerEvents: 'none',
                      userSelect: 'none',
                    },
                  })}
                >
                  {(() => {
                    if (!connected) {
                      return (
                        <button
                          onClick={openConnectModal}
                          type="button"
                          className="text-gradient-cyan-purple font-bold text-[10px] md:text-sm hover:opacity-80 transition-opacity whitespace-nowrap"
                        >
                          <span className="hidden sm:inline">Connect</span>
                          <span className="sm:hidden">
                            <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2.5}>
                              <path strokeLinecap="round" strokeLinejoin="round" d="M13 10V3L4 14h7v7l9-11h-7z" />
                            </svg>
                          </span>
                        </button>
                      );
                    }

                    if (chain.unsupported) {
                      return (
                        <button
                          onClick={openChainModal}
                          type="button"
                          className="text-red-400 font-bold text-[10px] md:text-sm hover:opacity-80 transition-opacity"
                        >
                          <span className="hidden sm:inline">Wrong</span>
                          <span className="sm:hidden">!</span>
                        </button>
                      );
                    }

                    return (
                      <div className="flex items-center gap-0.5 md:gap-3">
                        <button
                          onClick={openChainModal}
                          type="button"
                          className="text-gradient-cyan-purple font-bold text-[10px] md:text-sm hover:opacity-80 transition-opacity flex items-center gap-1 p-1"
                        >
                          {chain.hasIcon && (
                            <div
                              style={{
                                background: chain.iconBackground,
                                width: 16,
                                height: 16,
                                borderRadius: 999,
                                overflow: 'hidden',
                              }}
                            >
                              {chain.iconUrl && (
                                <img
                                  alt={chain.name ?? 'Chain icon'}
                                  src={chain.iconUrl}
                                  style={{ width: 16, height: 16 }}
                                />
                              )}
                            </div>
                          )}
                          <span className="hidden md:inline">{chain.name}</span>
                        </button>

                        <button
                          onClick={openAccountModal}
                          type="button"
                          className="text-gradient-cyan-purple font-bold text-[10px] md:text-sm hover:opacity-80 transition-opacity truncate max-w-[60px] sm:max-w-[80px] md:max-w-none"
                        >
                          <span className="hidden md:inline">
                            {account.displayName}
                            {account.displayBalance
                              ? ` (${account.displayBalance})`
                              : ''}
                          </span>
                          <span className="md:hidden truncate">{account.displayName}</span>
                        </button>
                      </div>
                    );
                  })()}
                </div>
              );
            }}
          </ConnectButton.Custom>
        </div>
      </div>
    </nav>
  )
}
