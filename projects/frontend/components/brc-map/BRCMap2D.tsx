'use client';

import { useRef, useEffect, useState, useCallback } from 'react';
import { BRCParcel, ParcelStatus } from '@/lib/brc-constants';

interface BRCMap2DProps {
  parcels: BRCParcel[];
  onParcelClick: (parcel: BRCParcel) => void;
  selectedParcel: BRCParcel | null;
}

export default function BRCMap2D({ parcels, onParcelClick, selectedParcel }: BRCMap2DProps) {
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const [hoveredParcel, setHoveredParcel] = useState<BRCParcel | null>(null);
  const [transform, setTransform] = useState({ scale: 0.1, offsetX: 0, offsetY: 0 });
  const [isDragging, setIsDragging] = useState(false);
  const [dragStart, setDragStart] = useState({ x: 0, y: 0 });
  const [initialized, setInitialized] = useState(false);

  // Draw the map
  const drawMap = useCallback(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;

    const ctx = canvas.getContext('2d');
    if (!ctx) return;

    const { scale, offsetX, offsetY } = transform;

    // Clear canvas (transparent background)
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    // Save context
    ctx.save();

    // Apply transformations
    ctx.translate(canvas.width / 2 + offsetX, canvas.height / 2 + offsetY);
    ctx.scale(scale, scale);

    // Draw grid pattern
    drawGrid(ctx);

    // Draw ring boundaries
    drawRings(ctx);

    // Draw radial streets
    drawRadialStreets(ctx);

    // Draw all parcels
    parcels.forEach(parcel => {
      drawParcel(ctx, parcel, parcel === selectedParcel, parcel === hoveredParcel);
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
    ctx.fillStyle = '#ec4899';
    ctx.beginPath();
    ctx.arc(0, 0, 100, 0, Math.PI * 2);
    ctx.fill();

    // Pulsing outer ring
    ctx.strokeStyle = 'rgba(236, 72, 153, 0.5)';
    ctx.lineWidth = 2;
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
        const labelRadius = 12200;
        const labelX = labelRadius * Math.cos(rad);
        const labelY = labelRadius * Math.sin(rad);

        ctx.save();
        ctx.translate(labelX, labelY);
        ctx.rotate(rad + Math.PI / 2);
        ctx.fillStyle = 'rgba(255, 255, 255, 0.5)';
        ctx.font = 'bold 200px Inter, sans-serif';
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        ctx.fillText(`${hours}:00`, 0, 0);
        ctx.restore();
      }
    }
  };

  // Draw ring labels
  const drawRingLabels = (ctx: CanvasRenderingContext2D) => {
    if (transform.scale < 0.3) return;

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
      ctx.fillStyle = 'rgba(255, 255, 255, 0.8)';
      ctx.strokeStyle = 'rgba(0, 0, 0, 0.8)';
      ctx.lineWidth = 8;
      ctx.font = 'bold 300px Inter, sans-serif';
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
          fill: 'rgba(6, 182, 212, 0.75)',      // Cyan
          stroke: 'rgba(6, 182, 212, 1)'
        };
      case 'Afanc':
        return {
          fill: 'rgba(59, 130, 246, 0.75)',     // Blue
          stroke: 'rgba(59, 130, 246, 1)'
        };
      case 'MidCity':
        return {
          fill: 'rgba(168, 85, 247, 0.75)',     // Purple
          stroke: 'rgba(168, 85, 247, 1)'
        };
      case 'Igopogo':
        return {
          fill: 'rgba(249, 115, 22, 0.75)',     // Orange
          stroke: 'rgba(249, 115, 22, 1)'
        };
      case 'Kraken':
        return {
          fill: 'rgba(236, 72, 153, 0.75)',     // Pink/Magenta
          stroke: 'rgba(236, 72, 153, 1)'
        };
      default:
        return {
          fill: 'rgba(255, 255, 255, 0.5)',
          stroke: 'rgba(255, 255, 255, 0.8)'
        };
    }
  };

  // Draw individual parcel as a block polygon (Burning Man style)
  const drawParcel = (
    ctx: CanvasRenderingContext2D,
    parcel: BRCParcel,
    isSelected: boolean,
    isHovered: boolean
  ) => {
    // Get base color for this band
    const bandColors = getBandColor(parcel.band);
    let fillColor = bandColors.fill;
    let strokeColor = bandColors.stroke;

    // Modify colors based on status (darken/lighten)
    if (parcel.status === ParcelStatus.CLAIMED) {
      // Slightly darker for claimed parcels
      fillColor = fillColor.replace(/0\.75\)/, '0.85)');
    } else if (parcel.status === ParcelStatus.FORECLOSURE) {
      // Desaturate and darken for foreclosure
      fillColor = 'rgba(239, 68, 68, 0.75)'; // Red overlay
      strokeColor = 'rgba(239, 68, 68, 1)';
    }

    // Draw the polygon shape
    if (parcel.polygon && parcel.polygon.length > 0) {
      ctx.beginPath();
      ctx.moveTo(parcel.polygon[0][0], parcel.polygon[0][1]);
      for (let i = 1; i < parcel.polygon.length; i++) {
        ctx.lineTo(parcel.polygon[i][0], parcel.polygon[i][1]);
      }
      ctx.closePath();

      // Draw glow for selected/hovered
      if (isSelected || isHovered) {
        ctx.save();
        ctx.shadowColor = isSelected ? '#22d3ee' : '#a78bfa';
        ctx.shadowBlur = isSelected ? 100 : 60;
        ctx.fillStyle = isSelected ? 'rgba(34, 211, 238, 0.3)' : 'rgba(167, 139, 250, 0.3)';
        ctx.fill();
        ctx.restore();
      }

      // Fill the parcel
      ctx.fillStyle = isSelected ? 'rgba(34, 211, 238, 0.9)' : isHovered ? 'rgba(167, 139, 250, 0.9)' : fillColor;
      ctx.fill();

      // Draw border
      ctx.strokeStyle = isSelected ? '#22d3ee' : isHovered ? '#a78bfa' : strokeColor;
      ctx.lineWidth = isSelected ? 3 : isHovered ? 2 : 1;
      ctx.stroke();
    }
  };

  // Handle mouse move for hover detection
  const handleMouseMove = (e: React.MouseEvent<HTMLCanvasElement>) => {
    const canvas = canvasRef.current;
    if (!canvas) return;

    if (isDragging) {
      const dx = e.clientX - dragStart.x;
      const dy = e.clientY - dragStart.y;

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
      setDragStart({ x: e.clientX, y: e.clientY });
      return;
    }

    const rect = canvas.getBoundingClientRect();

    // Account for CSS scaling of canvas
    const scaleX = canvas.width / rect.width;
    const scaleY = canvas.height / rect.height;

    // Get mouse position in canvas coordinates (accounting for CSS scaling)
    const canvasX = (e.clientX - rect.left) * scaleX;
    const canvasY = (e.clientY - rect.top) * scaleY;

    // Convert canvas coordinates to map coordinates
    const { scale, offsetX, offsetY } = transform;
    const mapX = (canvasX - canvas.width / 2 - offsetX) / scale;
    const mapY = (canvasY - canvas.height / 2 - offsetY) / scale;

    // Find parcel at this position
    const parcel = findParcelAtPoint(mapX, mapY);
    setHoveredParcel(parcel);
    canvas.style.cursor = parcel ? 'pointer' : 'grab';
  };

  // Handle click to select parcel
  const handleClick = (e: React.MouseEvent<HTMLCanvasElement>) => {
    if (hoveredParcel) {
      onParcelClick(hoveredParcel);
    }
  };

  // Handle mouse down for dragging
  const handleMouseDown = (e: React.MouseEvent<HTMLCanvasElement>) => {
    setIsDragging(true);
    setDragStart({ x: e.clientX, y: e.clientY });
  };

  // Handle mouse up
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

  // Find parcel at point using polygon containment (point-in-polygon test)
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

  // Reset to initial view when component mounts
  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;

    // Set canvas to full viewport size
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;

    // Calculate proper initial scale to fit the entire map without cutting edges
    const mapRadius = 12000;
    const canvasSize = Math.min(canvas.width, canvas.height);
    const initialScale = canvasSize / (mapRadius * 2.3); // Ensure entire map fits in view

    setTransform({
      scale: initialScale,
      offsetX: 0,
      offsetY: -canvas.height * 0.15 // Position higher, closer to navbar
    });
    setInitialized(true);
  }, []); // Run once on mount

  // Setup canvas and handle resize
  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;

    const resizeCanvas = () => {
      // Set canvas to full viewport size
      canvas.width = window.innerWidth;
      canvas.height = window.innerHeight;
      drawMap();
    };

    resizeCanvas();
    window.addEventListener('resize', resizeCanvas);

    return () => window.removeEventListener('resize', resizeCanvas);
  }, [drawMap]);

  // Redraw when dependencies change
  useEffect(() => {
    drawMap();
  }, [drawMap]);

  return (
    <div className="relative overflow-hidden w-full h-screen flex items-center justify-center">
      <canvas
        ref={canvasRef}
        onMouseMove={handleMouseMove}
        onClick={handleClick}
        onMouseDown={handleMouseDown}
        onMouseUp={handleMouseUp}
        onMouseLeave={handleMouseUp}
        onWheel={handleWheel}
        className="bg-transparent"
        style={{
          background: 'transparent',
          maxWidth: '100%',
          maxHeight: '100%'
        }}
      />

      {/* Tooltip for hovered parcel */}
      {hoveredParcel && (
        <div className="absolute bottom-4 left-1/2 transform -translate-x-1/2 glass rounded-lg px-4 py-2 pointer-events-none">
          <div className="font-mono text-sm text-cyan-400">{hoveredParcel.id}</div>
          <div className="text-white/80 text-xs">{hoveredParcel.address}</div>
          <div className="text-white/60 text-xs">${hoveredParcel.price.toLocaleString()}</div>
        </div>
      )}

    </div>
  );
}
