import { getAllSongs } from '@/lib/songs'
import SongCard from '@/components/SongCard'

export const metadata = {
  title: 'Repertoire | Chichester Community Choir',
  description: 'Our current and past repertoire',
}

export default function RepertoirePage() {
  const songs = getAllSongs()

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
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {songs.map((song) => (
            <SongCard key={song.slug} song={song} />
          ))}
        </div>
      )}
    </div>
  )
}
