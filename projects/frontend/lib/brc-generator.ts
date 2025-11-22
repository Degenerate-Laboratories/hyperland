/**
 * BRC Map Generator
 * Generates all parcels based on survey data
 */

import {
  BRC_SURVEY_DATA,
  BRCParcel,
  ParcelStatus,
  RingName,
  feetToLatLon,
  getRingName,
  angleFromMan,
  distanceFromMan,
  degreesToClock
} from './brc-constants';

interface Ring {
  name: RingName;
  innerRadius: number;
  outerRadius: number;
}

/**
 * Define all major named streets
 */
const MAJOR_STREETS = {
  ESPLANADE: 2500,
  AFANC: 3450,
  MIDCITY: 5200,
  IGOPOGO: 7675,
  KRAKEN: 11690
};

/**
 * Generate all concentric rings for parcels
 * 30 rings from Esplanade (2500') to Kraken (11690')
 */
function generateConcentricRings(): number[] {
  const innerRadius = MAJOR_STREETS.ESPLANADE;
  const outerRadius = MAJOR_STREETS.KRAKEN;
  const numRings = 30; // 30 concentric rings for depth

  const rings: number[] = [];
  const step = (outerRadius - innerRadius) / numRings;

  for (let i = 0; i <= numRings; i++) {
    rings.push(innerRadius + (i * step));
  }

  return rings;
}

/**
 * Generate radial sectors (2:00 to 10:00)
 * 40 radial divisions × 30 concentric rings = 1,200 total parcels
 */
function generateSectors(): Array<{ start: number, end: number, name: string }> {
  const sectors: Array<{ start: number, end: number, name: string }> = [];

  // BRC spans from 2:00 (60°) to 10:00 (300°) in clock terms = 240° arc
  const startClock = 2 * 30; // 2:00 = 60°
  const endClock = 10 * 30;  // 10:00 = 300°
  const numSectors = 40; // 40 radial divisions

  const sectorSize = (endClock - startClock) / numSectors; // 6° per sector

  for (let i = 0; i < numSectors; i++) {
    const angle = startClock + (i * sectorSize);
    const nextAngle = startClock + ((i + 1) * sectorSize);

    // Convert to clock time
    const hours = Math.floor(angle / 30);
    const minutes = Math.floor(((angle % 30) / 30) * 60);
    const name = `${hours}:${minutes.toString().padStart(2, '0')}`;

    sectors.push({
      start: angle,
      end: nextAngle,
      name
    });
  }

  return sectors;
}

/**
 * Calculate polygon points for a parcel (annular sector)
 * Rotated -90° so the opening is at north
 */
function calculateParcelPolygon(
  innerRadius: number,
  outerRadius: number,
  startAngle: number,
  endAngle: number,
  resolution: number = 10
): [number, number][] {
  const points: [number, number][] = [];

  // Convert angles to radians and rotate -90° to move opening to north
  const rotationOffset = -90;
  const startRad = ((startAngle + rotationOffset) * Math.PI) / 180;
  const endRad = ((endAngle + rotationOffset) * Math.PI) / 180;

  // Outer arc (going counter-clockwise)
  for (let i = 0; i <= resolution; i++) {
    const angle = startRad + (i / resolution) * (endRad - startRad);
    const x = outerRadius * Math.cos(angle);
    const y = outerRadius * Math.sin(angle);
    points.push([x, y]);
  }

  // Inner arc (going clockwise to close the polygon)
  for (let i = resolution; i >= 0; i--) {
    const angle = startRad + (i / resolution) * (endRad - startRad);
    const x = innerRadius * Math.cos(angle);
    const y = innerRadius * Math.sin(angle);
    points.push([x, y]);
  }

  // Close the polygon
  points.push(points[0]);

  return points;
}

/**
 * Calculate centroid of a polygon
 */
function calculateCentroid(polygon: [number, number][]): { x: number, y: number } {
  let sumX = 0;
  let sumY = 0;
  const count = polygon.length - 1; // Exclude the duplicate closing point

  for (let i = 0; i < count; i++) {
    sumX += polygon[i][0];
    sumY += polygon[i][1];
  }

  return {
    x: sumX / count,
    y: sumY / count
  };
}

/**
 * Calculate area of a polygon using shoelace formula
 */
function calculateArea(polygon: [number, number][]): number {
  let area = 0;
  const n = polygon.length - 1; // Exclude duplicate closing point

  for (let i = 0; i < n; i++) {
    const [x1, y1] = polygon[i];
    const [x2, y2] = polygon[(i + 1) % n];
    area += x1 * y2 - x2 * y1;
  }

  return Math.abs(area) / 2;
}

/**
 * Generate initial parcel data (all available)
 */
function generateInitialOwnership(): {
  status: ParcelStatus;
  owner: string | null;
  foreclosureDate: number | null;
  price: number;
} {
  // All parcels start as available with base price
  return {
    status: ParcelStatus.AVAILABLE,
    owner: null,
    foreclosureDate: null,
    price: 1000 // Base price in virtual currency
  };
}

/**
 * Get the nearest major street name for a given radius
 */
function getMajorStreetName(radius: number): RingName {
  if (radius < MAJOR_STREETS.AFANC) return 'Esplanade';
  if (radius < MAJOR_STREETS.MIDCITY) return 'Afanc';
  if (radius < MAJOR_STREETS.IGOPOGO) return 'MidCity';
  if (radius < MAJOR_STREETS.KRAKEN) return 'Igopogo';
  return 'Kraken';
}

/**
 * Generate all BRC parcels
 * 40 radial sectors × 30 concentric rings = 1,200 parcels
 */
export function generateAllParcels(): BRCParcel[] {
  const parcels: BRCParcel[] = [];
  const sectors = generateSectors(); // 40 radial sectors
  const rings = generateConcentricRings(); // 31 ring boundaries (30 bands)

  let parcelId = 1;

  // Generate parcels for each concentric ring band
  for (let ringIndex = 0; ringIndex < rings.length - 1; ringIndex++) {
    const innerRadius = rings[ringIndex];
    const outerRadius = rings[ringIndex + 1];
    const avgRadius = (innerRadius + outerRadius) / 2;

    // Generate parcels for each radial sector
    for (const sector of sectors) {
      const polygon = calculateParcelPolygon(
        innerRadius,
        outerRadius,
        sector.start,
        sector.end,
        8 // Reduced resolution for performance with 1200 parcels
      );

      const centroid = calculateCentroid(polygon);
      const area = calculateArea(polygon);
      const { lat, lon } = feetToLatLon(centroid.x, centroid.y);

      const ownership = generateInitialOwnership();
      const bandName = getMajorStreetName(avgRadius);

      const parcel: BRCParcel = {
        id: `BRC-${parcelId.toString().padStart(4, '0')}`,
        x: centroid.x,
        y: centroid.y,
        lat,
        lon,
        band: bandName,
        sector: sector.name,
        address: `${sector.name} & ${bandName}`,
        polygon,
        centroid,
        area,
        status: ownership.status,
        currentOwner: ownership.owner,
        ownerHistory: [],
        foreclosureDate: ownership.foreclosureDate,
        daysUntilForeclosure: null,
        price: ownership.price,
        lastSalePrice: null,
        playUrl: `/play?parcel=${parcelId}&x=${Math.floor(centroid.x)}&y=${Math.floor(centroid.y)}`,
        activityScore: 0,
        improvements: undefined
      };

      parcels.push(parcel);
      parcelId++;
    }
  }

  return parcels;
}

/**
 * Get parcel by coordinates
 */
export function getParcelByCoordinates(x: number, y: number, parcels: BRCParcel[]): BRCParcel | null {
  // Find parcel whose polygon contains the point
  for (const parcel of parcels) {
    if (isPointInPolygon(x, y, parcel.polygon)) {
      return parcel;
    }
  }
  return null;
}

/**
 * Check if point is inside polygon using ray casting algorithm
 */
function isPointInPolygon(x: number, y: number, polygon: [number, number][]): boolean {
  let inside = false;
  const n = polygon.length - 1;

  for (let i = 0, j = n - 1; i < n; j = i++) {
    const [xi, yi] = polygon[i];
    const [xj, yj] = polygon[j];

    const intersect = ((yi > y) !== (yj > y))
      && (x < (xj - xi) * (y - yi) / (yj - yi) + xi);

    if (intersect) inside = !inside;
  }

  return inside;
}

/**
 * Filter parcels by criteria
 */
export function filterParcels(
  parcels: BRCParcel[],
  filters: {
    band?: RingName;
    status?: ParcelStatus;
    minPrice?: number;
    maxPrice?: number;
    sector?: string;
  }
): BRCParcel[] {
  return parcels.filter(parcel => {
    if (filters.band && parcel.band !== filters.band) return false;
    if (filters.status && parcel.status !== filters.status) return false;
    if (filters.minPrice && parcel.price < filters.minPrice) return false;
    if (filters.maxPrice && parcel.price > filters.maxPrice) return false;
    if (filters.sector && parcel.sector !== filters.sector) return false;
    return true;
  });
}

/**
 * Get parcels by owner
 */
export function getParcelsByOwner(parcels: BRCParcel[], ownerAddress: string): BRCParcel[] {
  return parcels.filter(parcel =>
    parcel.currentOwner?.toLowerCase() === ownerAddress.toLowerCase()
  );
}

/**
 * Get statistics about all parcels
 */
export function getMapStatistics(parcels: BRCParcel[]) {
  const totalParcels = parcels.length;
  const claimedParcels = parcels.filter(p => p.status === ParcelStatus.CLAIMED).length;
  const availableParcels = parcels.filter(p => p.status === ParcelStatus.AVAILABLE).length;
  const foreclosureParcels = parcels.filter(p => p.status === ParcelStatus.FORECLOSURE).length;

  const prices = parcels.map(p => p.price);
  const avgPrice = prices.reduce((a, b) => a + b, 0) / prices.length;
  const minPrice = Math.min(...prices);
  const maxPrice = Math.max(...prices);

  const uniqueOwners = new Set(
    parcels
      .filter(p => p.currentOwner)
      .map(p => p.currentOwner)
  ).size;

  return {
    totalParcels,
    claimedParcels,
    availableParcels,
    foreclosureParcels,
    claimRate: (claimedParcels / totalParcels) * 100,
    avgPrice,
    minPrice,
    maxPrice,
    uniqueOwners,
    totalArea: parcels.reduce((sum, p) => sum + p.area, 0)
  };
}
