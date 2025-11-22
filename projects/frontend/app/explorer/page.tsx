'use client';

import { useState, useEffect } from 'react';
import Link from 'next/link';

interface ActivityItem {
  id: string;
  type: 'purchase' | 'listing' | 'foreclosure' | 'claim';
  parcelId: string;
  address: string;
  price?: number;
  from?: string;
  to?: string;
  timestamp: number;
}

interface LandHolder {
  address: string;
  parcelsOwned: number;
  totalValue: number;
  rank: number;
}

export default function ExplorerPage() {
  const [recentActivity, setRecentActivity] = useState<ActivityItem[]>([]);
  const [topHolders, setTopHolders] = useState<LandHolder[]>([]);
  const [stats, setStats] = useState({
    totalTransactions: 0,
    totalVolume: 0,
    forSaleCount: 0,
    foreclosureCount: 0,
    avgPrice: 0,
  });

  useEffect(() => {
    // TODO: Fetch real data from API/contract
    fetchExplorerData();
  }, []);

  const fetchExplorerData = async () => {
    try {
      // Fetch activity feed
      // const activityResponse = await fetch('/api/activity');
      // const activityData = await activityResponse.json();
      // setRecentActivity(activityData);

      // Fetch top holders
      // const holdersResponse = await fetch('/api/holders');
      // const holdersData = await holdersResponse.json();
      // setTopHolders(holdersData);

      // Fetch stats
      // const statsResponse = await fetch('/api/stats');
      // const statsData = await statsResponse.json();
      // setStats(statsData);
    } catch (error) {
      console.error('Failed to fetch explorer data:', error);
    }
  };

  const getActivityIcon = (type: string) => {
    const className = "w-6 h-6";
    switch (type) {
      case 'purchase':
        return (
          <svg className={`${className} text-cyan-400`} fill="currentColor" viewBox="0 0 20 20">
            <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
          </svg>
        );
      case 'listing':
        return (
          <svg className={`${className} text-purple-400`} fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
          </svg>
        );
      case 'foreclosure':
        return (
          <svg className={`${className} text-orange-400`} fill="currentColor" viewBox="0 0 20 20">
            <path fillRule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clipRule="evenodd" />
          </svg>
        );
      case 'claim':
        return (
          <svg className={`${className} text-pink-400`} fill="currentColor" viewBox="0 0 20 20">
            <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
          </svg>
        );
      default:
        return (
          <svg className={`${className} text-white`} fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
          </svg>
        );
    }
  };

  const getActivityColor = (type: string) => {
    switch (type) {
      case 'purchase':
        return 'text-cyan-400';
      case 'listing':
        return 'text-purple-400';
      case 'foreclosure':
        return 'text-orange-400';
      case 'claim':
        return 'text-pink-400';
      default:
        return 'text-white';
    }
  };

  const formatTimeAgo = (timestamp: number) => {
    const seconds = Math.floor((Date.now() - timestamp) / 1000);
    if (seconds < 60) return `${seconds}s ago`;
    const minutes = Math.floor(seconds / 60);
    if (minutes < 60) return `${minutes}m ago`;
    const hours = Math.floor(minutes / 60);
    if (hours < 24) return `${hours}h ago`;
    const days = Math.floor(hours / 24);
    return `${days}d ago`;
  };

  const getRankBadge = (rank: number) => {
    const iconSize = "w-5 h-5";
    switch (rank) {
      case 1:
        return (
          <svg className={`${iconSize} text-yellow-400`} fill="currentColor" viewBox="0 0 20 20">
            <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
          </svg>
        );
      case 2:
        return (
          <svg className={`${iconSize} text-gray-300`} fill="currentColor" viewBox="0 0 20 20">
            <path fillRule="evenodd" d="M6.267 3.455a3.066 3.066 0 001.745-.723 3.066 3.066 0 013.976 0 3.066 3.066 0 001.745.723 3.066 3.066 0 012.812 2.812c.051.643.304 1.254.723 1.745a3.066 3.066 0 010 3.976 3.066 3.066 0 00-.723 1.745 3.066 3.066 0 01-2.812 2.812 3.066 3.066 0 00-1.745.723 3.066 3.066 0 01-3.976 0 3.066 3.066 0 00-1.745-.723 3.066 3.066 0 01-2.812-2.812 3.066 3.066 0 00-.723-1.745 3.066 3.066 0 010-3.976 3.066 3.066 0 00.723-1.745 3.066 3.066 0 012.812-2.812zm7.44 5.252a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" />
          </svg>
        );
      case 3:
        return (
          <svg className={`${iconSize} text-amber-600`} fill="currentColor" viewBox="0 0 20 20">
            <path fillRule="evenodd" d="M6.267 3.455a3.066 3.066 0 001.745-.723 3.066 3.066 0 013.976 0 3.066 3.066 0 001.745.723 3.066 3.066 0 012.812 2.812c.051.643.304 1.254.723 1.745a3.066 3.066 0 010 3.976 3.066 3.066 0 00-.723 1.745 3.066 3.066 0 01-2.812 2.812 3.066 3.066 0 00-1.745.723 3.066 3.066 0 01-3.976 0 3.066 3.066 0 00-1.745-.723 3.066 3.066 0 01-2.812-2.812 3.066 3.066 0 00-.723-1.745 3.066 3.066 0 010-3.976 3.066 3.066 0 00.723-1.745 3.066 3.066 0 012.812-2.812zm7.44 5.252a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" />
          </svg>
        );
      default:
        return <span className="text-sm font-bold text-white/60">#{rank}</span>;
    }
  };

  return (
    <div className="space-y-8 pb-8">
      {/* Hero Section */}
      <section className="text-center pt-8">
        <h1 className="text-5xl font-display font-bold mb-4 text-gradient-cyan-purple">
          HyperLand Explorer
        </h1>
        <p className="text-xl text-white/70 mb-8">
          Track territory activity, top holders, and market trends in real-time
        </p>
      </section>

      {/* Stats Dashboard */}
      <section className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-4">
        <div className="glass rounded-lg p-6 border border-cyan-500/30 hover:border-cyan-500/50 transition-all duration-300">
          <div className="text-xs text-white/60 mb-2">Total Transactions</div>
          <div className="text-3xl font-bold text-gradient-cyan-purple">
            {stats.totalTransactions.toLocaleString()}
          </div>
        </div>
        <div className="glass rounded-lg p-6 border border-purple-500/30 hover:border-purple-500/50 transition-all duration-300">
          <div className="text-xs text-white/60 mb-2">Total Volume</div>
          <div className="text-3xl font-bold text-gradient-purple-pink">
            ${(stats.totalVolume / 1000000).toFixed(2)}M
          </div>
        </div>
        <div className="glass rounded-lg p-6 border border-blue-500/30 hover:border-blue-500/50 transition-all duration-300">
          <div className="text-xs text-white/60 mb-2">For Sale</div>
          <div className="text-3xl font-bold text-purple-400">{stats.forSaleCount}</div>
        </div>
        <div className="glass rounded-lg p-6 border border-orange-500/30 hover:border-orange-500/50 transition-all duration-300">
          <div className="text-xs text-white/60 mb-2">Foreclosures</div>
          <div className="text-3xl font-bold text-orange-400">{stats.foreclosureCount}</div>
        </div>
        <div className="glass rounded-lg p-6 border border-pink-500/30 hover:border-pink-500/50 transition-all duration-300">
          <div className="text-xs text-white/60 mb-2">Avg Price</div>
          <div className="text-3xl font-bold text-cyan-400">${stats.avgPrice.toLocaleString()}</div>
        </div>
      </section>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Recent Activity Feed */}
        <section className="lg:col-span-2">
          <div className="glass rounded-lg p-6 border border-white/20">
            <div className="flex items-center justify-between mb-6">
              <h2 className="text-2xl font-display font-bold text-gradient-cyan-purple">
                Live Activity Feed
              </h2>
              <div className="w-3 h-3 rounded-full bg-cyan-400 animate-pulse glow-cyan"></div>
            </div>

            <div className="space-y-3">
              {recentActivity.map((activity) => (
                <div
                  key={activity.id}
                  className="glass-hover p-4 rounded-lg border border-white/10 hover:border-cyan-500/50 transition-all duration-300"
                >
                  <div className="flex items-start justify-between">
                    <div className="flex items-start gap-3">
                      <div className="mt-0.5">{getActivityIcon(activity.type)}</div>
                      <div>
                        <div className="flex items-center gap-2 mb-1">
                          <span className={`font-bold ${getActivityColor(activity.type)} capitalize`}>
                            {activity.type}
                          </span>
                          <span className="text-white/40">•</span>
                          <Link
                            href={`/brc-map?parcel=${activity.parcelId}`}
                            className="text-cyan-400 hover:text-cyan-300 font-mono text-sm transition-colors"
                          >
                            {activity.parcelId}
                          </Link>
                        </div>
                        {activity.price && (
                          <div className="text-white/80 text-sm mb-1">
                            <span className="text-purple-400 font-bold">${activity.price.toLocaleString()}</span> LAND
                          </div>
                        )}
                        {activity.from && activity.to && (
                          <div className="text-xs text-white/60">
                            <span className="font-mono">{activity.from}</span>
                            <span className="mx-2">→</span>
                            <span className="font-mono">{activity.to}</span>
                          </div>
                        )}
                      </div>
                    </div>
                    <div className="text-xs text-white/40 whitespace-nowrap">
                      {formatTimeAgo(activity.timestamp)}
                    </div>
                  </div>
                </div>
              ))}
            </div>

            <Link
              href="/marketplace"
              className="mt-6 block text-center text-sm text-cyan-400 hover:text-cyan-300 transition-colors"
            >
              View All Activity →
            </Link>
          </div>
        </section>

        {/* Top Land Holders */}
        <section>
          <div className="glass rounded-lg p-6 border border-white/20">
            <h2 className="text-2xl font-display font-bold text-gradient-purple-pink mb-6">
              Top Holders
            </h2>

            <div className="space-y-3">
              {topHolders.map((holder) => (
                <div
                  key={holder.address}
                  className="glass-hover p-4 rounded-lg border border-white/10 hover:border-purple-500/50 transition-all duration-300"
                >
                  <div className="flex items-center justify-between mb-2">
                    <div className="flex items-center gap-2">
                      {getRankBadge(holder.rank)}
                      <span className="font-mono text-sm text-white/80">{holder.address}</span>
                    </div>
                  </div>
                  <div className="grid grid-cols-2 gap-2 text-sm">
                    <div>
                      <div className="text-white/60 text-xs">Parcels</div>
                      <div className="text-cyan-400 font-bold">{holder.parcelsOwned}</div>
                    </div>
                    <div>
                      <div className="text-white/60 text-xs">Value</div>
                      <div className="text-purple-400 font-bold">
                        ${(holder.totalValue / 1000).toFixed(0)}K
                      </div>
                    </div>
                  </div>
                </div>
              ))}
            </div>

            <Link
              href="/marketplace"
              className="mt-6 block text-center text-sm text-purple-400 hover:text-purple-300 transition-colors"
            >
              View Full Leaderboard →
            </Link>
          </div>
        </section>
      </div>

      {/* Market Snapshot */}
      <section>
        <h2 className="text-3xl font-display font-bold text-gradient-cyan-purple mb-6">
          Market Snapshot
        </h2>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          {/* For Sale */}
          <div className="glass rounded-lg p-6 border border-purple-500/30">
            <div className="flex items-center justify-between mb-4">
              <h3 className="text-xl font-bold text-purple-400">For Sale</h3>
              <div className="text-3xl font-bold text-purple-400">{stats.forSaleCount}</div>
            </div>
            <p className="text-white/60 text-sm mb-4">
              Active listings on the marketplace
            </p>
            <Link
              href="/marketplace?filter=listed"
              className="btn-secondary w-full text-center block"
            >
              Browse Listings
            </Link>
          </div>

          {/* In Foreclosure */}
          <div className="glass rounded-lg p-6 border border-orange-500/30">
            <div className="flex items-center justify-between mb-4">
              <h3 className="text-xl font-bold text-orange-400">In Foreclosure</h3>
              <div className="text-3xl font-bold text-orange-400">{stats.foreclosureCount}</div>
            </div>
            <p className="text-white/60 text-sm mb-4">
              Parcels available for claim or auction
            </p>
            <Link
              href="/marketplace?filter=auction"
              className="btn-secondary w-full text-center block"
            >
              View Foreclosures
            </Link>
          </div>
        </div>
      </section>
    </div>
  );
}
