/**
 * BRC Map API Endpoint
 * GET /api/brc-map - Returns all parcels and map metadata
 * GET /api/brc-map?x=1000&y=2000 - Returns specific parcel at coordinates
 * GET /api/brc-map?parcelId=BRC-0123 - Returns specific parcel by ID
 * GET /api/brc-map?owner=0x... - Returns all parcels owned by address
 */

import { NextRequest, NextResponse } from 'next/server';
import {
  generateAllParcels,
  getParcelByCoordinates,
  filterParcels,
  getParcelsByOwner,
  getMapStatistics
} from '@/lib/brc-generator';
import { BRCParcel, ParcelStatus, RingName } from '@/lib/brc-constants';

// Cache the generated parcels (in production, use Redis or database)
let cachedParcels: BRCParcel[] | null = null;

function getParcels(): BRCParcel[] {
  if (!cachedParcels) {
    cachedParcels = generateAllParcels();
  }
  return cachedParcels;
}

export async function GET(request: NextRequest) {
  try {
    const searchParams = request.nextUrl.searchParams;
    const parcels = getParcels();

    // Query by coordinates
    const x = searchParams.get('x');
    const y = searchParams.get('y');
    if (x && y) {
      const parcel = getParcelByCoordinates(parseFloat(x), parseFloat(y), parcels);
      if (parcel) {
        return NextResponse.json({ parcel });
      }
      return NextResponse.json({ error: 'No parcel found at coordinates' }, { status: 404 });
    }

    // Query by parcel ID
    const parcelId = searchParams.get('parcelId');
    if (parcelId) {
      const parcel = parcels.find(p => p.id === parcelId);
      if (parcel) {
        return NextResponse.json({ parcel });
      }
      return NextResponse.json({ error: 'Parcel not found' }, { status: 404 });
    }

    // Query by owner
    const owner = searchParams.get('owner');
    if (owner) {
      const ownedParcels = getParcelsByOwner(parcels, owner);
      return NextResponse.json({
        parcels: ownedParcels,
        count: ownedParcels.length
      });
    }

    // Filter parcels
    const band = searchParams.get('band') as RingName | null;
    const status = searchParams.get('status') as ParcelStatus | null;
    const minPrice = searchParams.get('minPrice');
    const maxPrice = searchParams.get('maxPrice');
    const sector = searchParams.get('sector');

    let filteredParcels = parcels;

    if (band || status || minPrice || maxPrice || sector) {
      filteredParcels = filterParcels(parcels, {
        band: band || undefined,
        status: status || undefined,
        minPrice: minPrice ? parseFloat(minPrice) : undefined,
        maxPrice: maxPrice ? parseFloat(maxPrice) : undefined,
        sector: sector || undefined
      });
    }

    // Pagination
    const page = parseInt(searchParams.get('page') || '1');
    const limit = parseInt(searchParams.get('limit') || '100');
    const start = (page - 1) * limit;
    const end = start + limit;

    const paginatedParcels = filteredParcels.slice(start, end);

    // Get statistics
    const stats = getMapStatistics(parcels);

    return NextResponse.json({
      parcels: paginatedParcels,
      pagination: {
        page,
        limit,
        total: filteredParcels.length,
        totalPages: Math.ceil(filteredParcels.length / limit)
      },
      statistics: stats,
      metadata: {
        generatedAt: new Date().toISOString(),
        totalParcels: parcels.length
      }
    });

  } catch (error) {
    console.error('BRC Map API Error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

// Invalidate cache endpoint (for development)
export async function DELETE() {
  cachedParcels = null;
  return NextResponse.json({ message: 'Cache cleared' });
}
