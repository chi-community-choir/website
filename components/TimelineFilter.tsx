'use client'

import { useState } from 'react'

interface TimelineFilterProps {
  buckets: string[]
  activeBucket: string | null
  onBucketClick: (bucket: string) => void
  onClear: () => void
}

export default function TimelineFilter({
  buckets,
  activeBucket,
  onBucketClick,
  onClear,
}: TimelineFilterProps) {
  const [isExpanded, setIsExpanded] = useState(true)

  if (buckets.length === 0) {
    return null
  }

  return (
    <div className="bg-gray-50 border-2 border-gray-200 rounded-lg overflow-hidden">
      <button
        onClick={() => setIsExpanded(!isExpanded)}
        className="w-full flex items-center justify-between px-4 py-3 bg-choir-blue-dark text-white hover:bg-choir-blue transition-colors"
      >
        <span className="font-semibold text-lg">Jump to Date</span>
        <svg
          className={`w-5 h-5 transition-transform ${isExpanded ? 'rotate-180' : ''}`}
          fill="none"
          stroke="currentColor"
          viewBox="0 0 24 24"
        >
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
        </svg>
      </button>

      {isExpanded && (
        <div className="p-3">
          {activeBucket && (
            <button
              onClick={onClear}
              className="w-full mb-3 px-4 py-2 text-sm bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300 transition-colors"
            >
              Clear Selection
            </button>
          )}

          <div className="space-y-2 max-h-96 overflow-y-auto">
            {buckets.map((bucket) => (
              <button
                key={bucket}
                onClick={() => onBucketClick(bucket)}
                className={`w-full px-4 py-3 text-left rounded-lg font-medium transition-colors ${
                  activeBucket === bucket
                    ? 'bg-choir-blue text-white'
                    : 'bg-white text-gray-700 hover:bg-gray-100 border-2 border-gray-200'
                }`}
              >
                {bucket}
              </button>
            ))}
          </div>
        </div>
      )}
    </div>
  )
}
