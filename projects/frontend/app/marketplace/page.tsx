export default function Marketplace() {
  // Mock data - will be replaced with smart contract data
  const listings = [
    {
      id: 1,
      coordinates: { x: 10, y: 20 },
      size: 100,
      price: 500,
      seller: "0x1234...5678",
    },
    {
      id: 2,
      coordinates: { x: 15, y: 25 },
      size: 150,
      price: 750,
      seller: "0xabcd...efgh",
    },
    {
      id: 3,
      coordinates: { x: 5, y: 30 },
      size: 200,
      price: 1000,
      seller: "0x9876...4321",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h1 className="text-4xl font-bold">Marketplace</h1>
        <div className="space-x-2">
          <select className="border rounded px-4 py-2 dark:bg-gray-800">
            <option>All Sizes</option>
            <option>Small (0-100)</option>
            <option>Medium (100-200)</option>
            <option>Large (200+)</option>
          </select>
          <select className="border rounded px-4 py-2 dark:bg-gray-800">
            <option>Price: Low to High</option>
            <option>Price: High to Low</option>
            <option>Size: Small to Large</option>
            <option>Size: Large to Small</option>
          </select>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {listings.map((listing) => (
          <div
            key={listing.id}
            className="border rounded-lg p-6 bg-white dark:bg-gray-800 hover:shadow-lg transition-shadow"
          >
            <div className="mb-4">
              <h3 className="text-xl font-bold mb-2">
                Parcel #{listing.id}
              </h3>
              <p className="text-gray-600 dark:text-gray-300">
                Location: ({listing.coordinates.x}, {listing.coordinates.y})
              </p>
              <p className="text-gray-600 dark:text-gray-300">
                Size: {listing.size} sq units
              </p>
            </div>
            <div className="mb-4">
              <p className="text-sm text-gray-500 dark:text-gray-400">
                Seller: {listing.seller}
              </p>
            </div>
            <div className="flex justify-between items-center">
              <div>
                <p className="text-sm text-gray-600 dark:text-gray-400">
                  Price
                </p>
                <p className="text-2xl font-bold text-green-600">
                  {listing.price} LAND
                </p>
              </div>
              <button className="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded">
                Buy Now
              </button>
            </div>
          </div>
        ))}
      </div>

      {listings.length === 0 && (
        <div className="text-center py-12">
          <p className="text-xl text-gray-600 dark:text-gray-300">
            No parcels currently listed for sale
          </p>
        </div>
      )}
    </div>
  );
}
