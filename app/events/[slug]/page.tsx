import { getPostBySlug, getAllPostSlugs } from '@/lib/posts'
import { notFound } from 'next/navigation'
import Link from 'next/link'
import MarkdownContent from '@/components/MarkdownContent'

interface PageProps {
  params: Promise<{
    slug: string
  }>
}

export async function generateStaticParams() {
  const slugs = getAllPostSlugs()
  return slugs.map((slug) => ({
    slug,
  }))
}

export async function generateMetadata({ params }: PageProps) {
  const { slug } = await params
  const post = await getPostBySlug(slug)

  if (!post) {
    return {
      title: 'Post Not Found',
    }
  }

  return {
    title: `${post.title} | Chichester Community Choir`,
    description: post.excerpt,
  }
}

export default async function PostPage({ params }: PageProps) {
  const { slug } = await params
  const post = await getPostBySlug(slug)

  if (!post) {
    notFound()
  }

  return (
    <div className="max-w-4xl mx-auto px-4 py-12">
      <Link
        href="/events"
        className="text-choir-blue hover:text-choir-blue-dark mb-6 inline-block"
      >
        ← Back to Events
      </Link>

      <article className="bg-white rounded-lg border-2 border-gray-200 p-8 shadow-sm">
        <div className="flex flex-col lg:flex-row lg:items-start lg:justify-between gap-4 mb-6 pb-6 border-b border-gray-200">
          <div className="flex-1">
            <h1 className="text-choir-blue-dark text-4xl font-bold mb-4">
              {post.title}
            </h1>

            <div className="text-gray-600">
              {post.date && (
                <span className="mr-4">
                  {new Date(post.date).toLocaleDateString('en-GB', {
                    year: 'numeric',
                    month: 'long',
                    day: 'numeric',
                  })}
                </span>
              )}
              {post.author && <span>By {post.author}</span>}
            </div>
          </div>

          {post.tags && post.tags.length > 0 && (
            <div className="flex flex-wrap gap-2 lg:max-w-xs">
              {post.tags.map((tag) => (
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

        <MarkdownContent
          content={post.content || ''}
          className="prose prose-lg max-w-none"
        />
      </article>
    </div>
  )
}
