import { getSongBySlug, getAllSongSlugs } from '@/lib/songs'
import { notFound } from 'next/navigation'
import Link from 'next/link'
import MarkdownContent from '@/components/MarkdownContent'
import CollapsibleDrawer from '@/components/CollapsibleDrawer'

interface PageProps {
  params: Promise<{
    slug: string
  }>
}

export async function generateStaticParams() {
  const slugs = getAllSongSlugs()
  return slugs.map((slug) => ({
    slug,
  }))
}

export async function generateMetadata({ params }: PageProps) {
  const { slug } = await params
  const song = await getSongBySlug(slug)

  if (!song) {
    return {
      title: 'Song Not Found',
    }
  }

  return {
    title: `${song.title} | Chichester Community Choir`,
    description: song.excerpt || `${song.title} by ${song.composer}`,
  }
}

export default async function SongPage({ params }: PageProps) {
  const { slug } = await params
  const song = await getSongBySlug(slug)

  if (!song) {
    notFound()
  }

  const hasSheetMusic = song.sheetMusic && song.sheetMusic.length > 0
  const hasAudio = song.audio && song.audio.length > 0

  return (
    <div className="max-w-6xl mx-auto px-4 py-12">
      <Link
        href="/repertoire"
        className="text-choir-blue hover:text-choir-blue-dark mb-6 inline-block"
      >
        ← Back to Repertoire
      </Link>

      <article className="bg-white rounded-lg border-2 border-choir-warm-gray p-8 shadow-warm-sm">
        <div className="flex flex-col lg:flex-row lg:items-start lg:justify-between gap-4 mb-6 pb-6 border-b border-gray-200">
          <div className="flex-1">
            <h1 className="text-choir-blue-dark text-4xl font-bold mb-4">
              {song.title}
            </h1>

            <div className="text-gray-600">
              <div className="text-lg">
                <span className="font-semibold">Composer:</span> {song.composer}
              </div>
              {song.arranger && (
                <div className="text-sm mt-1">
                  <span className="font-semibold">Arranged by:</span> {song.arranger}
                </div>
              )}
            </div>
          </div>

          {song.tags && song.tags.length > 0 && (
            <div className="flex flex-wrap gap-2 lg:max-w-xs">
              {song.tags.map((tag) => (
                <span
                  key={tag}
                  className="bg-gray-100 text-gray-700 px-3 py-1 rounded-full text-sm"
                >
                  {tag}
                </span>
              ))}
            </div>
          )}
        </div>

        {/* Resources Section */}
        {(hasSheetMusic || hasAudio) && (
          <div className="mb-8 space-y-4">
            <h2 className="text-2xl font-bold text-choir-blue-dark mb-4">
              Resources
            </h2>

            {/* Sheet Music Drawer */}
            {hasSheetMusic && (
              <CollapsibleDrawer title="Sheet Music" defaultOpen={true}>
                <div className="space-y-2">
                  {song.sheetMusic?.map((sheet, index) => (
                    <a
                      key={index}
                      href={sheet.url}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="flex items-center gap-2 text-choir-blue hover:text-choir-blue-dark hover:underline p-3 bg-gray-50 rounded-lg border border-gray-200 hover:border-choir-blue transition-colors"
                    >
                      <svg className="w-5 h-5 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                      </svg>
                      <span className="font-medium">{sheet.label}</span>
                      <svg className="w-4 h-4 ml-auto" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
                      </svg>
                    </a>
                  ))}
                </div>
              </CollapsibleDrawer>
            )}

            {/* Audio Drawer */}
            {hasAudio && (
              <CollapsibleDrawer title="Audio Files" defaultOpen={true}>
                <div className="space-y-4">
                  {song.audio?.map((audioFile, index) => (
                    <div key={index}>
                      <div className="font-medium text-gray-700 mb-2">
                        {audioFile.label}
                      </div>
                      <audio controls className="w-full">
                        <source src={audioFile.url} type="audio/mpeg" />
                        Your browser does not support audio playback.
                      </audio>
                    </div>
                  ))}
                </div>
              </CollapsibleDrawer>
            )}
          </div>
        )}

        {/* Content */}
        {song.content && (
          <MarkdownContent
            content={song.content}
            className="max-w-none"
          />
        )}
      </article>
    </div>
  )
}
