/**
 * BRC Parcel Grid System
 *
 * Based on Burning Man's Black Rock City layout with 1200 parcels
 * Uses X,Y coordinates from BRC_ALL_1200_PARCELS.csv
 *
 * Coordinate system:
 * - X,Y coordinates are in feet from the CSV
 * - We scale them for the 3D world (1 foot = 1 unit by default)
 */

// Cache for loaded parcel data
let parcelData = null

/**
 * Load parcel data from CSV (will be loaded from server/database in production)
 * For now, parcels will be loaded dynamically as needed
 * @returns {Array} Array of parcel objects
 */
export function getParcelData() {
  // In production, this would fetch from database or server
  // For now, return empty array - parcels will be loaded via API
  return parcelData || []
}

/**
 * Find the nearest parcel to a given world position
 * @param {number} x - World X position
 * @param {number} y - World Y position (height)
 * @param {number} z - World Z position
 * @param {Array} parcels - Array of parcel data
 * @returns {Object|null} Nearest parcel or null
 */
export function getNearestParcel(x, y, z, parcels) {
  if (!parcels || parcels.length === 0) return null

  let nearestParcel = null
  let minDistance = Infinity

  for (const parcel of parcels) {
    // Calculate 2D distance (ignore Y/height)
    const dx = x - parcel.x
    const dz = z - parcel.y // CSV Y maps to world Z
    const distance = Math.sqrt(dx * dx + dz * dz)

    if (distance < minDistance) {
      minDistance = distance
      nearestParcel = parcel
    }
  }

  // Only return if within reasonable range (e.g., 500 units)
  return minDistance < 500 ? nearestParcel : null
}

/**
 * Get parcel by ID
 * @param {string} parcelId - Parcel ID (e.g., "BRC-0001")
 * @param {Array} parcels - Array of parcel data
 * @returns {Object|null} Parcel or null
 */
export function getParcelById(parcelId, parcels) {
  if (!parcels) return null
  return parcels.find(p => p.id === parcelId) || null
}

/**
 * Convert parcel CSV row to parcel object
 * @param {Object} row - CSV row object
 * @returns {Object} Parcel object
 */
export function parseParcelRow(row) {
  return {
    id: row.Parcel_ID,
    number: parseInt(row.Parcel_Number),
    ring: row.Ring,
    sector: row.Sector,
    address: row.Full_Address,
    x: parseFloat(row.X_Coordinate_Feet),
    y: parseFloat(row.Y_Coordinate_Feet),
    latitude: parseFloat(row.Latitude),
    longitude: parseFloat(row.Longitude),
    innerRadius: parseInt(row.Inner_Radius),
    outerRadius: parseInt(row.Outer_Radius)
  }
}

/**
 * Set parcel data (called when loaded from server)
 * @param {Array} data - Array of parcel objects
 */
export function setParcelData(data) {
  parcelData = data
}

/**
 * Check if a position is within parcel bounds
 * @param {number} x - World X position
 * @param {number} z - World Z position
 * @param {Object} parcel - Parcel object
 * @param {number} tolerance - Distance tolerance in units
 * @returns {boolean} True if within bounds
 */
export function isWithinParcel(x, z, parcel, tolerance = 50) {
  const dx = x - parcel.x
  const dz = z - parcel.y
  const distance = Math.sqrt(dx * dx + dz * dz)
  return distance <= tolerance
}
