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
  const logoImageRef = useRef<HTMLImageElement | null>(null);
  const [hoveredParcel, setHoveredParcel] = useState<BRCParcel | null>(null);
  const [transform, setTransform] = useState({ scale: 0.1, offsetX: 0, offsetY: 0 });
  const [isDragging, setIsDragging] = useState(false);
  const [dragStart, setDragStart] = useState({ x: 0, y: 0 });
  const [initialized, setInitialized] = useState(false);
  const [logoLoaded, setLogoLoaded] = useState(false);

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

    // Draw logo at center
    if (logoLoaded && logoImageRef.current) {
      drawLogo(ctx);
    }

    // Restore context
    ctx.restore();
  }, [parcels, selectedParcel, hoveredParcel, transform, logoLoaded]);

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

  // Draw The Man marker with pulsating radiation animation
  const drawMan = (ctx: CanvasRenderingContext2D) => {
    const time = Date.now() / 1000;

    // Draw multiple expanding radiation rings (slower and bigger)
    for (let i = 0; i < 3; i++) {
      const delay = i * 1.5; // Stagger each ring
      const cycle = (time + delay) % 5; // 5 second cycle for each ring (slower)
      const progress = cycle / 5; // 0 to 1

      // Expand from 300 to 1000 radius (much bigger)
      const radius = 300 + (progress * 700);

      // Fade out as it expands
      const opacity = (1 - progress) * 0.6;

      if (opacity > 0.05) {
        ctx.strokeStyle = `rgba(255, 255, 255, ${opacity})`;
        ctx.lineWidth = 6 * (1 - progress * 0.5); // Thicker lines
        ctx.beginPath();
        ctx.arc(0, 0, radius, 0, Math.PI * 2);
        ctx.stroke();
      }
    }

    // Center dot with subtle pulse (bigger)
    const pulseScale = 1 + Math.sin(time * 1.5) * 0.15; // Slower, bigger pulse
    const pulseRadius = 200 * pulseScale;

    // Glow effect
    ctx.save();
    ctx.shadowColor = '#ffffff';
    ctx.shadowBlur = 60;
    ctx.fillStyle = '#ffffff';
    ctx.beginPath();
    ctx.arc(0, 0, pulseRadius, 0, Math.PI * 2);
    ctx.fill();
    ctx.restore();

    // Bright center
    ctx.fillStyle = '#ffffff';
    ctx.beginPath();
    ctx.arc(0, 0, pulseRadius * 0.5, 0, Math.PI * 2);
    ctx.fill();
  };

  // Draw logo above the map with smooth animation
  const drawLogo = (ctx: CanvasRenderingContext2D) => {
    if (!logoImageRef.current) return;

    // Smooth animation based on time (9 second cycle)
    const time = Date.now() / 1000; // Convert to seconds
    const cycle = time % 9; // 9 second cycle

    // Smooth opacity pulse (0.25 to 0.45)
    let opacity = 0.35 + Math.sin(cycle * Math.PI / 4.5) * 0.1;

    // Very subtle scale pulse (0.98 to 1.02)
    const scale = 1 + Math.sin(cycle * Math.PI / 3) * 0.02;

    // Slow glitch effect (happens over 0.5 seconds every 9 seconds)
    let glitchOffset = { x: 0, y: 0 };
    if (cycle > 8.5 && cycle < 9) {
      const glitchProgress = (cycle - 8.5) / 0.5; // 0 to 1 over 0.5 seconds
      const glitchIntensity = Math.sin(glitchProgress * Math.PI); // Smooth in and out

      // Brightness increase during glitch
      opacity = opacity + glitchIntensity * 0.3;

      // Position offset
      glitchOffset = {
        x: Math.sin(glitchProgress * Math.PI * 4) * 40 * glitchIntensity,
        y: Math.cos(glitchProgress * Math.PI * 3) * 40 * glitchIntensity
      };
    }

    const logoSize = 5000; // Even bigger size in map units (feet)
    const yPosition = -6800; // Position above center

    ctx.save();
    ctx.globalAlpha = Math.min(opacity, 1); // Cap at 1
    ctx.translate(glitchOffset.x, yPosition + glitchOffset.y);
    ctx.scale(scale, scale);
    ctx.drawImage(
      logoImageRef.current,
      -logoSize / 2,
      -logoSize / 2,
      logoSize,
      logoSize
    );
    ctx.restore();
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

  // Get gradient color for parcel based on band and sector
  const getBandColor = (band: string, parcelId: string): { fill: string; stroke: string } => {
    // Use parcel ID to create consistent color variation (hash-based)
    const hash = parcelId.split('').reduce((acc, char) => acc + char.charCodeAt(0), 0);
    const variation = (hash % 100) / 100; // 0 to 1 range

    switch (band) {
      case 'Esplanade':
        // Cyan gradient: light to dark
        const cyanShade = Math.floor(120 + variation * 140); // 120-260 range
        return {
          fill: `rgba(${Math.floor(cyanShade * 0.03)}, ${cyanShade}, ${Math.floor(cyanShade * 0.95)}, 0.75)`,
          stroke: `rgba(${Math.floor(cyanShade * 0.03)}, ${cyanShade}, ${Math.floor(cyanShade * 0.95)}, 1)`
        };
      case 'Afanc':
        // Blue gradient: light to dark
        const blueShade = Math.floor(100 + variation * 170); // 100-270 range
        return {
          fill: `rgba(${Math.floor(blueShade * 0.3)}, ${Math.floor(blueShade * 0.6)}, ${blueShade}, 0.75)`,
          stroke: `rgba(${Math.floor(blueShade * 0.3)}, ${Math.floor(blueShade * 0.6)}, ${blueShade}, 1)`
        };
      case 'MidCity':
        // Purple gradient: light to dark
        const purpleR = Math.floor(130 + variation * 90); // 130-220
        const purpleB = Math.floor(200 + variation * 55); // 200-255
        return {
          fill: `rgba(${purpleR}, ${Math.floor(purpleR * 0.4)}, ${purpleB}, 0.75)`,
          stroke: `rgba(${purpleR}, ${Math.floor(purpleR * 0.4)}, ${purpleB}, 1)`
        };
      case 'Igopogo':
        // Orange gradient: light to dark
        const orangeR = Math.floor(220 + variation * 35); // 220-255
        const orangeG = Math.floor(80 + variation * 70); // 80-150
        return {
          fill: `rgba(${orangeR}, ${orangeG}, ${Math.floor(orangeG * 0.2)}, 0.75)`,
          stroke: `rgba(${orangeR}, ${orangeG}, ${Math.floor(orangeG * 0.2)}, 1)`
        };
      case 'Kraken':
        // Pink/Magenta gradient: light to dark
        const pinkR = Math.floor(200 + variation * 55); // 200-255
        const pinkG = Math.floor(50 + variation * 80); // 50-130
        const pinkB = Math.floor(130 + variation * 80); // 130-210
        return {
          fill: `rgba(${pinkR}, ${pinkG}, ${pinkB}, 0.75)`,
          stroke: `rgba(${pinkR}, ${pinkG}, ${pinkB}, 1)`
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
    // Get gradient color for this band and parcel
    const bandColors = getBandColor(parcel.band, parcel.id);
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

  // Load logo image
  useEffect(() => {
    const img = new Image();
    img.src = '/HyperLogo.png';
    img.onload = () => {
      logoImageRef.current = img;
      setLogoLoaded(true);
    };
  }, []);

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

  // Continuous animation loop (only start after initialization)
  useEffect(() => {
    if (!initialized) return; // Wait for proper initial scale to be set

    let animationFrameId: number;

    const animate = () => {
      drawMap();
      animationFrameId = requestAnimationFrame(animate);
    };

    animate();

    return () => {
      if (animationFrameId) {
        cancelAnimationFrame(animationFrameId);
      }
    };
  }, [drawMap, initialized]);

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
