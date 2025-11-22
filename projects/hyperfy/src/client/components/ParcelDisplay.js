import { css } from '@firebolt-dev/css'
import { useState, useEffect, useRef } from 'react'
import { getNearestParcel } from '../../core/systems/parcelGrid'
import { storage } from '../../core/storage'

export function ParcelDisplay({ world }) {
  const [currentParcel, setCurrentParcel] = useState({ id: null, address: 'Unknown', owner: null })
  const [purchasing, setPurchasing] = useState(false)
  const [purchaseError, setPurchaseError] = useState(null)
  const animationFrameRef = useRef()
  const lastParcelRef = useRef(null)
  const [parcelsData, setParcelsData] = useState([])

  // Load parcel data on mount
  useEffect(() => {
    const loadParcels = async () => {
      try {
        const response = await fetch('/api/parcels')
        const data = await response.json()
        setParcelsData(data.parcels || [])
      } catch (error) {
        console.error('Failed to load parcels:', error)
      }
    }
    loadParcels()
  }, [])

  useEffect(() => {
    if (!world || parcelsData.length === 0) return

    // Update parcel position on animation frame
    const updateParcel = () => {
      const player = world.entities.player
      if (player) {
        let pos = null

        // Get player position (same methods as PositionDisplay)
        if (player.base && player.base.position) {
          pos = player.base.position
        } else if (player.capsule) {
          try {
            const pose = player.capsule.getGlobalPose()
            if (pose && pose.p) {
              pos = { x: pose.p.x, y: pose.p.y, z: pose.p.z }
            }
          } catch (e) {
            // Capsule might not be available yet
          }
        } else if (player.transform && player.transform.position) {
          pos = player.transform.position
        } else if (player.data && player.data.position) {
          pos = player.data.position
        } else if (player.mesh && player.mesh.position) {
          pos = player.mesh.position
        }

        if (pos) {
          // Get nearest parcel from position
          const parcel = getNearestParcel(pos.x, pos.y, pos.z, parcelsData)

          // Only update if parcel changed
          if (parcel && parcel.id !== lastParcelRef.current) {
            lastParcelRef.current = parcel.id

            // Get ownership info if system is available
            let ownerData = null
            if (world.parcelOwnership) {
              ownerData = world.parcelOwnership.getParcelOwner(parcel.id)
            }

            setCurrentParcel({
              id: parcel.id,
              number: parcel.number,
              ring: parcel.ring,
              sector: parcel.sector,
              address: parcel.address,
              owner: ownerData
            })
          } else if (!parcel && lastParcelRef.current !== null) {
            lastParcelRef.current = null
            setCurrentParcel({
              id: null,
              address: 'Outside Parcels',
              owner: null
            })
          }
        }
      }
      animationFrameRef.current = requestAnimationFrame(updateParcel)
    }

    // Start the update loop
    updateParcel()

    // Cleanup
    return () => {
      if (animationFrameRef.current) {
        cancelAnimationFrame(animationFrameRef.current)
      }
    }
  }, [world, parcelsData])

  const handlePurchase = async () => {
    if (!currentParcel.id) return

    setPurchasing(true)
    setPurchaseError(null)

    try {
      const authToken = storage.get('authToken')
      if (!authToken || authToken === 'null') {
        throw new Error('Please log in to purchase parcels')
      }

      const response = await fetch(`/api/parcel-ownership/${currentParcel.id}/purchase`, {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${authToken}`,
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
      })

      const data = await response.json()

      if (!response.ok) {
        throw new Error(data.error || 'Failed to purchase parcel')
      }

      // Success!
      setPurchaseError(`Success! You now own ${currentParcel.address}!`)
      setTimeout(() => setPurchaseError(null), 5000)

    } catch (error) {
      setPurchaseError(error.message || 'Purchase failed')
      setTimeout(() => setPurchaseError(null), 5000)
    } finally {
      setPurchasing(false)
    }
  }

  if (!currentParcel.id) {
    return null // Don't show display if no parcel
  }

  return (
    <div
      className='parcel-display'
      css={css`
        position: absolute;
        top: 4.5rem;
        left: 50%;
        transform: translateX(-50%);
        z-index: 998;
        pointer-events: none;
        background: linear-gradient(135deg, rgba(20, 10, 30, 0.9) 0%, rgba(40, 20, 60, 0.9) 50%, rgba(20, 10, 30, 0.9) 100%);
        border: 1px solid rgba(0, 255, 255, 0.3);
        border-radius: 0.5rem;
        padding: 0.5rem 1rem;
        backdrop-filter: blur(10px);
        box-shadow:
          0 0 20px rgba(0, 255, 255, 0.2),
          inset 0 0 10px rgba(0, 255, 255, 0.1);
        min-width: 250px;
      `}
    >
      <div
        css={css`
          display: flex;
          flex-direction: column;
          align-items: center;
          gap: 0.3rem;
          font-family: 'Courier New', monospace;
        `}
      >
        {/* Parcel ID */}
        <div
          css={css`
            display: flex;
            align-items: center;
            gap: 0.5rem;
          `}
        >
          <span
            css={css`
              color: rgba(255, 255, 255, 0.4);
              font-size: 0.7rem;
              text-transform: uppercase;
            `}
          >
            Parcel:
          </span>
          <span
            css={css`
              color: #00ffff;
              font-weight: 700;
              font-size: 0.9rem;
              text-shadow: 0 0 8px rgba(0, 255, 255, 0.8);
            `}
          >
            {currentParcel.id}
          </span>
        </div>

        {/* Address */}
        <div
          css={css`
            color: rgba(255, 255, 255, 0.9);
            font-size: 0.8rem;
            text-align: center;
            font-weight: 500;
            letter-spacing: 0.05em;
            text-shadow: 0 0 3px rgba(0, 255, 255, 0.4);
          `}
        >
          {currentParcel.address}
        </div>

        {/* Ownership Status or Buy Button */}
        <div
          css={css`
            margin-top: 0.3rem;
            padding-top: 0.3rem;
            border-top: 1px solid rgba(0, 255, 255, 0.2);
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.2rem;
            width: 100%;
          `}
        >
          {currentParcel.owner ? (
            // Show ownership info
            <>
              <div
                css={css`
                  color: rgba(255, 100, 100, 0.8);
                  font-size: 0.7rem;
                  font-weight: 600;
                  text-transform: uppercase;
                  letter-spacing: 0.05em;
                `}
              >
                🔒 Owned
              </div>
              <div
                css={css`
                  color: rgba(255, 200, 100, 0.9);
                  font-size: 0.7rem;
                  font-weight: 500;
                `}
              >
                Owner: {currentParcel.owner.displayName}
              </div>
            </>
          ) : (
            // Show Buy button
            <button
              onClick={handlePurchase}
              disabled={purchasing}
              css={css`
                pointer-events: auto !important;
                background: linear-gradient(135deg, #00ffff 0%, #00cccc 100%);
                border: 2px solid rgba(255, 255, 255, 0.3);
                border-radius: 0.4rem;
                padding: 0.5rem 1.2rem;
                color: black;
                font-weight: 700;
                font-size: 0.75rem;
                text-transform: uppercase;
                letter-spacing: 0.05em;
                cursor: pointer;
                transition: all 0.2s;
                box-shadow:
                  0 0 20px rgba(0, 255, 255, 0.3),
                  0 0 40px rgba(0, 255, 255, 0.2);
                z-index: 9999;
                position: relative;

                &:hover:not(:disabled) {
                  transform: scale(1.05);
                  box-shadow:
                    0 0 30px rgba(0, 255, 255, 0.5),
                    0 0 60px rgba(0, 255, 255, 0.3);
                }

                &:active:not(:disabled) {
                  transform: scale(0.95);
                }

                &:disabled {
                  opacity: 0.5;
                  cursor: not-allowed;
                }
              `}
            >
              {purchasing ? '⏳ Purchasing...' : '🏆 Claim Parcel'}
            </button>
          )}
        </div>

        {/* Purchase Error/Success Message */}
        {purchaseError && (
          <div
            css={css`
              margin-top: 0.3rem;
              padding: 0.4rem;
              background: ${purchaseError.includes('Success')
                ? 'rgba(0, 255, 255, 0.1)'
                : 'rgba(255, 100, 100, 0.1)'};
              border: 1px solid ${purchaseError.includes('Success')
                ? 'rgba(0, 255, 255, 0.3)'
                : 'rgba(255, 100, 100, 0.3)'};
              border-radius: 0.3rem;
              color: ${purchaseError.includes('Success')
                ? 'rgba(0, 255, 255, 0.9)'
                : 'rgba(255, 150, 150, 0.9)'};
              font-size: 0.65rem;
              text-align: center;
            `}
          >
            {purchaseError}
          </div>
        )}
      </div>
    </div>
  )
}
