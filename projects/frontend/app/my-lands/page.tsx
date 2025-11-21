export default function MyLands() {
  // Mock data - will be replaced with smart contract data
  const myParcels = [
    {
      id: 1,
      coordinates: { x: 10, y: 20 },
      size: 100,
      assessedValue: 500,
      taxDue: 25,
      listedForSale: false,
    },
    {
      id: 2,
      coordinates: { x: 15, y: 25 },
      size: 150,
      assessedValue: 750,
      taxDue: 0,
      listedForSale: true,
      listPrice: 900,
    },
  ];

  const landBalance = 1250; // Mock LAND token balance

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="text-4xl font-bold">My Lands</h1>
        <div className="bg-blue-100 dark:bg-blue-900 px-6 py-3 rounded-lg">
          <p className="text-sm text-gray-600 dark:text-gray-300">
            LAND Balance
          </p>
          <p className="text-2xl font-bold text-blue-600 dark:text-blue-400">
            {landBalance} LAND
          </p>
        </div>
      </div>

      {/* Buy LAND Section */}
      <div className="border rounded-lg p-6 bg-gradient-to-r from-green-50 to-blue-50 dark:from-gray-800 dark:to-gray-700">
        <h2 className="text-2xl font-bold mb-4">Buy LAND Tokens</h2>
        <div className="flex gap-4">
          <input
            type="number"
            placeholder="Amount in ETH"
            className="border rounded px-4 py-2 flex-1 dark:bg-gray-800"
          />
          <button className="bg-green-600 hover:bg-green-700 text-white px-6 py-2 rounded">
            Buy LAND
          </button>
        </div>
        <p className="text-sm text-gray-600 dark:text-gray-300 mt-2">
          You receive 80% in LAND tokens, 20% goes to treasury
        </p>
      </div>

      {/* My Parcels */}
      <div>
        <h2 className="text-2xl font-bold mb-4">My Parcels</h2>
        {myParcels.length === 0 ? (
          <div className="text-center py-12 border rounded-lg bg-gray-50 dark:bg-gray-800">
            <p className="text-xl text-gray-600 dark:text-gray-300 mb-4">
              You don't own any land parcels yet
            </p>
            <a
              href="/marketplace"
              className="bg-blue-600 hover:bg-blue-700 text-white px-6 py-3 rounded inline-block"
            >
              Browse Marketplace
            </a>
          </div>
        ) : (
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            {myParcels.map((parcel) => (
              <div
                key={parcel.id}
                className="border rounded-lg p-6 bg-white dark:bg-gray-800"
              >
                <div className="flex justify-between items-start mb-4">
                  <div>
                    <h3 className="text-xl font-bold mb-2">
                      Parcel #{parcel.id}
                    </h3>
                    <p className="text-gray-600 dark:text-gray-300">
                      Location: ({parcel.coordinates.x}, {parcel.coordinates.y})
                    </p>
                    <p className="text-gray-600 dark:text-gray-300">
                      Size: {parcel.size} sq units
                    </p>
                  </div>
                  {parcel.listedForSale && (
                    <span className="bg-green-100 text-green-800 px-3 py-1 rounded-full text-sm">
                      For Sale
                    </span>
                  )}
                </div>

                <div className="grid grid-cols-2 gap-4 mb-4 p-4 bg-gray-50 dark:bg-gray-700 rounded">
                  <div>
                    <p className="text-sm text-gray-600 dark:text-gray-400">
                      Assessed Value
                    </p>
                    <p className="text-lg font-bold">
                      {parcel.assessedValue} LAND
                    </p>
                  </div>
                  <div>
                    <p className="text-sm text-gray-600 dark:text-gray-400">
                      Tax Due
                    </p>
                    <p
                      className={`text-lg font-bold ${
                        parcel.taxDue > 0 ? "text-red-600" : "text-green-600"
                      }`}
                    >
                      {parcel.taxDue} LAND
                    </p>
                  </div>
                </div>

                <div className="space-y-2">
                  {parcel.taxDue > 0 && (
                    <button className="w-full bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded">
                      Pay Taxes ({parcel.taxDue} LAND)
                    </button>
                  )}
                  {parcel.listedForSale ? (
                    <button className="w-full bg-gray-600 hover:bg-gray-700 text-white px-4 py-2 rounded">
                      Remove from Sale
                    </button>
                  ) : (
                    <button className="w-full bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded">
                      List for Sale
                    </button>
                  )}
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
