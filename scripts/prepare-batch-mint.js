#!/usr/bin/env node
/**
 * Parse CSV and prepare batch minting data for HyperLand parcels
 *
 * This script reads the BRC parcel CSV and generates:
 * 1. JSON file with parcel data for minting
 * 2. Bash script with cast commands for manual minting
 * 3. Analysis report of the parcel distribution
 *
 * Usage:
 *   node scripts/prepare-batch-mint.js
 */

const fs = require('fs');
const path = require('path');

const CSV_PATH = path.join(__dirname, '../data/BRC_ALL_1200_PARCELS.csv');
const OUTPUT_DIR = path.join(__dirname, '../data/processed');

// Create output directory
if (!fs.existsSync(OUTPUT_DIR)) {
  fs.mkdirSync(OUTPUT_DIR, { recursive: true });
}

// Ring to assessed value mapping (in LAND tokens)
const RING_VALUES = {
  'Esplanade': 1000,  // Innermost ring - most valuable
  'MidCity': 800,
  'Afanc': 600,
  'Igopogo': 400,
  'Kraken': 200,      // Outermost ring - least valuable
};

// Standard parcel size (can be adjusted)
const PARCEL_SIZE = 100;

function parseCSV(filePath) {
  const content = fs.readFileSync(filePath, 'utf-8');
  const lines = content.trim().split('\n');
  const headers = lines[0].split(',');

  const parcels = [];

  for (let i = 1; i < lines.length; i++) {
    const values = lines[i].split(',');
    const parcel = {};

    headers.forEach((header, index) => {
      parcel[header] = values[index];
    });

    parcels.push(parcel);
  }

  return parcels;
}

function processParcels(parcels) {
  const processed = parcels.map((parcel, index) => {
    const x = parseInt(parcel.X_Coordinate_Feet);
    const y = parseInt(parcel.Y_Coordinate_Feet);
    const ring = parcel.Ring;
    const assessedValue = RING_VALUES[ring] || 500;

    return {
      index: index,
      parcelId: parcel.Parcel_ID,
      parcelNumber: parseInt(parcel.Parcel_Number),
      ring: ring,
      sector: parcel.Sector,
      address: parcel.Full_Address,
      x: x,
      y: y,
      size: PARCEL_SIZE,
      latitude: parseFloat(parcel.Latitude),
      longitude: parseFloat(parcel.Longitude),
      assessedValue: assessedValue,
      assessedValueWei: (assessedValue * 1e18).toString(),
      innerRadius: parseInt(parcel.Inner_Radius),
      outerRadius: parseInt(parcel.Outer_Radius),
    };
  });

  return processed;
}

function generateAnalytics(parcels) {
  const analytics = {
    totalParcels: parcels.length,
    byRing: {},
    coordinateRanges: {
      x: { min: Infinity, max: -Infinity },
      y: { min: Infinity, max: -Infinity },
    },
    totalValue: 0,
  };

  parcels.forEach(parcel => {
    // Count by ring
    if (!analytics.byRing[parcel.ring]) {
      analytics.byRing[parcel.ring] = {
        count: 0,
        totalValue: 0,
        avgValue: 0,
      };
    }
    analytics.byRing[parcel.ring].count++;
    analytics.byRing[parcel.ring].totalValue += parcel.assessedValue;

    // Coordinate ranges
    analytics.coordinateRanges.x.min = Math.min(analytics.coordinateRanges.x.min, parcel.x);
    analytics.coordinateRanges.x.max = Math.max(analytics.coordinateRanges.x.max, parcel.x);
    analytics.coordinateRanges.y.min = Math.min(analytics.coordinateRanges.y.min, parcel.y);
    analytics.coordinateRanges.y.max = Math.max(analytics.coordinateRanges.y.max, parcel.y);

    // Total value
    analytics.totalValue += parcel.assessedValue;
  });

  // Calculate averages
  Object.keys(analytics.byRing).forEach(ring => {
    const data = analytics.byRing[ring];
    data.avgValue = data.totalValue / data.count;
  });

  return analytics;
}

function generateBatchMintScript(parcels, batchSize = 50) {
  const batches = [];

  for (let i = 0; i < parcels.length; i += batchSize) {
    batches.push(parcels.slice(i, i + batchSize));
  }

  let script = `#!/bin/bash
# Batch Mint Script for HyperLand Parcels
# Generated: ${new Date().toISOString()}
# Total Parcels: ${parcels.length}
# Batch Size: ${batchSize}
# Total Batches: ${batches.length}

# Load environment variables
source .env

# Check required variables
if [ -z "$HYPERLAND_CORE_ADDRESS" ]; then
  echo "Error: HYPERLAND_CORE_ADDRESS not set"
  exit 1
fi

if [ -z "$INITIAL_OWNER" ]; then
  echo "Error: INITIAL_OWNER not set"
  exit 1
fi

if [ -z "$PRIVATE_KEY" ]; then
  echo "Error: PRIVATE_KEY not set"
  exit 1
fi

echo "==================================="
echo "HyperLand Batch Minting"
echo "==================================="
echo "Core: $HYPERLAND_CORE_ADDRESS"
echo "Owner: $INITIAL_OWNER"
echo "Total Parcels: ${parcels.length}"
echo "Batches: ${batches.length}"
echo "-----------------------------------"
echo ""

`;

  batches.forEach((batch, batchIndex) => {
    script += `\n# Batch ${batchIndex + 1}/${batches.length} (Parcels ${batchIndex * batchSize + 1}-${Math.min((batchIndex + 1) * batchSize, parcels.length)})\n`;
    script += `echo "Processing batch ${batchIndex + 1}/${batches.length}..."\n\n`;

    batch.forEach((parcel) => {
      script += `# ${parcel.parcelId}: ${parcel.address}\n`;
      script += `cast send $HYPERLAND_CORE_ADDRESS \\\n`;
      script += `  "mintParcel(address,uint256,uint256,uint256,uint256)" \\\n`;
      script += `  $INITIAL_OWNER \\\n`;
      script += `  ${parcel.x} \\\n`;
      script += `  ${parcel.y} \\\n`;
      script += `  ${parcel.size} \\\n`;
      script += `  ${parcel.assessedValueWei} \\\n`;
      script += `  --rpc-url base_sepolia \\\n`;
      script += `  --private-key $PRIVATE_KEY \\\n`;
      script += `  --gas-limit 500000\n\n`;
    });

    script += `echo "Batch ${batchIndex + 1} complete. Sleeping 5 seconds..."\n`;
    script += `sleep 5\n`;
  });

  script += `\necho ""\necho "==================================="\necho "Minting Complete!"\necho "==================================="\necho "Total Parcels Minted: ${parcels.length}"\n`;

  return script;
}

function main() {
  console.log('🔍 Reading CSV file...');
  const rawParcels = parseCSV(CSV_PATH);
  console.log(`   Found ${rawParcels.length} parcels\n`);

  console.log('⚙️  Processing parcel data...');
  const parcels = processParcels(rawParcels);
  console.log(`   Processed ${parcels.length} parcels\n`);

  console.log('📊 Generating analytics...');
  const analytics = generateAnalytics(parcels);
  console.log('   Analytics complete\n');

  // Save processed data
  const dataPath = path.join(OUTPUT_DIR, 'parcels-processed.json');
  fs.writeFileSync(dataPath, JSON.stringify(parcels, null, 2));
  console.log(`✅ Saved processed data: ${dataPath}`);

  // Save analytics
  const analyticsPath = path.join(OUTPUT_DIR, 'analytics.json');
  fs.writeFileSync(analyticsPath, JSON.stringify(analytics, null, 2));
  console.log(`✅ Saved analytics: ${analyticsPath}`);

  // Generate batch mint script
  console.log('\n🔨 Generating mint script...');
  const mintScript = generateBatchMintScript(parcels, 50);
  const scriptPath = path.join(OUTPUT_DIR, 'mint-all-parcels.sh');
  fs.writeFileSync(scriptPath, mintScript);
  fs.chmodSync(scriptPath, '755'); // Make executable
  console.log(`✅ Saved mint script: ${scriptPath}`);

  // Print analytics summary
  console.log('\n📈 Analytics Summary:');
  console.log('   ===================');
  console.log(`   Total Parcels: ${analytics.totalParcels}`);
  console.log(`   Total Value: ${analytics.totalValue.toLocaleString()} LAND`);
  console.log(`\n   By Ring:`);
  Object.entries(analytics.byRing).forEach(([ring, data]) => {
    console.log(`   ${ring.padEnd(12)}: ${data.count.toString().padStart(4)} parcels, ${data.avgValue.toString().padStart(4)} LAND avg`);
  });
  console.log(`\n   Coordinate Ranges:`);
  console.log(`   X: ${analytics.coordinateRanges.x.min} to ${analytics.coordinateRanges.x.max}`);
  console.log(`   Y: ${analytics.coordinateRanges.y.min} to ${analytics.coordinateRanges.y.max}`);

  console.log('\n✨ Done! Next steps:');
  console.log('   1. Review the processed data and analytics');
  console.log('   2. Update .env with HYPERLAND_CORE_ADDRESS and INITIAL_OWNER');
  console.log('   3. Run the mint script: ./data/processed/mint-all-parcels.sh');
  console.log('   4. Monitor gas usage and adjust batch size if needed\n');
}

main();
