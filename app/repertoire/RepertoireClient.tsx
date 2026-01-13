'use client'

import { useState, useMemo } from 'react'
import type { Song } from '@/lib/songs'
import SongCard from '@/components/SongCard'
import SearchInput from '@/components/SearchInput'

interface RepertoireClientProps {
  songs: Song[]
}

const ITEMS_PER_PAGE = 24

export default function RepertoireClient({ songs }: RepertoireClientProps) {
  const [searchQuery, setSearchQuery] = useState('')
  const [visibleCount, setVisibleCount] = useState(ITEMS_PER_PAGE)

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

  const displayedSongs = useMemo(() => {
    // When searching, show all filtered results
    if (searchQuery.trim()) {
      return filteredSongs
    }
    // When not searching, limit by visibleCount
    return filteredSongs.slice(0, visibleCount)
  }, [filteredSongs, searchQuery, visibleCount])

  const hasMore = !searchQuery.trim() && visibleCount < filteredSongs.length

  const loadMore = () => {
    setVisibleCount(prev => prev + ITEMS_PER_PAGE)
  }

  return (
    <div className="max-w-6xl mx-auto px-4 py-12">
      <h1 className="text-choir-blue-dark text-4xl font-bold mb-8 text-center">
        Our Repertoire
      </h1>

      {songs.length === 0 ? (
        <div className="text-center py-12 bg-white rounded-lg border-2 border-choir-warm-gray p-8">
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
            <SearchInput
              value={searchQuery}
              onChange={setSearchQuery}
              placeholder="Search songs..."
            />
            {searchQuery && (
              <p className="text-sm text-gray-600 mt-2">
                Found {filteredSongs.length} {filteredSongs.length === 1 ? 'song' : 'songs'}
              </p>
            )}
          </div>

          {displayedSongs.length === 0 ? (
            <div className="text-center py-12">
              <p className="text-xl text-gray-600">
                No songs found matching &ldquo;{searchQuery}&rdquo;
              </p>
            </div>
          ) : (
            <>
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {displayedSongs.map((song) => (
                  <SongCard key={song.slug} song={song} />
                ))}
              </div>

              {hasMore && (
                <div className="text-center mt-8">
                  <button
                    onClick={loadMore}
                    className="px-6 py-3 text-lg bg-choir-coral-dark text-white rounded-lg hover:bg-choir-coral-dark/90 transition-all focus:outline-none focus:ring-2 focus:ring-choir-coral-dark focus:ring-offset-2 active:translate-y-[1px] shadow-warm-md"
                  >
                    Load More Songs
                  </button>
                </div>
              )}
            </>
          )}
        </>
      )}
    </div>
  )
}
