'use client'

import Link from "next/link"
import { ConnectButton } from '@rainbow-me/rainbowkit'

export function Navbar() {
  return (
    <nav className="bg-gray-800 text-white p-4">
      <div className="container mx-auto flex justify-between items-center">
        <Link href="/" className="text-2xl font-bold">
          HyperLand
        </Link>
        <div className="flex items-center space-x-4">
          <Link href="/marketplace" className="hover:text-gray-300">
            Marketplace
          </Link>
          <Link href="/my-lands" className="hover:text-gray-300">
            My Lands
          </Link>
          <ConnectButton />
        </div>
      </div>
    </nav>
  )
}
