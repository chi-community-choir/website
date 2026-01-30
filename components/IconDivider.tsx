interface IconDividerProps {
  /** Name of SVG file in public/icons/ (without .svg extension) */
  icon?: string
  className?: string
}

export function IconDivider({ icon = 'treble-clef', className = '' }: IconDividerProps) {
  return (
    <div className={`flex items-center justify-center my-12 h-16 ${className}`} aria-hidden="true">
      {/* Left fading line */}
      <div className="h-px flex-1 bg-gradient-to-r from-transparent via-choir-gold/40 to-choir-gold/70 max-w-[120px]" />

      {/* Musical icon */}
      <img
        src={`/icons/${icon}.svg`}
        alt=""
        className="w-8 h-auto mx-4 opacity-60"
        style={{ filter: 'sepia(0.3) hue-rotate(-10deg) saturate(1.5)' }}
      />

      {/* Right fading line */}
      <div className="h-px flex-1 bg-gradient-to-l from-transparent via-choir-gold/40 to-choir-gold/70 max-w-[120px]" />
    </div>
  )
}
