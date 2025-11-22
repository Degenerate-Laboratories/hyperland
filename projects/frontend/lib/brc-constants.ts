/**
 * Black Rock City 2023 Survey Data
 * Based on official BRC survey coordinates and measurements
 * All measurements in feet from The Man (origin: 0,0)
 */

export const BRC_SURVEY_DATA = {
  // Origin point - The Man
  MAN: { x: 0, y: 0 },

  // Golden Spike (survey reference point)
  GOLDEN_SPIKE: { x: 0, y: 0 },

  // Ring radii from center (in feet)
  RINGS: {
    ESPLANADE: 2500,
    AFANC: 3450,      // ~950' depth
    MIDCITY: 5200,    // ~1750' depth
    IGOPOGO: 7675,    // ~2475' depth
    KRAKEN: 11690     // ~4015' depth (diameter, so radius ~5845')
  },

  // Fence pentagon outer boundary
  FENCE_RADIUS: 13500, // Approximate outer fence distance

  // Center Camp specifications
  CENTER_CAMP: {
    RADIUS: 500,
    OFFSET_Y: -2500 // South of Man
  },

  // Promenade (main plaza along 6:00 axis)
  PROMENADE: {
    WIDTH: 200,
    START_RADIUS: 2500, // Starts at Esplanade
    END_RADIUS: 5845    // Ends at Kraken
  },

  // Radial street configuration
  RADIALS: {
    // Main 10:00 streets (every hour from 2:00 to 10:00)
    MAJOR_INTERVAL: 30, // degrees
    // Minor 2:00 streets (every 2 minutes/1 degree between majors)
    MINOR_INTERVAL: 1,  // degrees

    // Arc span (240° from 3:00 to 9:00, with 60° open toward entrance)
    START_ANGLE: 270,   // 9:00 position (east) in standard math coords
    END_ANGLE: 90,      // 3:00 position (west)
    OPEN_ANGLE: 180     // 6:00 (south entrance)
  },

  // Street naming
  STREETS: {
    // Major radial streets (named after time)
    MAJOR: ['2:00', '2:30', '3:00', '3:30', '4:00', '4:30', '5:00', '5:30',
            '6:00', '6:30', '7:00', '7:30', '8:00', '8:30', '9:00', '9:30', '10:00'],

    // Concentric streets (named after sea serpents)
    RINGS: ['Esplanade', 'Afanc', 'MidCity', 'Igopogo', 'Kraken']
  },

  // GPS coordinates (approximate for BRC 2023)
  GPS_CENTER: {
    lat: 40.7864,  // Man location
    lon: -119.2065
  },

  // Coordinate conversion factors
  FEET_PER_DEGREE_LAT: 364000,  // Approximate
  FEET_PER_DEGREE_LON: 288200   // Approximate at this latitude
};

/**
 * Parcel Status Types
 */
export enum ParcelStatus {
  AVAILABLE = 'available',
  CLAIMED = 'claimed',
  FORECLOSURE = 'foreclosure',
  RESERVED = 'reserved'
}

/**
 * Band/Ring Names
 */
export type RingName = 'Esplanade' | 'Afanc' | 'MidCity' | 'Igopogo' | 'Kraken';

/**
 * Parcel metadata structure
 */
export interface BRCParcel {
  id: string;

  // Location coordinates
  x: number;          // Feet from Man (east-west)
  y: number;          // Feet from Man (north-south)
  lat: number;        // GPS latitude
  lon: number;        // GPS longitude

  // Address/location
  band: RingName;
  sector: string;     // e.g., "2:00", "3:15", "6:00"
  address: string;    // Full address: "2:00 & Esplanade"

  // Geometry
  polygon: [number, number][]; // Boundary points [x,y]
  centroid: { x: number, y: number };
  area: number;       // Square feet

  // Ownership & Status
  status: ParcelStatus;
  currentOwner: string | null;
  ownerHistory: Array<{
    address: string;
    acquiredDate: number;
    soldDate?: number;
  }>;

  // Foreclosure
  foreclosureDate: number | null;  // Unix timestamp
  daysUntilForeclosure: number | null;

  // Pricing
  price: number;      // Virtual currency
  lastSalePrice: number | null;

  // Gameplay
  playUrl: string;    // URL to teleport into 3D world
  activityScore: number; // 0-100 based on usage

  // Optional: Enhancements
  improvements?: string[]; // Buildings, art, etc.
  events?: Array<{
    name: string;
    date: number;
  }>;
}

/**
 * Convert feet coordinates to lat/lon
 */
export function feetToLatLon(x: number, y: number): { lat: number, lon: number } {
  const { GPS_CENTER, FEET_PER_DEGREE_LAT, FEET_PER_DEGREE_LON } = BRC_SURVEY_DATA;

  return {
    lat: GPS_CENTER.lat + (y / FEET_PER_DEGREE_LAT),
    lon: GPS_CENTER.lon + (x / FEET_PER_DEGREE_LON)
  };
}

/**
 * Convert lat/lon to feet coordinates
 */
export function latLonToFeet(lat: number, lon: number): { x: number, y: number } {
  const { GPS_CENTER, FEET_PER_DEGREE_LAT, FEET_PER_DEGREE_LON } = BRC_SURVEY_DATA;

  return {
    x: (lon - GPS_CENTER.lon) * FEET_PER_DEGREE_LON,
    y: (lat - GPS_CENTER.lat) * FEET_PER_DEGREE_LAT
  };
}

/**
 * Convert clock position to degrees
 * 12:00 = 0°, 3:00 = 90°, 6:00 = 180°, 9:00 = 270°
 */
export function clockToDegrees(clock: string): number {
  const [hours, minutes = 0] = clock.split(':').map(Number);
  const totalMinutes = (hours % 12) * 60 + minutes;
  return (totalMinutes / 720) * 360; // 720 minutes in 12 hours = 360°
}

/**
 * Convert degrees to clock position
 */
export function degreesToClock(degrees: number): string {
  const normalizedDegrees = ((degrees % 360) + 360) % 360;
  const totalMinutes = (normalizedDegrees / 360) * 720;
  const hours = Math.floor(totalMinutes / 60);
  const minutes = Math.floor(totalMinutes % 60);

  return `${hours}:${minutes.toString().padStart(2, '0')}`;
}

/**
 * Calculate distance from origin
 */
export function distanceFromMan(x: number, y: number): number {
  return Math.sqrt(x * x + y * y);
}

/**
 * Calculate angle from origin (in degrees, 0° = north)
 */
export function angleFromMan(x: number, y: number): number {
  const radians = Math.atan2(x, y);
  const degrees = (radians * 180 / Math.PI + 360) % 360;
  return degrees;
}

/**
 * Get ring name based on radius
 */
export function getRingName(radius: number): RingName | null {
  const { RINGS } = BRC_SURVEY_DATA;

  if (radius < RINGS.ESPLANADE) return null;
  if (radius < RINGS.AFANC) return 'Esplanade';
  if (radius < RINGS.MIDCITY) return 'Afanc';
  if (radius < RINGS.IGOPOGO) return 'MidCity';
  if (radius < RINGS.KRAKEN) return 'Igopogo';
  return 'Kraken';
}
