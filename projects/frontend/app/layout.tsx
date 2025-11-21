import type { Metadata } from "next";
import "./globals.css";
import { Providers } from "./providers";
import { Navbar } from "@/components/Navbar";
import '@rainbow-me/rainbowkit/styles.css';

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
        <Providers>
          <Navbar />
          <main className="container mx-auto p-4">{children}</main>
          <footer className="bg-gray-800 text-white p-4 mt-8">
            <div className="container mx-auto text-center">
              <p>&copy; 2024 HyperLand. Powered by blockchain technology.</p>
            </div>
          </footer>
        </Providers>
      </body>
    </html>
  );
}
