'use client'

import Link from "next/link"
import Image from "next/image"
import { ConnectButton } from '@rainbow-me/rainbowkit'
import { usePathname } from 'next/navigation'

export function Navbar() {
  const pathname = usePathname()

  const isActive = (path: string) => pathname === path

  return (
    <nav className="fixed top-0 left-0 right-0 z-50 h-16 bg-black border-b border-white/10">
      <div className="container mx-auto h-full px-8 flex items-center justify-between">
        {/* Left: Logo */}
        <Link href="/" className="flex items-center gap-3 hover:opacity-90 transition-opacity">
          <Image
            src="/HyperLogo.png"
            alt="HyperLand Logo"
            width={32}
            height={32}
            className="flex-shrink-0"
          />
          <span className="text-lg font-bold text-white whitespace-nowrap">
            HYPERLAND
          </span>
        </Link>

        {/* Center: Navigation Links */}
        <div className="flex items-center gap-6">
          <Link
            href="/"
            className={`text-sm font-bold transition-colors whitespace-nowrap ${
              isActive('/') ? 'text-white' : 'text-gray-400 hover:text-white'
            }`}
          >
            Home
          </Link>
          <Link
            href="/brc-map"
            className={`text-sm font-bold transition-colors whitespace-nowrap ${
              isActive('/brc-map') ? 'text-white' : 'text-gray-400 hover:text-white'
            }`}
          >
            Map
          </Link>
          <Link
            href="/marketplace"
            className={`text-sm font-bold transition-colors whitespace-nowrap ${
              isActive('/marketplace') ? 'text-white' : 'text-gray-400 hover:text-white'
            }`}
          >
            Marketplace
          </Link>
          <Link
            href="/my-lands"
            className={`text-sm font-bold transition-colors whitespace-nowrap ${
              isActive('/my-lands') ? 'text-white' : 'text-gray-400 hover:text-white'
            }`}
          >
            My Lands
          </Link>
        </div>

        {/* Right: Wallet */}
        <div className="flex items-center">
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
                          className="text-gradient-cyan-purple font-bold text-sm hover:opacity-80 transition-opacity"
                        >
                          Connect Wallet
                        </button>
                      );
                    }

                    if (chain.unsupported) {
                      return (
                        <button
                          onClick={openChainModal}
                          type="button"
                          className="text-red-400 font-bold text-sm hover:opacity-80 transition-opacity"
                        >
                          Wrong network
                        </button>
                      );
                    }

                    return (
                      <div className="flex items-center gap-3">
                        <button
                          onClick={openChainModal}
                          type="button"
                          className="text-gradient-cyan-purple font-bold text-sm hover:opacity-80 transition-opacity flex items-center gap-2"
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
                          {chain.name}
                        </button>

                        <button
                          onClick={openAccountModal}
                          type="button"
                          className="text-gradient-cyan-purple font-bold text-sm hover:opacity-80 transition-opacity"
                        >
                          {account.displayName}
                          {account.displayBalance
                            ? ` (${account.displayBalance})`
                            : ''}
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
