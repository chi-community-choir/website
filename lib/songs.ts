import fs from 'fs'
import path from 'path'
import matter from 'gray-matter'

const songsDirectory = path.join(process.cwd(), 'content/songs')

export interface Song {
  slug: string
  title: string
  composer: string
  arranger?: string
  tags?: string[]
  excerpt?: string
  content?: string
  sheetMusic?: Array<{
    label: string
    url: string
  }>
  audio?: Array<{
    label: string
    url: string
  }>
}

export function getAllSongs(): Song[] {
  // Check if songs directory exists
  if (!fs.existsSync(songsDirectory)) {
    return []
  }

  const fileNames = fs.readdirSync(songsDirectory)
  const allSongsData = fileNames
    .filter((fileName) => fileName.endsWith('.md'))
    .map((fileName) => {
      const slug = fileName.replace(/\.md$/, '')
      const fullPath = path.join(songsDirectory, fileName)
      const fileContents = fs.readFileSync(fullPath, 'utf8')
      const { data } = matter(fileContents)

      return {
        slug,
        title: data.title || 'Untitled',
        composer: data.composer || 'Unknown',
        arranger: data.arranger,
        excerpt: data.excerpt || '',
        tags: data.tags || [],
        sheetMusic: data.sheetMusic || [],
        audio: data.audio || [],
      }
    })

  // Sort songs alphabetically by title
  return allSongsData.sort((a, b) => {
    return a.title.localeCompare(b.title)
  })
}

export async function getSongBySlug(slug: string): Promise<Song | null> {
  if (!fs.existsSync(songsDirectory)) {
    return null
  }

  const fullPath = path.join(songsDirectory, `${slug}.md`)

  if (!fs.existsSync(fullPath)) {
    return null
  }

  const fileContents = fs.readFileSync(fullPath, 'utf8')
  const { data, content } = matter(fileContents)

  return {
    slug,
    title: data.title || 'Untitled',
    composer: data.composer || 'Unknown',
    arranger: data.arranger,
    excerpt: data.excerpt || '',
    tags: data.tags || [],
    sheetMusic: data.sheetMusic || [],
    audio: data.audio || [],
    content: content,
  }
}

export function getAllSongSlugs(): string[] {
  if (!fs.existsSync(songsDirectory)) {
    return []
  }

  const fileNames = fs.readdirSync(songsDirectory)
  return fileNames
    .filter((fileName) => fileName.endsWith('.md'))
    .map((fileName) => fileName.replace(/\.md$/, ''))
}
