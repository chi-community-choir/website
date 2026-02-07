'use client'

import React, { useState, useMemo, useEffect, useRef } from 'react'
import type { Post } from '@/lib/posts'
import PostCard from '@/components/PostCard'
import TimelineFilter from '@/components/TimelineFilter'
import SearchInput from '@/components/SearchInput'

interface EventsClientProps {
  posts: Post[]
}

interface BucketGroup {
  bucket: string
  posts: Post[]
}

const ITEMS_PER_PAGE = 20
const SCROLL_OFFSET = 240

export default function EventsClient({ posts }: EventsClientProps) {
  const [searchQuery, setSearchQuery] = useState('')
  const [visibleCount, setVisibleCount] = useState(ITEMS_PER_PAGE)
  const [activeBucket, setActiveBucket] = useState<string | null>(null)
  const sentinelRef = useRef<HTMLDivElement>(null)
  const observerRef = useRef<IntersectionObserver | null>(null)

  // Parse a search query to extract potential date patterns
  const parseDateQuery = (query: string): Date | null => {
    // Try various date formats
    const formats = [
      /^(\d{4})-(\d{1,2})-(\d{1,2})$/,      // YYYY-MM-DD
      /^(\d{1,2})\/(\d{1,2})\/(\d{4})$/,    // DD/MM/YYYY or MM/DD/YYYY
      /^(\d{1,2})-(\d{1,2})-(\d{4})$/,      // DD-MM-YYYY or MM-DD-YYYY
      /^(\d{4})$/,                          // YYYY (year only)
    ]

    for (const format of formats) {
      const match = query.match(format)
      if (match) {
        const parts = match.slice(1)
        if (format === formats[3]) {
          // Year only
          return new Date(parseInt(parts[0]), 0, 1)
        }
        // Try both day/month and month/day interpretations
        const [a, b, c] = parts.map(Number)
        // Assume DD/MM/YYYY format (UK standard for this choir)
        if (b >= 1 && b <= 12 && c >= 1000) {
          const date = new Date(c, b - 1, a)
          if (!isNaN(date.getTime())) return date
        }
        // Try MM/DD/YYYY as fallback
        if (a >= 1 && a <= 12 && c >= 1000) {
          const date = new Date(c, a - 1, b)
          if (!isNaN(date.getTime())) return date
        }
      }
    }
    return null
  }

  const filteredPosts = useMemo(() => {
    let filtered = posts

    // Apply search filter
    if (searchQuery.trim()) {
      const query = searchQuery.toLowerCase()

      // First, try to parse the entire query as a date (for exact date searches)
      const fullDateMatch = parseDateQuery(searchQuery.trim())

      // If not a full date, extract date components and text separately
      let extractedYear: number | null = null
      let extractedMonth: number | null = null
      let textTerms = query

      if (!fullDateMatch) {
        // Extract year (4 digits starting with 1 or 2)
        const yearMatch = query.match(/\b(1[8-9]\d{2}|20\d{2})\b/)
        if (yearMatch) {
          extractedYear = parseInt(yearMatch[1])
          textTerms = textTerms.replace(yearMatch[0], ' ').trim()
        }

        // Extract month name
        const monthNames = [
          'january', 'february', 'march', 'april', 'may', 'june',
          'july', 'august', 'september', 'october', 'november', 'december'
        ]
        const shortMonthNames = [
          'jan', 'feb', 'mar', 'apr', 'may', 'jun',
          'jul', 'aug', 'sep', 'oct', 'nov', 'dec'
        ]

        for (let i = 0; i < monthNames.length; i++) {
          const fullName = monthNames[i]
          const shortName = shortMonthNames[i]

          // Use word boundary to avoid partial matches (e.g., "mar" matching "March")
          const fullRegex = new RegExp(`\\b${fullName}\\b`, 'i')
          const shortRegex = new RegExp(`\\b${shortName}\\b`, 'i')

          if (fullRegex.test(query)) {
            extractedMonth = i
            textTerms = textTerms.replace(fullRegex, ' ').trim()
            break
          } else if (shortRegex.test(query)) {
            extractedMonth = i
            textTerms = textTerms.replace(shortRegex, ' ').trim()
            break
          }
        }

        // Clean up multiple spaces
        textTerms = textTerms.replace(/\s+/g, ' ').trim()
      }

      filtered = filtered.filter((post) => {
        // Case 1: Full date match (e.g., "2024-01-15" or "15/01/2024")
        if (fullDateMatch && post.date) {
          const postDate = new Date(post.date)
          if (!isNaN(postDate.getTime())) {
            const sameYear = postDate.getFullYear() === fullDateMatch.getFullYear()
            const sameMonth = postDate.getMonth() === fullDateMatch.getMonth()
            const sameDay = postDate.getDate() === fullDateMatch.getDate()
            // Match if year matches (year-only search) or year+month or full date
            if (sameYear) return true
          }
        }

        // Case 2: Extracted date components + text search (e.g., "2025 january" or "February Test")
        if (extractedYear !== null || extractedMonth !== null) {
          // Check date match
          let dateMatches = true
          if (post.date) {
            const postDate = new Date(post.date)
            if (!isNaN(postDate.getTime())) {
              if (extractedYear !== null && postDate.getFullYear() !== extractedYear) {
                dateMatches = false
              }
              if (extractedMonth !== null && postDate.getMonth() !== extractedMonth) {
                dateMatches = false
              }
            } else {
              dateMatches = false
            }
          } else {
            dateMatches = false
          }

          // Check text match (only if there are text terms remaining)
          let textMatches = true
          if (textTerms) {
            textMatches =
              post.title.toLowerCase().includes(textTerms) ||
              post.author?.toLowerCase().includes(textTerms) ||
              post.excerpt?.toLowerCase().includes(textTerms) ||
              post.tags?.some(tag => tag.toLowerCase().includes(textTerms))
          }

          return dateMatches && textMatches
        }

        // Case 3: Text-only search (no date components detected)
        // Also match against bucket format (MM/YYYY)
        const bucketMatch = post.bucket?.toLowerCase().includes(query)
        const textMatch =
          post.title.toLowerCase().includes(query) ||
          post.author?.toLowerCase().includes(query) ||
          post.excerpt?.toLowerCase().includes(query) ||
          post.tags?.some(tag => tag.toLowerCase().includes(query))

        return textMatch || bucketMatch
      })
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
      <div className="bg-white border-b-2 border-choir-warm-gray sticky top-0 z-30 shadow-warm-sm">
        <div className="max-w-7xl mx-auto px-4 py-6">
          <div className="flex flex-col lg:flex-row gap-6 items-start">
            {/* Left/Center: Title and Search */}
            <div className="flex-1 w-full">
              <h1 className="text-choir-blue-dark text-4xl font-bold mb-4 text-center lg:text-left">
                Events & News
              </h1>

              {posts.length > 0 && (
                <div className="max-w-2xl lg:max-w-none">
                  <SearchInput
                    value={searchQuery}
                    onChange={setSearchQuery}
                    placeholder="Search events by title, content, tags or date"
                  />

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
                  className="flex flex-col lg:flex-row gap-6 mb-8"
                >
                  {/* Posts column */}
                  <div className="flex-1 min-w-0 space-y-4">
                    {group.posts.map((post) => (
                      <PostCard key={post.slug} post={post} />
                    ))}
                  </div>

                  {/* Date marker - aligned with this bucket group (desktop only) */}
                  <div className="hidden lg:block w-64 flex-shrink-0">
                    <div
                      className="sticky bg-gradient-to-br from-choir-blue-dark to-choir-blue text-white py-2 px-4 rounded-lg shadow-warm-md"
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
                    className="px-6 py-3 text-lg bg-choir-coral-dark text-white rounded-lg hover:bg-choir-coral-dark/90 transition-all focus:outline-none focus:ring-2 focus:ring-choir-coral-dark focus:ring-offset-2 active:translate-y-[1px] shadow-warm-md"
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
