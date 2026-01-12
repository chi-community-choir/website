import { getAllPosts } from '@/lib/posts'
import EventsClient from './EventsClient'

export default function EventsPage() {
  const posts = getAllPosts()

  return <EventsClient posts={posts} />
}
