import { getAllPosts } from '@/lib/posts'
import PostCard from '@/components/PostCard'

export const metadata = {
  title: 'Events | Chichester Community Choir',
  description: 'Upcoming performances, concerts, and events',
}

export default function EventsPage() {
  const posts = getAllPosts()

  return (
    <div className="max-w-6xl mx-auto px-4 py-12">
      <h1 className="text-choir-blue-dark text-4xl font-bold mb-8 text-center">
        Events & News
      </h1>

      {posts.length === 0 ? (
        <div className="text-center py-12">
          <p className="text-xl text-gray-600">
            No events posted yet. Check back soon for updates on our upcoming performances!
          </p>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          {posts.map((post) => (
            <PostCard key={post.slug} post={post} />
          ))}
        </div>
      )}
    </div>
  )
}
