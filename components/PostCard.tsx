import Link from 'next/link'
import type { Post } from '@/lib/posts'

interface PostCardProps {
  post: Post
}

export default function PostCard({ post }: PostCardProps) {
  return (
    <Link href={`/events/${post.slug}`} className="no-underline">
      <div className="bg-white border-2 border-gray-200 rounded-xl p-6 transition-all hover:border-choir-blue hover:shadow-lg">
        <h2 className="text-choir-blue-dark text-2xl font-bold mb-2">
          {post.title}
        </h2>

        <div className="text-gray-600 text-sm mb-3">
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

        <p className="text-gray-700 leading-relaxed">{post.excerpt}</p>

        {post.tags && post.tags.length > 0 && (
          <div className="mt-4 flex flex-wrap gap-2">
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
    </Link>
  )
}
