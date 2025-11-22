import type { Metadata } from "next";
import "./globals.css";
import { Providers } from "./providers";
import { ChakraProviderWrapper } from "./chakra-provider";
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
        <ChakraProviderWrapper>
          <Providers>
            <Navbar />
            <main className="px-4 md:px-8 lg:px-12 mt-20">{children}</main>
          </Providers>
        </ChakraProviderWrapper>
      </body>
    </html>
  );
}
