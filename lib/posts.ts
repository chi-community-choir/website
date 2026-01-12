import fs from 'fs'
import path from 'path'
import matter from 'gray-matter'

const postsDirectory = path.join(process.cwd(), 'content/posts')

function deriveTimeBucket(dateString: string): { year: string; month: string; bucket: string } {
  if (!dateString) {
    return { year: '', month: '', bucket: 'Unknown' }
  }

  const postDate = new Date(dateString)
  const now = new Date()

  const postYear = postDate.getFullYear()
  const postMonth = postDate.getMonth()
  const currentYear = now.getFullYear()
  const currentMonth = now.getMonth()

  const monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ]

  const year = postYear.toString()
  const month = `${monthNames[postMonth]} ${postYear}`

  // Determine bucket label
  let bucket: string

  if (postYear === currentYear && postMonth === currentMonth) {
    bucket = 'This Month'
  } else if (
    postYear === currentYear && postMonth === currentMonth - 1 ||
    (currentMonth === 0 && postYear === currentYear - 1 && postMonth === 11)
  ) {
    bucket = 'Last Month'
  } else if (postYear === currentYear) {
    bucket = month
  } else {
    bucket = year
  }

  return { year, month, bucket }
}

export interface Post {
  slug: string
  title: string
  date: string
  excerpt: string
  author: string
  tags?: string[]
  content?: string
  year?: string
  month?: string
  bucket?: string
}

export function getAllPosts(): Post[] {
  // Check if posts directory exists
  if (!fs.existsSync(postsDirectory)) {
    return []
  }

  const fileNames = fs.readdirSync(postsDirectory)
  const allPostsData = fileNames
    .filter((fileName) => fileName.endsWith('.md'))
    .map((fileName) => {
      const slug = fileName.replace(/\.md$/, '')
      const fullPath = path.join(postsDirectory, fileName)
      const fileContents = fs.readFileSync(fullPath, 'utf8')
      const { data } = matter(fileContents)

      const date = data.date || ''
      const { year, month, bucket } = deriveTimeBucket(date)

      return {
        slug,
        title: data.title || 'Untitled',
        date,
        excerpt: data.excerpt || '',
        author: data.author || '',
        tags: data.tags || [],
        year,
        month,
        bucket,
      }
    })

  // Sort posts by date
  return allPostsData.sort((a, b) => {
    if (a.date < b.date) {
      return 1
    } else {
      return -1
    }
  })
}

export async function getPostBySlug(slug: string): Promise<Post | null> {
  if (!fs.existsSync(postsDirectory)) {
    return null
  }

  const fullPath = path.join(postsDirectory, `${slug}.md`)

  if (!fs.existsSync(fullPath)) {
    return null
  }

  const fileContents = fs.readFileSync(fullPath, 'utf8')
  const { data, content } = matter(fileContents)

  return {
    slug,
    title: data.title || 'Untitled',
    date: data.date || '',
    excerpt: data.excerpt || '',
    author: data.author || '',
    tags: data.tags || [],
    content: content,
  }
}

export function getAllPostSlugs(): string[] {
  if (!fs.existsSync(postsDirectory)) {
    return []
  }

  const fileNames = fs.readdirSync(postsDirectory)
  return fileNames
    .filter((fileName) => fileName.endsWith('.md'))
    .map((fileName) => fileName.replace(/\.md$/, ''))
}
