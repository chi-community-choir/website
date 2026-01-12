'use client'

import { useState, useMemo } from 'react'
import type { Post } from '@/lib/posts'
import PostCard from '@/components/PostCard'

interface EventsClientProps {
  posts: Post[]
}

const ITEMS_PER_PAGE = 20

export default function EventsClient({ posts }: EventsClientProps) {
  const [searchQuery, setSearchQuery] = useState('')
  const [visibleCount, setVisibleCount] = useState(ITEMS_PER_PAGE)
  const [startMonth, setStartMonth] = useState('')
  const [endMonth, setEndMonth] = useState('')

  const filteredPosts = useMemo(() => {
    let filtered = posts

    // Apply date range filter
    if (startMonth || endMonth) {
      filtered = filtered.filter((post) => {
        if (!post.date) return false

        // Extract YYYY-MM from post date (format: YYYY-MM-DD)
        const postMonth = post.date.substring(0, 7)

        const afterStart = !startMonth || postMonth >= startMonth
        const beforeEnd = !endMonth || postMonth <= endMonth

        return afterStart && beforeEnd
      })
    }

    // Apply search filter
    if (searchQuery.trim()) {
      const query = searchQuery.toLowerCase()
      filtered = filtered.filter((post) =>
        post.title.toLowerCase().includes(query) ||
        post.author?.toLowerCase().includes(query) ||
        post.excerpt?.toLowerCase().includes(query) ||
        post.tags?.some(tag => tag.toLowerCase().includes(query))
      )
    }

    return filtered
  }, [posts, searchQuery, startMonth, endMonth])

  const displayedPosts = useMemo(() => {
    // When searching, show all filtered results
    if (searchQuery.trim()) {
      return filteredPosts
    }
    // When not searching, limit by visibleCount
    return filteredPosts.slice(0, visibleCount)
  }, [filteredPosts, searchQuery, visibleCount])

  const hasMore = !searchQuery.trim() && visibleCount < filteredPosts.length

  const loadMore = () => {
    setVisibleCount(prev => prev + ITEMS_PER_PAGE)
  }

  const clearFilters = () => {
    setStartMonth('')
    setEndMonth('')
  }

  const hasDateFilter = startMonth || endMonth

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
        <>
          <div className="mb-8 max-w-2xl mx-auto space-y-4">
            <div className="relative">
              <input
                type="text"
                placeholder="Search events..."
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

            <div className="bg-gray-50 border-2 border-gray-200 rounded-lg p-4">
              <div className="flex items-center justify-between mb-3">
                <label className="text-sm font-semibold text-gray-700">Filter by Date Range</label>
                {hasDateFilter && (
                  <button
                    onClick={clearFilters}
                    className="text-sm text-choir-blue hover:text-choir-blue-dark transition-colors"
                  >
                    Clear
                  </button>
                )}
              </div>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                <div>
                  <label htmlFor="startMonth" className="block text-xs text-gray-600 mb-1">
                    From
                  </label>
                  <input
                    type="month"
                    id="startMonth"
                    value={startMonth}
                    onChange={(e) => setStartMonth(e.target.value)}
                    className="w-full px-3 py-2 border-2 border-gray-300 rounded-lg focus:outline-none focus:border-choir-blue transition-colors"
                  />
                </div>
                <div>
                  <label htmlFor="endMonth" className="block text-xs text-gray-600 mb-1">
                    To
                  </label>
                  <input
                    type="month"
                    id="endMonth"
                    value={endMonth}
                    onChange={(e) => setEndMonth(e.target.value)}
                    className="w-full px-3 py-2 border-2 border-gray-300 rounded-lg focus:outline-none focus:border-choir-blue transition-colors"
                  />
                </div>
              </div>
            </div>

            {(searchQuery || hasDateFilter) && (
              <p className="text-sm text-gray-600 text-center">
                Found {filteredPosts.length} {filteredPosts.length === 1 ? 'event' : 'events'}
              </p>
            )}
          </div>

          {displayedPosts.length === 0 ? (
            <div className="text-center py-12">
              <p className="text-xl text-gray-600">
                No events found matching &ldquo;{searchQuery}&rdquo;
              </p>
            </div>
          ) : (
            <>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                {displayedPosts.map((post) => (
                  <PostCard key={post.slug} post={post} />
                ))}
              </div>

              {hasMore && (
                <div className="text-center mt-8">
                  <button
                    onClick={loadMore}
                    className="px-6 py-3 bg-choir-blue text-white rounded-lg hover:bg-choir-blue-dark transition-colors"
                  >
                    Load More Events
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
