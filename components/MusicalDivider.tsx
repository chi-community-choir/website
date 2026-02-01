type Variant = 'icon' | 'stave'

interface MusicalDividerProps {
  /** Name of SVG file in public/icons/ or public/images/ (without .svg extension) */
  image?: string
  /** Display style - 'icon' has lines extending from centered icon, 'stave' uses wide SVG without lines */
  variant?: Variant
  className?: string
}

export function MusicalDivider({
  image = 'treble-clef',
  variant = 'icon',
  className = ''
}: MusicalDividerProps) {
  const isStave = variant === 'stave'

  return (
    <div className={`flex items-center justify-center my-8 h-24 overflow-hidden ${className}`} aria-hidden="true">
      {isStave ? (
        <div style={{ flexShrink: 0, width: '680px' }}>
          <img
            src={`/images/${image}.svg`}
            alt=""
            className="height-auto opacity-60"
            style={{
              width: '100%',
              scale: '200%',
              filter: 'sepia(0.3) hue-rotate(-10deg) saturate(1.5)',
              maskImage: 'linear-gradient(to right, transparent max(5%, 50% - 25vw), black 48%, black 52%, transparent min(95%, 50% + 25vw))',
              WebkitMaskImage: 'linear-gradient(to right, transparent max(5%, 50% - 25vw), black 48%, black 52%, transparent min(95%, 50% + 25vw))',
            }}
          />
        </div>
      ) : (
        <>
          {/* Left fading line */}
          <div className="h-[2px] flex-1 bg-gradient-to-r from-transparent via-choir-gold/40 to-choir-gold/70 max-w-[120px]" />

          {/* Musical icon */}
          <img
            src={`/icons/${image}.svg`}
            alt=""
            className="size-auto mx-4 opacity-60"
            style={{ scale: '200%', filter: 'sepia(0.3) hue-rotate(-10deg) saturate(1.5)' }}
          />

          {/* Right fading line */}
          <div className="h-[2px] flex-1 bg-gradient-to-l from-transparent via-choir-gold/40 to-choir-gold/70 max-w-[120px]" />
        </>
      )}
    </div>
  )
}
