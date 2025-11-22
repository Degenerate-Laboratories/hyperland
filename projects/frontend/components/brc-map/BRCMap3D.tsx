'use client';

import { useRef, useEffect, useState, useCallback } from 'react';
import { BRCParcel, ParcelStatus } from '@/lib/brc-constants';

interface BRCMap3DProps {
  parcels: BRCParcel[];
  onParcelClick: (parcel: BRCParcel) => void;
  selectedParcel: BRCParcel | null;
}

export default function BRCMap3D({ parcels, onParcelClick, selectedParcel }: BRCMap3DProps) {
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const containerRef = useRef<HTMLDivElement>(null);
  const [hoveredParcel, setHoveredParcel] = useState<BRCParcel | null>(null);
  const [transform, setTransform] = useState({
    scale: 0.02,  // Start zoomed out to show entire world
    offsetX: 0,
    offsetY: 0,
    rotateX: 55, // Tilt angle in degrees (for visual perspective effect)
    rotateZ: 0    // View rotation around the map (in degrees)
  });
  const [isDragging, setIsDragging] = useState(false);
  const [dragStart, setDragStart] = useState({ x: 0, y: 0 });
  const [dragMode, setDragMode] = useState<'pan' | 'rotate'>('pan');
  const [isAutoRotating, setIsAutoRotating] = useState(true);
  const [lastMouseActivity, setLastMouseActivity] = useState(Date.now());
  const mouseActivityTimeoutRef = useRef<NodeJS.Timeout | null>(null);
  const [currentRotationSpeed, setCurrentRotationSpeed] = useState(0.2); // Current rotation speed
  const targetRotationSpeedRef = useRef(0.2); // Target rotation speed

  // Draw the 3D map
  const drawMap = useCallback(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;

    const ctx = canvas.getContext('2d');
    if (!ctx) return;

    const { scale, offsetX, offsetY, rotateZ } = transform;

    // Clear canvas (transparent background)
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    // Save context
    ctx.save();

    // Center the canvas
    ctx.translate(canvas.width / 2, canvas.height / 2);

    // Apply view rotation (rotate the view around the map, not the map itself)
    const rotateZRad = (rotateZ * Math.PI) / 180;
    ctx.rotate(rotateZRad);

    // Apply pan offset (after rotation, so panning is in screen space)
    ctx.translate(offsetX, offsetY);

    // Apply zoom
    ctx.scale(scale, scale);

    // Draw grid pattern
    drawGrid(ctx);

    // Draw ring boundaries
    drawRings(ctx);

    // Draw radial streets
    drawRadialStreets(ctx);

    // Sort parcels by distance for proper 3D layering
    const sortedParcels = [...parcels].sort((a, b) => {
      return b.centroid.y - a.centroid.y; // Draw back to front
    });

    // Draw all parcels with 3D effect
    sortedParcels.forEach(parcel => {
      drawParcel3D(ctx, parcel, parcel === selectedParcel, parcel === hoveredParcel);
    });

    // Draw ring labels
    drawRingLabels(ctx);

    // Draw The Man (center point)
    drawMan(ctx);

    // Restore context
    ctx.restore();
  }, [parcels, selectedParcel, hoveredParcel, transform]);

  // Draw background grid (minimal Otherside.xyz style)
  const drawGrid = (ctx: CanvasRenderingContext2D) => {
    // Only show grid when zoomed in enough
    if (transform.scale < 0.1) return;

    // Subtle grid lines
    ctx.strokeStyle = 'rgba(255, 255, 255, 0.03)';
    ctx.lineWidth = 1;

    const majorGrid = 2000;
    for (let i = -15000; i <= 15000; i += majorGrid) {
      ctx.beginPath();
      ctx.moveTo(i, -15000);
      ctx.lineTo(i, 15000);
      ctx.stroke();

      ctx.beginPath();
      ctx.moveTo(-15000, i);
      ctx.lineTo(15000, i);
      ctx.stroke();
    }
  };

  // Draw The Man marker
  const drawMan = (ctx: CanvasRenderingContext2D) => {
    // Draw shadow
    ctx.fillStyle = 'rgba(0, 0, 0, 0.5)';
    ctx.beginPath();
    ctx.ellipse(0, 120, 140, 40, 0, 0, Math.PI * 2);
    ctx.fill();

    // Draw marker
    ctx.fillStyle = '#ffffff';
    ctx.beginPath();
    ctx.arc(0, 0, 100, 0, Math.PI * 2);
    ctx.fill();

    // Pulsing outer ring
    ctx.strokeStyle = 'rgba(255, 255, 255, 0.6)';
    ctx.lineWidth = 3;
    ctx.beginPath();
    ctx.arc(0, 0, 150, 0, Math.PI * 2);
    ctx.stroke();
  };

  // Draw ring boundaries (major section boundaries)
  const drawRings = (ctx: CanvasRenderingContext2D) => {
    // Show ring boundaries more prominently to define the 5 sections
    const rings = [
      { radius: 2500, name: 'Esplanade', color: 'rgba(6, 182, 212, 0.6)' },      // Cyan
      { radius: 3450, name: 'Afanc', color: 'rgba(59, 130, 246, 0.6)' },         // Blue
      { radius: 5200, name: 'MidCity', color: 'rgba(168, 85, 247, 0.6)' },       // Purple
      { radius: 7675, name: 'Igopogo', color: 'rgba(249, 115, 22, 0.6)' },       // Orange
      { radius: 11690, name: 'Kraken', color: 'rgba(236, 72, 153, 0.6)' }        // Pink
    ];

    rings.forEach((ring, index) => {
      // Draw prominent ring lines to separate the 5 major sections
      // Rotated -90° so opening is at north: 60° -> 330°, 300° -> 210°
      ctx.strokeStyle = ring.color;
      ctx.lineWidth = transform.scale < 0.1 ? 2 : 3;
      ctx.beginPath();
      const startAngle = (330 * Math.PI) / 180; // 2:00 position rotated to north
      const endAngle = (210 * Math.PI) / 180;   // 10:00 position rotated to north
      ctx.arc(0, 0, ring.radius, startAngle, endAngle);
      ctx.stroke();
    });
  };

  // Draw radial streets (subtle, only when zoomed in)
  const drawRadialStreets = (ctx: CanvasRenderingContext2D) => {
    // Only show streets when zoomed in
    if (transform.scale < 0.05) return;

    // Major streets every 30 degrees (hour marks), rotated -90° so opening is at north
    for (let clockAngle = 60; clockAngle <= 300; clockAngle += 30) {
      const angle = clockAngle - 90; // Rotate -90° to move opening to north
      const rad = (angle * Math.PI) / 180;
      const x1 = 2500 * Math.cos(rad);
      const y1 = 2500 * Math.sin(rad);
      const x2 = 11690 * Math.cos(rad);
      const y2 = 11690 * Math.sin(rad);

      ctx.strokeStyle = 'rgba(255, 255, 255, 0.1)';
      ctx.lineWidth = 1;
      ctx.beginPath();
      ctx.moveTo(x1, y1);
      ctx.lineTo(x2, y2);
      ctx.stroke();

      // Draw time labels only when very zoomed in
      if (transform.scale > 0.3) {
        const hours = Math.floor(clockAngle / 30);
        const labelRadius = 12400;
        const labelX = labelRadius * Math.cos(rad);
        const labelY = labelRadius * Math.sin(rad);

        ctx.save();
        ctx.translate(labelX, labelY);
        ctx.rotate(rad + Math.PI / 2);
        ctx.fillStyle = 'rgba(255, 255, 255, 0.5)';
        ctx.strokeStyle = 'rgba(0, 0, 0, 0.5)';
        ctx.lineWidth = 8;
        ctx.font = 'bold 250px Inter, sans-serif';
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        ctx.strokeText(`${hours}:00`, 0, 0);
        ctx.fillText(`${hours}:00`, 0, 0);
        ctx.restore();
      }
    }
  };

  // Draw ring labels
  const drawRingLabels = (ctx: CanvasRenderingContext2D) => {
    if (transform.scale < 0.25) return;

    const rings = [
      { radius: 2500, name: 'ESPLANADE' },
      { radius: 3450, name: 'AFANC' },
      { radius: 5200, name: 'MIDCITY' },
      { radius: 7675, name: 'IGOPOGO' },
      { radius: 11690, name: 'KRAKEN' }
    ];

    rings.forEach(ring => {
      // Place label at 6:00 position (180°)
      const angle = (180 * Math.PI) / 180;
      const labelX = ring.radius * Math.cos(angle);
      const labelY = ring.radius * Math.sin(angle);

      ctx.save();
      ctx.translate(labelX, labelY);
      ctx.fillStyle = 'rgba(255, 255, 255, 0.9)';
      ctx.strokeStyle = 'rgba(0, 0, 0, 0.8)';
      ctx.lineWidth = 10;
      ctx.font = 'bold 350px Inter, sans-serif';
      ctx.textAlign = 'center';
      ctx.textBaseline = 'middle';
      ctx.strokeText(ring.name, 0, 0);
      ctx.fillText(ring.name, 0, 0);
      ctx.restore();
    });
  };

  // Get color scheme for each major band/section
  const getBandColor = (band: string): { fill: string; stroke: string } => {
    switch (band) {
      case 'Esplanade':
        return {
          fill: 'rgba(6, 182, 212, 0.85)',      // Cyan
          stroke: 'rgba(6, 182, 212, 1)'
        };
      case 'Afanc':
        return {
          fill: 'rgba(59, 130, 246, 0.85)',     // Blue
          stroke: 'rgba(59, 130, 246, 1)'
        };
      case 'MidCity':
        return {
          fill: 'rgba(168, 85, 247, 0.85)',     // Purple
          stroke: 'rgba(168, 85, 247, 1)'
        };
      case 'Igopogo':
        return {
          fill: 'rgba(249, 115, 22, 0.85)',     // Orange
          stroke: 'rgba(249, 115, 22, 1)'
        };
      case 'Kraken':
        return {
          fill: 'rgba(236, 72, 153, 0.85)',     // Pink/Magenta
          stroke: 'rgba(236, 72, 153, 1)'
        };
      default:
        return {
          fill: 'rgba(255, 255, 255, 0.6)',
          stroke: 'rgba(255, 255, 255, 0.8)'
        };
    }
  };

  // Draw individual parcel as a 3D block (Burning Man style with depth)
  const drawParcel3D = (
    ctx: CanvasRenderingContext2D,
    parcel: BRCParcel,
    isSelected: boolean,
    isHovered: boolean
  ) => {
    // Get base color for this band
    const bandColors = getBandColor(parcel.band);
    let fillColor = bandColors.fill;
    let strokeColor = bandColors.stroke;

    // Modify colors based on status
    if (parcel.status === ParcelStatus.CLAIMED) {
      // Slightly brighter for claimed parcels
      fillColor = fillColor.replace(/0\.85\)/, '0.95)');
    } else if (parcel.status === ParcelStatus.FORECLOSURE) {
      // Red overlay for foreclosure
      fillColor = 'rgba(239, 68, 68, 0.85)';
      strokeColor = 'rgba(239, 68, 68, 1)';
    }

    const height = isSelected ? 200 : isHovered ? 120 : 80; // 3D extrusion height

    if (parcel.polygon && parcel.polygon.length > 0) {
      // Draw shadow on ground
      ctx.save();
      ctx.fillStyle = 'rgba(0, 0, 0, 0.3)';
      ctx.beginPath();
      ctx.moveTo(parcel.polygon[0][0] + height * 0.15, parcel.polygon[0][1] + height * 0.4);
      for (let i = 1; i < parcel.polygon.length; i++) {
        ctx.lineTo(parcel.polygon[i][0] + height * 0.15, parcel.polygon[i][1] + height * 0.4);
      }
      ctx.closePath();
      ctx.fill();
      ctx.restore();

      // Draw 3D side face (offset polygon for depth)
      const sideColor = fillColor.replace(/[\d.]+\)$/, (match) => {
        const opacity = parseFloat(match);
        return `${opacity * 0.5})`;
      });

      ctx.fillStyle = sideColor;
      ctx.strokeStyle = strokeColor.replace(')', ', 0.5)').replace('rgb', 'rgba');
      ctx.lineWidth = 1;

      // Draw extruded sides (simple offset to create depth illusion)
      for (let i = 0; i < parcel.polygon.length; i++) {
        const p1 = parcel.polygon[i];
        const p2 = parcel.polygon[(i + 1) % parcel.polygon.length];

        ctx.beginPath();
        ctx.moveTo(p1[0], p1[1]);
        ctx.lineTo(p2[0], p2[1]);
        ctx.lineTo(p2[0] + height * 0.1, p2[1] + height * 0.3);
        ctx.lineTo(p1[0] + height * 0.1, p1[1] + height * 0.3);
        ctx.closePath();
        ctx.fill();
        ctx.stroke();
      }

      // Draw bottom face (offset polygon)
      ctx.beginPath();
      ctx.moveTo(parcel.polygon[0][0] + height * 0.1, parcel.polygon[0][1] + height * 0.3);
      for (let i = 1; i < parcel.polygon.length; i++) {
        ctx.lineTo(parcel.polygon[i][0] + height * 0.1, parcel.polygon[i][1] + height * 0.3);
      }
      ctx.closePath();
      ctx.fillStyle = sideColor;
      ctx.fill();

      // Draw top face (main polygon) with glow for selected/hovered
      ctx.beginPath();
      ctx.moveTo(parcel.polygon[0][0], parcel.polygon[0][1]);
      for (let i = 1; i < parcel.polygon.length; i++) {
        ctx.lineTo(parcel.polygon[i][0], parcel.polygon[i][1]);
      }
      ctx.closePath();

      if (isSelected || isHovered) {
        ctx.save();
        ctx.shadowColor = isSelected ? '#22d3ee' : '#a78bfa';
        ctx.shadowBlur = isSelected ? 120 : 80;
        ctx.fillStyle = isSelected ? 'rgba(34, 211, 238, 0.3)' : 'rgba(167, 139, 250, 0.3)';
        ctx.fill();
        ctx.restore();
      }

      // Fill top face
      ctx.fillStyle = isSelected ? 'rgba(34, 211, 238, 0.95)' : isHovered ? 'rgba(167, 139, 250, 0.95)' : fillColor;
      ctx.fill();

      // Draw border on top
      ctx.strokeStyle = isSelected ? '#22d3ee' : isHovered ? '#a78bfa' : strokeColor;
      ctx.lineWidth = isSelected ? 4 : isHovered ? 3 : 1.5;
      ctx.stroke();
    }
  };

  // Handle mouse move
  const handleMouseMove = (e: React.MouseEvent<HTMLCanvasElement>) => {
    const canvas = canvasRef.current;
    if (!canvas) return;

    // Gradually slow down rotation on mouse activity
    targetRotationSpeedRef.current = 0; // Target is to stop
    setLastMouseActivity(Date.now());

    // Clear existing timeout and set new one
    if (mouseActivityTimeoutRef.current) {
      clearTimeout(mouseActivityTimeoutRef.current);
    }
    mouseActivityTimeoutRef.current = setTimeout(() => {
      // Resume rotation gradually
      targetRotationSpeedRef.current = 0.2;
    }, 3000); // Resume rotation after 3 seconds of inactivity

    if (isDragging) {
      const dx = e.clientX - dragStart.x;
      const dy = e.clientY - dragStart.y;

      if (dragMode === 'rotate') {
        setTransform(prev => ({
          ...prev,
          rotateX: Math.max(0, Math.min(85, prev.rotateX - dy * 0.2)),
          rotateZ: prev.rotateZ + dx * 0.2
        }));
      } else {
        // Constrain panning to keep map visible
        const newOffsetX = transform.offsetX + dx;
        const newOffsetY = transform.offsetY + dy;

        // Calculate max offset based on current scale and map size
        const mapRadius = 12000;
        const maxOffset = mapRadius * transform.scale * 0.7; // Allow some panning but not too much

        setTransform(prev => ({
          ...prev,
          offsetX: Math.max(-maxOffset, Math.min(maxOffset, newOffsetX)),
          offsetY: Math.max(-maxOffset, Math.min(maxOffset, newOffsetY))
        }));
      }
      setDragStart({ x: e.clientX, y: e.clientY });
      return;
    }

    const rect = canvas.getBoundingClientRect();
    const x = e.clientX - rect.left;
    const y = e.clientY - rect.top;

    // Convert screen coordinates to map coordinates (accounting for rotation)
    const { scale, offsetX, offsetY, rotateZ } = transform;
    const rotateZRad = (rotateZ * Math.PI) / 180;

    // Translate to canvas center
    const centerX = x - canvas.width / 2;
    const centerY = y - canvas.height / 2;

    // Apply inverse rotation
    const cosZ = Math.cos(-rotateZRad);
    const sinZ = Math.sin(-rotateZRad);
    const rotatedX = centerX * cosZ - centerY * sinZ;
    const rotatedY = centerX * sinZ + centerY * cosZ;

    // Apply inverse offset and scale
    const mapX = (rotatedX - offsetX) / scale;
    const mapY = (rotatedY - offsetY) / scale;

    // Find parcel at this position
    const parcel = findParcelAtPoint(mapX, mapY);
    setHoveredParcel(parcel);
    canvas.style.cursor = parcel ? 'pointer' : dragMode === 'rotate' ? 'grab' : 'move';
  };

  const handleClick = (e: React.MouseEvent<HTMLCanvasElement>) => {
    if (hoveredParcel) {
      onParcelClick(hoveredParcel);
    }
  };

  const handleMouseDown = (e: React.MouseEvent<HTMLCanvasElement>) => {
    setIsDragging(true);
    setDragStart({ x: e.clientX, y: e.clientY });
    setDragMode(e.shiftKey ? 'rotate' : 'pan');
  };

  const handleMouseUp = () => {
    setIsDragging(false);
  };

  // Handle wheel for zoom with edge constraints
  const handleWheel = (e: React.WheelEvent<HTMLCanvasElement>) => {
    e.preventDefault();
    const canvas = canvasRef.current;
    if (!canvas) return;

    const zoomFactor = e.deltaY < 0 ? 1.15 : 0.85;

    setTransform(prev => {
      const newScale = prev.scale * zoomFactor;

      // Calculate minimum scale to fit entire map (radius ~12000 feet)
      const mapRadius = 12000;
      const canvasSize = Math.min(canvas.width, canvas.height);
      const minScale = canvasSize / (mapRadius * 2.5); // 2.5 gives some padding

      // Constrain scale
      const constrainedScale = Math.max(minScale, Math.min(2, newScale));

      return {
        ...prev,
        scale: constrainedScale
      };
    });
  };

  // Find parcel at point using polygon containment
  const findParcelAtPoint = (x: number, y: number): BRCParcel | null => {
    // Test each parcel to see if point is inside its polygon
    for (const parcel of parcels) {
      if (isPointInPolygon(x, y, parcel.polygon)) {
        return parcel;
      }
    }
    return null;
  };

  // Point-in-polygon test using ray casting algorithm
  const isPointInPolygon = (x: number, y: number, polygon: [number, number][]): boolean => {
    let inside = false;
    for (let i = 0, j = polygon.length - 1; i < polygon.length; j = i++) {
      const xi = polygon[i][0], yi = polygon[i][1];
      const xj = polygon[j][0], yj = polygon[j][1];

      const intersect = ((yi > y) !== (yj > y))
        && (x < (xj - xi) * (y - yi) / (yj - yi) + xi);
      if (intersect) inside = !inside;
    }
    return inside;
  };

  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;

    const resizeCanvas = () => {
      // Set canvas to full viewport size to ensure map never gets cut off
      // Account for header height
      const headerHeight = 250;
      canvas.width = window.innerWidth;
      canvas.height = window.innerHeight - headerHeight;
      drawMap();
    };

    resizeCanvas();
    window.addEventListener('resize', resizeCanvas);

    return () => window.removeEventListener('resize', resizeCanvas);
  }, [drawMap]);

  useEffect(() => {
    drawMap();
  }, [drawMap]);

  // Smooth auto-rotation with gradual acceleration/deceleration
  useEffect(() => {
    let animationFrameId: number;
    const acceleration = 0.008; // How fast speed changes

    const rotate = () => {
      setCurrentRotationSpeed(prevSpeed => {
        const targetSpeed = targetRotationSpeedRef.current;
        const speedDiff = targetSpeed - prevSpeed;

        // Gradually adjust speed toward target
        if (Math.abs(speedDiff) < acceleration) {
          return targetSpeed;
        }
        return prevSpeed + Math.sign(speedDiff) * acceleration;
      });

      setTransform(prev => ({
        ...prev,
        rotateZ: (prev.rotateZ + currentRotationSpeed) % 360
      }));

      animationFrameId = requestAnimationFrame(rotate);
    };

    animationFrameId = requestAnimationFrame(rotate);

    return () => {
      if (animationFrameId) {
        cancelAnimationFrame(animationFrameId);
      }
    };
  }, [currentRotationSpeed]);

  // Cleanup timeout on unmount
  useEffect(() => {
    return () => {
      if (mouseActivityTimeoutRef.current) {
        clearTimeout(mouseActivityTimeoutRef.current);
      }
    };
  }, []);

  return (
    <div className="relative perspective-container overflow-hidden w-full h-screen" ref={containerRef}>
      {/* Stationary 3D wrapper with only X-axis tilt for perspective */}
      <div
        className="canvas-3d-wrapper absolute inset-0"
        style={{
          transform: `rotateX(${transform.rotateX}deg)`,
          transformStyle: 'preserve-3d',
          transformOrigin: 'center center',
        }}
      >
        <canvas
          ref={canvasRef}
          onMouseMove={handleMouseMove}
          onClick={handleClick}
          onMouseDown={handleMouseDown}
          onMouseUp={handleMouseUp}
          onMouseLeave={handleMouseUp}
          onWheel={handleWheel}
          className="bg-transparent w-full h-full"
          style={{
            background: 'transparent',
          }}
        />
      </div>

      {/* Tooltip */}
      {hoveredParcel && (
        <div className="absolute bottom-4 left-1/2 transform -translate-x-1/2 glass rounded-lg px-4 py-2 pointer-events-none z-50">
          <div className="font-mono text-sm text-cyan-400">{hoveredParcel.id}</div>
          <div className="text-white/80 text-xs">{hoveredParcel.address}</div>
          <div className="text-white/60 text-xs">${hoveredParcel.price.toLocaleString()}</div>
        </div>
      )}

      <style jsx>{`
        .perspective-container {
          perspective: 2000px;
          perspective-origin: 50% 50%;
        }
        .canvas-3d-wrapper {
          transition: transform 0.1s ease-out;
          transform-style: preserve-3d;
        }
      `}</style>
    </div>
  );
}
