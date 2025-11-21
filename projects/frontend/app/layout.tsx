import type { Metadata } from "next";
import "./globals.css";
import Link from "next/link";

export const metadata: Metadata = {
  title: "HyperLand - Blockchain Land Management",
  description: "Buy, sell, and manage virtual land parcels on the blockchain",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body>
        <nav className="bg-gray-800 text-white p-4">
          <div className="container mx-auto flex justify-between items-center">
            <Link href="/" className="text-2xl font-bold">
              HyperLand
            </Link>
            <div className="space-x-4">
              <Link href="/marketplace" className="hover:text-gray-300">
                Marketplace
              </Link>
              <Link href="/my-lands" className="hover:text-gray-300">
                My Lands
              </Link>
              <button className="bg-blue-600 hover:bg-blue-700 px-4 py-2 rounded">
                Connect Wallet
              </button>
            </div>
          </div>
        </nav>
        <main className="container mx-auto p-4">{children}</main>
        <footer className="bg-gray-800 text-white p-4 mt-8">
          <div className="container mx-auto text-center">
            <p>&copy; 2024 HyperLand. Powered by blockchain technology.</p>
          </div>
        </footer>
      </body>
    </html>
  );
}
