'use client'

import { useState, useMemo } from 'react'
import type { Song } from '@/lib/songs'
import SongCard from '@/components/SongCard'

interface RepertoireClientProps {
  songs: Song[]
}

export default function RepertoireClient({ songs }: RepertoireClientProps) {
  const [searchQuery, setSearchQuery] = useState('')

  const filteredSongs = useMemo(() => {
    if (!searchQuery.trim()) {
      return songs
    }
    const query = searchQuery.toLowerCase()
    return songs.filter((song) =>
      song.title.toLowerCase().includes(query) ||
      song.composer?.toLowerCase().includes(query) ||
      song.arranger?.toLowerCase().includes(query) ||
      song.excerpt?.toLowerCase().includes(query) ||
      song.tags?.some(tag => tag.toLowerCase().includes(query))
    )
  }, [songs, searchQuery])

  return (
    <div className="max-w-6xl mx-auto px-4 py-12">
      <h1 className="text-choir-blue-dark text-4xl font-bold mb-8 text-center">
        Our Repertoire
      </h1>

      {songs.length === 0 ? (
        <div className="text-center py-12 bg-white rounded-lg border-2 border-gray-200 p-8">
          <p className="text-xl text-gray-600 mb-4">
            Our repertoire listing is being updated. Check back soon!
          </p>
          <p className="text-gray-600">
            We perform a wide variety of musical styles using SATB voice parts: from madrigals to mash-ups,
            rounds to rock, and canons to classical.
          </p>
        </div>
      ) : (
        <>
          <div className="mb-8 max-w-md mx-auto">
            <div className="relative">
              <input
                type="text"
                placeholder="Search songs..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="w-full px-4 py-3 pr-10 border-2 border-gray-300 rounded-lg focus:outline-none focus:border-choir-blue transition-colors"
              />
              <svg
                className="absolute right-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth={2}
                  d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
                />
              </svg>
            </div>
            {searchQuery && (
              <p className="text-sm text-gray-600 mt-2">
                Found {filteredSongs.length} {filteredSongs.length === 1 ? 'song' : 'songs'}
              </p>
            )}
          </div>

          {filteredSongs.length === 0 ? (
            <div className="text-center py-12">
              <p className="text-xl text-gray-600">
                No songs found matching &ldquo;{searchQuery}&rdquo;
              </p>
            </div>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
              {filteredSongs.map((song) => (
                <SongCard key={song.slug} song={song} />
              ))}
            </div>
          )}
        </>
      )}
    </div>
  )
}
