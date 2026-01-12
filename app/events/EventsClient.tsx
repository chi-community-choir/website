'use client'

import React, { useState, useMemo, useEffect, useRef } from 'react'
import type { Post } from '@/lib/posts'
import PostCard from '@/components/PostCard'
import TimelineFilter from '@/components/TimelineFilter'

interface EventsClientProps {
  posts: Post[]
}

interface BucketGroup {
  bucket: string
  posts: Post[]
}

const ITEMS_PER_PAGE = 20
// Height of sticky header (py-6 = 24px*2 = 48px padding + ~60px content ≈ 140px, plus some margin)
const SCROLL_OFFSET = 160

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

  // Group displayed posts by bucket for rendering
  const bucketGroups = useMemo((): BucketGroup[] => {
    const groups: BucketGroup[] = []
    let currentBucket: string | null = null
    let currentGroup: Post[] = []

    for (const post of displayedPosts) {
      const bucket = post.bucket || 'Unknown'

      if (bucket !== currentBucket) {
        // Save previous group if exists
        if (currentBucket !== null && currentGroup.length > 0) {
          groups.push({ bucket: currentBucket, posts: currentGroup })
        }
        // Start new group
        currentBucket = bucket
        currentGroup = [post]
      } else {
        currentGroup.push(post)
      }
    }

    // Don't forget the last group
    if (currentBucket !== null && currentGroup.length > 0) {
      groups.push({ bucket: currentBucket, posts: currentGroup })
    }

    return groups
  }, [displayedPosts])

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

      // Wait for state update and DOM render, then scroll
      requestAnimationFrame(() => {
        requestAnimationFrame(() => {
          const element = document.getElementById(`bucket-${bucket}`)
          if (element) {
            const elementTop = element.getBoundingClientRect().top + window.scrollY
            window.scrollTo({
              top: elementTop - SCROLL_OFFSET,
              behavior: 'smooth'
            })
          }
        })
      })
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
          {displayedPosts.length === 0 ? (
            <div className="text-center py-12">
              <p className="text-xl text-gray-600">
                No events found matching &ldquo;{searchQuery}&rdquo;
              </p>
            </div>
          ) : (
            <>
              {/* Bucket groups with aligned markers */}
              {bucketGroups.map((group) => (
                <div
                  key={group.bucket}
                  id={`bucket-${group.bucket}`}
                  className="flex flex-col lg:flex-row gap-4 lg:gap-8 mb-8"
                >
                  {/* Posts column */}
                  <div className="flex-1 min-w-0 max-w-3xl space-y-4">
                    {group.posts.map((post) => (
                      <PostCard key={post.slug} post={post} />
                    ))}
                  </div>

                  {/* Date marker - aligned with this bucket group (desktop only) */}
                  <div className="hidden lg:block w-64 flex-shrink-0">
                    <div
                      className="sticky bg-choir-blue-dark text-white py-2 px-4 rounded-lg shadow-md"
                      style={{ top: `${SCROLL_OFFSET}px` }}
                    >
                      <h3 className="text-lg font-bold">{group.bucket}</h3>
                    </div>
                  </div>
                </div>
              ))}

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
      )}
    </div>
  )
}
