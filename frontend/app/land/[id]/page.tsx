export default function LandDetail({ params }: { params: { id: string } }) {
  // Mock data - will be replaced with smart contract data
  const parcel = {
    id: params.id,
    coordinates: { x: 10, y: 20 },
    size: 100,
    assessedValue: 500,
    taxDue: 25,
    owner: "0x1234...5678",
    lastTaxPaidCycle: 10,
    currentCycle: 12,
    listedForSale: false,
    listPrice: 0,
    history: [
      {
        event: "Purchased",
        from: "0x0000...0000",
        to: "0x1234...5678",
        price: 450,
        date: "2024-01-15",
      },
      {
        event: "Tax Paid",
        amount: 25,
        date: "2024-02-01",
      },
    ],
  };

  return (
    <div className="max-w-4xl mx-auto space-y-6">
      <div className="flex justify-between items-start">
        <div>
          <h1 className="text-4xl font-bold mb-2">Parcel #{parcel.id}</h1>
          <p className="text-gray-600 dark:text-gray-300">
            Location: ({parcel.coordinates.x}, {parcel.coordinates.y})
          </p>
        </div>
        {parcel.listedForSale && (
          <span className="bg-green-100 text-green-800 px-4 py-2 rounded-full">
            For Sale
          </span>
        )}
      </div>

      {/* Main Info */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div className="border rounded-lg p-6 bg-white dark:bg-gray-800">
          <h2 className="text-xl font-bold mb-4">Parcel Details</h2>
          <div className="space-y-3">
            <div className="flex justify-between">
              <span className="text-gray-600 dark:text-gray-400">Size</span>
              <span className="font-semibold">{parcel.size} sq units</span>
            </div>
            <div className="flex justify-between">
              <span className="text-gray-600 dark:text-gray-400">
                Assessed Value
              </span>
              <span className="font-semibold">{parcel.assessedValue} LAND</span>
            </div>
            <div className="flex justify-between">
              <span className="text-gray-600 dark:text-gray-400">Owner</span>
              <span className="font-mono text-sm">{parcel.owner}</span>
            </div>
          </div>
        </div>

        <div className="border rounded-lg p-6 bg-white dark:bg-gray-800">
          <h2 className="text-xl font-bold mb-4">Tax Information</h2>
          <div className="space-y-3">
            <div className="flex justify-between">
              <span className="text-gray-600 dark:text-gray-400">
                Current Cycle
              </span>
              <span className="font-semibold">{parcel.currentCycle}</span>
            </div>
            <div className="flex justify-between">
              <span className="text-gray-600 dark:text-gray-400">
                Last Paid Cycle
              </span>
              <span className="font-semibold">{parcel.lastTaxPaidCycle}</span>
            </div>
            <div className="flex justify-between">
              <span className="text-gray-600 dark:text-gray-400">Tax Due</span>
              <span
                className={`font-semibold ${
                  parcel.taxDue > 0 ? "text-red-600" : "text-green-600"
                }`}
              >
                {parcel.taxDue} LAND
              </span>
            </div>
          </div>
        </div>
      </div>

      {/* Sale Info */}
      {parcel.listedForSale && (
        <div className="border rounded-lg p-6 bg-gradient-to-r from-green-50 to-blue-50 dark:from-gray-800 dark:to-gray-700">
          <div className="flex justify-between items-center">
            <div>
              <h2 className="text-2xl font-bold mb-2">Listed for Sale</h2>
              <p className="text-3xl font-bold text-green-600">
                {parcel.listPrice} LAND
              </p>
            </div>
            <button className="bg-blue-600 hover:bg-blue-700 text-white px-8 py-3 rounded text-lg">
              Buy Now
            </button>
          </div>
        </div>
      )}

      {/* History */}
      <div className="border rounded-lg p-6 bg-white dark:bg-gray-800">
        <h2 className="text-xl font-bold mb-4">Transaction History</h2>
        <div className="space-y-4">
          {parcel.history.map((event, index) => (
            <div
              key={index}
              className="flex justify-between items-center py-3 border-b last:border-b-0"
            >
              <div>
                <p className="font-semibold">{event.event}</p>
                {event.event === "Purchased" ? (
                  <p className="text-sm text-gray-600 dark:text-gray-400">
                    From {event.from} to {event.to}
                  </p>
                ) : null}
                <p className="text-sm text-gray-500">{event.date}</p>
              </div>
              <div className="text-right">
                {event.event === "Purchased" && (
                  <p className="font-semibold">{event.price} LAND</p>
                )}
                {event.event === "Tax Paid" && (
                  <p className="font-semibold text-red-600">
                    -{event.amount} LAND
                  </p>
                )}
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
