import { css } from '@firebolt-dev/css'
import { useState, useEffect, useRef } from 'react'
import {
  generateHexGrid,
  getHexIdAtPosition,
  getHexAtPosition
} from '../../core/systems/hexGrid'
import { storage } from '../../core/storage'

// Hex names mapping - expanded for full grid
const hexNames = {
  0: 'Origin Plaza',
  1: 'North Market',
  2: 'Crystal Gardens',
  3: 'Tech District',
  4: 'Harbor View',
  5: 'Old Town',
  6: 'Sky Bridge',
  7: 'Neon Quarter',
  8: 'Data Center',
  9: 'Trading Post',
  10: 'Cyber Plaza',
  11: 'Virtual Park',
  12: 'Innovation Hub',
  13: 'Sunset Docks',
  14: 'East Village',
  15: 'Blockchain Boulevard',
  16: 'NFT District',
  17: 'Meta Mall',
  18: 'Digital Square',
  19: 'Degen Alley',
  20: 'Crypto Corner',
  21: 'Pixel Heights',
  22: 'Code Valley',
  23: 'Token Tower',
  24: 'Smart Contract Street',
  25: 'Web3 Way',
  26: 'DAO District',
  27: 'DeFi Plaza',
  28: 'GameFi Gardens',
  29: 'Metaverse Mile',
  30: 'Virtual Vista'
}

export function HexDisplay({ world }) {
  const [currentHex, setCurrentHex] = useState({ id: -1, q: 0, r: 0, name: 'Unknown', owner: null })
  const [purchasing, setPurchasing] = useState(false)
  const [purchaseError, setPurchaseError] = useState(null)
  const animationFrameRef = useRef()
  const lastHexRef = useRef(-1)
  const hexGridRef = useRef(null)

  useEffect(() => {
    if (!world) return

    // Generate hex grid on mount (5 rings = 91 hexes)
    if (!hexGridRef.current) {
      hexGridRef.current = generateHexGrid(5)
      console.log('Hex grid generated with', hexGridRef.current.length, 'hexes')
    }

    // Update hex position on animation frame
    const updateHex = () => {
      const player = world.entities.player
      if (player && hexGridRef.current) {
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
          // Get current hex from position
          const hexData = getHexAtPosition(pos.x, pos.z, hexGridRef.current)
          const hexId = hexData ? hexData.id : -1

          // Only update if hex changed
          if (hexId !== lastHexRef.current) {
            lastHexRef.current = hexId

            if (hexData) {
              // Get ownership info if system is available
              let ownerData = null
              if (world.hexOwnership) {
                ownerData = world.hexOwnership.getHexOwner(hexData.id)
              }

              setCurrentHex({
                id: hexData.id,
                q: hexData.q,
                r: hexData.r,
                name: hexNames[hexData.id] || `Sector ${hexData.id}`,
                owner: ownerData
              })
            } else {
              setCurrentHex({
                id: -1,
                q: 0,
                r: 0,
                name: 'Outer Regions',
                owner: null
              })
            }
          }
        }
      }
      animationFrameRef.current = requestAnimationFrame(updateHex)
    }

    // Start the update loop
    updateHex()

    // Cleanup
    return () => {
      if (animationFrameRef.current) {
        cancelAnimationFrame(animationFrameRef.current)
      }
    }
  }, [world])

  const handlePurchase = async () => {
    if (currentHex.id < 0) return
    if (currentHex.id === 0) {
      setPurchaseError('Hex 0 (Origin Plaza) cannot be purchased')
      setTimeout(() => setPurchaseError(null), 3000)
      return
    }

    setPurchasing(true)
    setPurchaseError(null)

    try {
      const authToken = storage.get('authToken')
      if (!authToken || authToken === 'null') {
        throw new Error('Please log in to purchase hexes')
      }

      const response = await fetch(`/api/hex-ownership/${currentHex.id}/purchase`, {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${authToken}`,
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({}) // Empty body to satisfy content-type
      })

      const data = await response.json()

      if (!response.ok) {
        throw new Error(data.error || 'Failed to purchase hex')
      }

      // Success! The ownership will be updated via the network event
      // Show success message briefly
      setPurchaseError(`Success! You now own ${currentHex.name}!`)
      setTimeout(() => setPurchaseError(null), 5000)

    } catch (error) {
      setPurchaseError(error.message || 'Purchase failed')
      setTimeout(() => setPurchaseError(null), 5000)
    } finally {
      setPurchasing(false)
    }
  }

  return (
    <div
      className='hex-display'
      css={css`
        position: absolute;
        top: 3.5rem;
        left: 50%;
        transform: translateX(-50%);
        z-index: 998;
        pointer-events: none;
        background: linear-gradient(135deg, rgba(20, 10, 30, 0.9) 0%, rgba(40, 20, 60, 0.9) 50%, rgba(20, 10, 30, 0.9) 100%);
        border: 1px solid rgba(255, 100, 255, 0.3);
        border-radius: 0.5rem;
        padding: 0.4rem 1rem;
        backdrop-filter: blur(10px);
        box-shadow:
          0 0 20px rgba(255, 100, 255, 0.15),
          inset 0 0 10px rgba(255, 100, 255, 0.1);
        min-width: 200px;
      `}
    >
      <div
        css={css`
          display: flex;
          flex-direction: column;
          align-items: center;
          gap: 0.2rem;
          font-family: 'Courier New', monospace;
        `}
      >
        {/* Hex ID and Coordinates */}
        <div
          css={css`
            display: flex;
            align-items: center;
            gap: 1rem;
            width: 100%;
            justify-content: center;
          `}
        >
          <div
            css={css`
              display: flex;
              align-items: center;
              gap: 0.4rem;
            `}
          >
            <span
              css={css`
                color: rgba(255, 255, 255, 0.4);
                font-size: 0.7rem;
                text-transform: uppercase;
              `}
            >
              Hex:
            </span>
            <span
              css={css`
                color: #ff66ff;
                font-weight: 700;
                font-size: 0.9rem;
                text-shadow: 0 0 8px rgba(255, 100, 255, 0.8);
              `}
            >
              {currentHex.id >= 0 ? `#${currentHex.id}` : '--'}
            </span>
          </div>

          {currentHex.id >= 0 && (
            <div
              css={css`
                display: flex;
                align-items: center;
                gap: 0.3rem;
                color: rgba(255, 150, 255, 0.6);
                font-size: 0.65rem;
              `}
            >
              <span>({currentHex.q},{currentHex.r})</span>
            </div>
          )}
        </div>

        {/* Location Name */}
        <div
          css={css`
            color: rgba(255, 255, 255, 0.9);
            font-size: 0.75rem;
            text-align: center;
            font-weight: 500;
            letter-spacing: 0.05em;
            text-shadow: 0 0 3px rgba(255, 100, 255, 0.4);
          `}
        >
          {currentHex.name}
        </div>

        {/* Ownership Status or Buy Button */}
        {currentHex.id >= 0 && (
          <div
            css={css`
              margin-top: 0.3rem;
              padding-top: 0.3rem;
              border-top: 1px solid rgba(255, 100, 255, 0.2);
              display: flex;
              flex-direction: column;
              align-items: center;
              gap: 0.15rem;
              width: 100%;
            `}
          >
            {currentHex.owner ? (
              // Show ownership info
              <>
                <div
                  css={css`
                    color: rgba(255, 100, 100, 0.8);
                    font-size: 0.65rem;
                    font-weight: 600;
                    text-transform: uppercase;
                    letter-spacing: 0.05em;
                  `}
                >
                  🔒 Private Property
                </div>
                <div
                  css={css`
                    color: rgba(255, 200, 100, 0.9);
                    font-size: 0.65rem;
                    font-weight: 500;
                  `}
                >
                  Owner: {currentHex.owner.displayName}
                </div>
              </>
            ) : currentHex.id === 0 ? (
              // Hex 0 is public spawn area
              <div
                css={css`
                  color: rgba(100, 255, 100, 0.8);
                  font-size: 0.65rem;
                  font-weight: 600;
                  text-transform: uppercase;
                  letter-spacing: 0.05em;
                `}
              >
                🌟 Public Spawn Area
              </div>
            ) : (
              // Show Buy button
              <button
                onClick={handlePurchase}
                disabled={purchasing}
                css={css`
                  pointer-events: auto !important;
                  background: linear-gradient(135deg, #ff00ff 0%, #00ffff 100%);
                  border: 2px solid rgba(255, 255, 255, 0.3);
                  border-radius: 0.4rem;
                  padding: 0.5rem 1rem;
                  color: white;
                  font-weight: 700;
                  font-size: 0.75rem;
                  text-transform: uppercase;
                  letter-spacing: 0.05em;
                  cursor: pointer;
                  transition: all 0.2s;
                  box-shadow:
                    0 0 20px rgba(255, 0, 255, 0.3),
                    0 0 40px rgba(0, 255, 255, 0.2);
                  z-index: 9999;
                  position: relative;

                  &:hover:not(:disabled) {
                    transform: scale(1.05);
                    box-shadow:
                      0 0 30px rgba(255, 0, 255, 0.5),
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
                {purchasing ? '⏳ Purchasing...' : '🏆 Buy Now (First Come!)'}
              </button>
            )}
          </div>
        )}

        {/* Purchase Error/Success Message */}
        {purchaseError && (
          <div
            css={css`
              margin-top: 0.3rem;
              padding: 0.4rem;
              background: ${purchaseError.includes('Success')
                ? 'rgba(100, 255, 100, 0.1)'
                : 'rgba(255, 100, 100, 0.1)'};
              border: 1px solid ${purchaseError.includes('Success')
                ? 'rgba(100, 255, 100, 0.3)'
                : 'rgba(255, 100, 100, 0.3)'};
              border-radius: 0.3rem;
              color: ${purchaseError.includes('Success')
                ? 'rgba(100, 255, 100, 0.9)'
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