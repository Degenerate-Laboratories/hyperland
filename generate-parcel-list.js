/**
 * Generate complete list of all 1,200 BRC parcels
 * Run with: node generate-parcel-list.js
 */

// BRC Survey Data
const BRC_RINGS = {
  ESPLANADE: 2500,
  AFANC: 3450,
  MIDCITY: 5200,
  IGOPOGO: 7675,
  KRAKEN: 11690
};

const RINGS = [
  { name: 'Esplanade', innerRadius: 0, outerRadius: BRC_RINGS.ESPLANADE },
  { name: 'Afanc', innerRadius: BRC_RINGS.ESPLANADE, outerRadius: BRC_RINGS.AFANC },
  { name: 'MidCity', innerRadius: BRC_RINGS.AFANC, outerRadius: BRC_RINGS.MIDCITY },
  { name: 'Igopogo', innerRadius: BRC_RINGS.MIDCITY, outerRadius: BRC_RINGS.IGOPOGO },
  { name: 'Kraken', innerRadius: BRC_RINGS.IGOPOGO, outerRadius: BRC_RINGS.KRAKEN }
];

// GPS Center (The Man)
const GPS_CENTER = { lat: 40.7864, lon: -119.2065 };
const FEET_PER_DEGREE_LAT = 364000;
const FEET_PER_DEGREE_LON = 288200;

// Generate sectors from 2:00 to 10:00 (60° to 300°)
function generateSectors() {
  const sectors = [];
  for (let angle = 60; angle <= 300; angle += 1) {
    const hours = Math.floor(angle / 30);
    const minutes = Math.floor(((angle % 30) / 30) * 60);
    const name = `${hours}:${minutes.toString().padStart(2, '0')}`;
    sectors.push({ start: angle, end: angle + 1, name });
  }
  return sectors;
}

// Calculate centroid of annular sector
function calculateCentroid(innerRadius, outerRadius, startAngle, endAngle) {
  const startRad = (startAngle * Math.PI) / 180;
  const endRad = (endAngle * Math.PI) / 180;
  const midAngle = (startRad + endRad) / 2;
  const midRadius = (innerRadius + outerRadius) / 2;

  return {
    x: midRadius * Math.cos(midAngle),
    y: midRadius * Math.sin(midAngle)
  };
}

// Convert feet to lat/lon
function feetToLatLon(x, y) {
  return {
    lat: GPS_CENTER.lat + (y / FEET_PER_DEGREE_LAT),
    lon: GPS_CENTER.lon + (x / FEET_PER_DEGREE_LON)
  };
}

// Generate all parcels
function generateAllParcels() {
  const parcels = [];
  const sectors = generateSectors();
  let parcelId = 1;

  for (const ring of RINGS) {
    for (const sector of sectors) {
      const centroid = calculateCentroid(
        ring.innerRadius,
        ring.outerRadius,
        sector.start,
        sector.end
      );

      const { lat, lon } = feetToLatLon(centroid.x, centroid.y);

      parcels.push({
        id: `BRC-${parcelId.toString().padStart(4, '0')}`,
        parcel_number: parcelId,
        ring: ring.name,
        sector: sector.name,
        address: `${sector.name} & ${ring.name}`,
        x_feet: Math.round(centroid.x),
        y_feet: Math.round(centroid.y),
        latitude: lat.toFixed(6),
        longitude: lon.toFixed(6),
        inner_radius: ring.innerRadius,
        outer_radius: ring.outerRadius
      });

      parcelId++;
    }
  }

  return parcels;
}

// Generate CSV
function generateCSV(parcels) {
  const headers = [
    'Parcel_ID',
    'Parcel_Number',
    'Ring',
    'Sector',
    'Full_Address',
    'X_Coordinate_Feet',
    'Y_Coordinate_Feet',
    'Latitude',
    'Longitude',
    'Inner_Radius',
    'Outer_Radius'
  ];

  let csv = headers.join(',') + '\n';

  for (const parcel of parcels) {
    csv += [
      parcel.id,
      parcel.parcel_number,
      parcel.ring,
      parcel.sector,
      `"${parcel.address}"`,
      parcel.x_feet,
      parcel.y_feet,
      parcel.latitude,
      parcel.longitude,
      parcel.inner_radius,
      parcel.outer_radius
    ].join(',') + '\n';
  }

  return csv;
}

// Main execution
console.log('Generating all 1,200 BRC parcels...');
const parcels = generateAllParcels();
console.log(`Generated ${parcels.length} parcels`);

const csv = generateCSV(parcels);
const fs = require('fs');
const path = require('path');

const outputPath = path.join(__dirname, 'BRC_ALL_1200_PARCELS.csv');
fs.writeFileSync(outputPath, csv);

console.log(`\n✅ Complete! File saved to:`);
console.log(`   ${outputPath}`);
console.log(`\n📊 Summary:`);
console.log(`   Total Parcels: ${parcels.length}`);
console.log(`   Rings: 5 (Esplanade, Afanc, MidCity, Igopogo, Kraken)`);
console.log(`   Sectors: 241 (from 2:00 to 10:00)`);
console.log(`   Format: CSV with coordinates and labels`);
