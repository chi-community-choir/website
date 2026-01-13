import Link from 'next/link'
import type { Song } from '@/lib/songs'

interface SongCardProps {
  song: Song
}

export default function SongCard({ song }: SongCardProps) {
  const hasSheetMusic = song.sheetMusic && song.sheetMusic.length > 0
  const hasAudio = song.audio && song.audio.length > 0

  return (
    <Link href={`/repertoire/${song.slug}`} className="no-underline">
      <div className="bg-white border-2 border-choir-warm-gray rounded-xl p-6 transition-all hover:border-choir-coral hover:shadow-lg h-full flex flex-col">
        <h2 className="text-choir-blue-dark text-2xl font-bold mb-2">
          {song.title}
        </h2>

        <div className="text-gray-600 text-sm mb-3">
          <div className="font-medium">{song.composer}</div>
          {song.arranger && (
            <div className="text-xs">arr. {song.arranger}</div>
          )}
        </div>

        {song.excerpt && (
          <p className="text-gray-700 leading-relaxed mb-4 flex-grow">
            {song.excerpt}
          </p>
        )}

        {/* Resource indicators */}
        {(hasSheetMusic || hasAudio) && (
          <div className="flex gap-3 mb-4 text-sm">
            {hasSheetMusic && (
              <span className="flex items-center gap-1 text-choir-blue">
                <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                </svg>
                Sheet Music
              </span>
            )}
            {hasAudio && (
              <span className="flex items-center gap-1 text-choir-blue">
                <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 19V6l12-3v13M9 19c0 1.105-1.343 2-3 2s-3-.895-3-2 1.343-2 3-2 3 .895 3 2zm12-3c0 1.105-1.343 2-3 2s-3-.895-3-2 1.343-2 3-2 3 .895 3 2zM9 10l12-3" />
                </svg>
                Audio ({song.audio?.length || 0})
              </span>
            )}
          </div>
        )}

        {song.tags && song.tags.length > 0 && (
          <div className="flex flex-wrap gap-2">
            {song.tags.map((tag) => (
              <span
                key={tag}
                className="bg-choir-peach-tint text-gray-700 px-3 py-1 rounded-full text-sm border border-choir-peach/30"
              >
                {tag}
              </span>
            ))}
          </div>
        )}
      </div>
    </Link>
  )
}
