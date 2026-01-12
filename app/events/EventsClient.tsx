'use client'

import React, { useState, useMemo, useEffect, useRef } from 'react'
import type { Post } from '@/lib/posts'
import PostCard from '@/components/PostCard'
import TimelineFilter from '@/components/TimelineFilter'

interface EventsClientProps {
  posts: Post[]
}

const ITEMS_PER_PAGE = 20

export default function EventsClient({ posts }: EventsClientProps) {
  const [searchQuery, setSearchQuery] = useState('')
  const [visibleCount, setVisibleCount] = useState(ITEMS_PER_PAGE)
  const [activeBucket, setActiveBucket] = useState<string | null>(null)
  const sentinelRef = useRef<HTMLDivElement>(null)
  const observerRef = useRef<IntersectionObserver | null>(null)

  const filteredPosts = useMemo(() => {
    let filtered = posts

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
  }, [posts, searchQuery])

  const displayedPosts = useMemo(() => {
    // When searching, show all filtered results
    if (searchQuery.trim()) {
      return filteredPosts
    }
    // When not searching, limit by visibleCount
    return filteredPosts.slice(0, visibleCount)
  }, [filteredPosts, searchQuery, visibleCount])

  // Extract unique buckets in order of appearance
  const availableBuckets = useMemo(() => {
    const buckets: string[] = []
    const seen = new Set<string>()

    for (const post of filteredPosts) {
      if (post.bucket && !seen.has(post.bucket)) {
        buckets.push(post.bucket)
        seen.add(post.bucket)
      }
    }

    return buckets
  }, [filteredPosts])

  const hasMore = !searchQuery.trim() && visibleCount < filteredPosts.length

  const loadMore = () => {
    setVisibleCount(prev => prev + ITEMS_PER_PAGE)
  }

  // Set up IntersectionObserver for infinite scroll
  useEffect(() => {
    if (!sentinelRef.current) return

    // Clean up previous observer
    if (observerRef.current) {
      observerRef.current.disconnect()
    }

    // Create new observer
    observerRef.current = new IntersectionObserver(
      (entries) => {
        const [entry] = entries
        if (entry.isIntersecting && hasMore) {
          loadMore()
        }
      },
      {
        root: null,
        rootMargin: '100px', // Start loading a bit before reaching the sentinel
        threshold: 0.1,
      }
    )

    observerRef.current.observe(sentinelRef.current)

    // Cleanup
    return () => {
      if (observerRef.current) {
        observerRef.current.disconnect()
      }
    }
  }, [hasMore])

  // Custom smooth scroll with easing for gentle animation
  const smoothScrollTo = (element: HTMLElement) => {
    const targetPosition = element.getBoundingClientRect().top + window.pageYOffset - 20
    const startPosition = window.pageYOffset
    const distance = targetPosition - startPosition
    const duration = 1500 // 1.5 seconds for gentle scroll
    let start: number | null = null

    const easeInOutCubic = (t: number): number => {
      return t < 0.5 ? 4 * t * t * t : (t - 1) * (2 * t - 2) * (2 * t - 2) + 1
    }

    const animation = (currentTime: number) => {
      if (start === null) start = currentTime
      const timeElapsed = currentTime - start
      const progress = Math.min(timeElapsed / duration, 1)
      const easing = easeInOutCubic(progress)

      window.scrollTo(0, startPosition + distance * easing)

      if (timeElapsed < duration) {
        requestAnimationFrame(animation)
      }
    }

    requestAnimationFrame(animation)
  }

  const handleBucketClick = (bucket: string) => {
    setActiveBucket(bucket)

    // Find the index of the first post in this bucket
    const bucketIndex = filteredPosts.findIndex(post => post.bucket === bucket)

    if (bucketIndex !== -1) {
      // Ensure we show enough posts to include this bucket
      const minVisible = bucketIndex + 1
      if (visibleCount < minVisible) {
        setVisibleCount(Math.max(minVisible, ITEMS_PER_PAGE))
      }

      // Gentle smooth scroll to the bucket header
      setTimeout(() => {
        const element = document.getElementById(`bucket-${bucket}`)
        if (element) {
          smoothScrollTo(element)
        }
      }, 100)
    }
  }

  const handleClearBucket = () => {
    setActiveBucket(null)
  }

  return (
    <div className="min-h-screen">
      {/* Header with Search (center) and Date Jumplist (right) */}
      <div className="bg-white border-b-2 border-gray-200 sticky top-0 z-30 shadow-sm">
        <div className="max-w-7xl mx-auto px-4 py-6">
          <div className="flex flex-col lg:flex-row gap-6 items-start">
            {/* Left/Center: Title and Search */}
            <div className="flex-1 w-full">
              <h1 className="text-choir-blue-dark text-4xl font-bold mb-4 text-center lg:text-left">
                Events & News
              </h1>

              {posts.length > 0 && (
                <div className="max-w-2xl lg:max-w-none">
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

                  {searchQuery && (
                    <p className="text-sm text-gray-600 text-center lg:text-left mt-2">
                      Found {filteredPosts.length} {filteredPosts.length === 1 ? 'event' : 'events'}
                    </p>
                  )}
                </div>
              )}
            </div>

            {/* Right: Date Jumplist (desktop only) */}
            {posts.length > 0 && (
              <div className="hidden lg:block w-64 flex-shrink-0">
                <TimelineFilter
                  buckets={availableBuckets}
                  activeBucket={activeBucket}
                  onBucketClick={handleBucketClick}
                  onClear={handleClearBucket}
                />
              </div>
            )}
          </div>
        </div>
      </div>

      {/* Main Content Area */}
      {posts.length === 0 ? (
        <div className="text-center py-12 px-4">
          <p className="text-xl text-gray-600">
            No events posted yet. Check back soon for updates on our upcoming performances!
          </p>
        </div>
      ) : (
        <div className="max-w-7xl mx-auto px-4 py-8">
          <div className="flex flex-col lg:flex-row gap-8">
            {/* Posts List - Left/Center */}
            <div className="flex-1 min-w-0 max-w-3xl">
              {displayedPosts.length === 0 ? (
                <div className="text-center py-12">
                  <p className="text-xl text-gray-600">
                    No events found matching &ldquo;{searchQuery}&rdquo;
                  </p>
                </div>
              ) : (
                <>
                  <div className="space-y-4">
                    {displayedPosts.map((post) => (
                      <PostCard key={post.slug} post={post} />
                    ))}
                  </div>

                  {/* Sentinel for infinite scroll */}
                  <div ref={sentinelRef} className="h-4" />

                  {/* Fallback "Load More" button */}
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
            </div>

            {/* Date Markers - Right Side (desktop only) */}
            {displayedPosts.length > 0 && (
              <div className="hidden lg:block w-64 flex-shrink-0 relative">
                <div className="sticky top-36">
                  {(() => {
                    const markers: React.ReactElement[] = []
                    let lastBucket: string | null = null

                    displayedPosts.forEach((post) => {
                      if (post.bucket && post.bucket !== lastBucket) {
                        markers.push(
                          <div
                            key={`marker-${post.bucket}`}
                            id={`bucket-${post.bucket}`}
                            className="mb-4 bg-choir-blue-dark text-white py-2 px-4 rounded-lg shadow-md"
                          >
                            <h3 className="text-lg font-bold">{post.bucket}</h3>
                          </div>
                        )
                        lastBucket = post.bucket
                      }
                    })

                    return markers
                  })()}
                </div>
              </div>
            )}
          </div>
        </div>
      )}
    </div>
  )
}
