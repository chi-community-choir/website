'use client'

import { useState, useMemo } from 'react'

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
  // Parse buckets into year-month structure
  const yearMonthData = useMemo(() => {
    const data: Record<string, Set<string>> = {}

    buckets.forEach((bucket) => {
      // Bucket format is MM/YYYY
      const [month, year] = bucket.split('/')
      if (year && month) {
        if (!data[year]) {
          data[year] = new Set()
        }
        data[year].add(month)
      }
    })

    return data
  }, [buckets])

  // Get sorted years (most recent first)
  const years = useMemo(() => {
    return Object.keys(yearMonthData).sort((a, b) => parseInt(b) - parseInt(a))
  }, [yearMonthData])

  // Default to most recent year
  const [selectedYear, setSelectedYear] = useState(() => years[0] || '')

  if (buckets.length === 0 || years.length === 0) {
    return null
  }

  const monthsInYear = yearMonthData[selectedYear] || new Set()

  // All months for grid display
  const allMonths = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12']

  return (
    <div className="bg-gray-50 border-2 border-gray-200 rounded-lg p-3 shadow-sm">
      <div className="flex items-center justify-between mb-3">
        <h3 className="text-xs font-bold text-choir-blue-dark uppercase tracking-wide">
          Jump to Date
        </h3>
        {activeBucket && (
          <button
            onClick={onClear}
            className="px-2 py-0.5 text-xs bg-gray-200 text-gray-700 rounded-md hover:bg-gray-300 transition-all focus:outline-none focus:ring-2 focus:ring-choir-blue focus:ring-offset-1 active:translate-y-[1px]"
          >
            Clear
          </button>
        )}
      </div>

      {/* Year selector - horizontal scrollable */}
      <div className="mb-3 overflow-x-auto">
        <div className="flex gap-2 pb-1">
          {years.map((year) => (
            <button
              key={year}
              onClick={() => setSelectedYear(year)}
              className={`px-3 py-1.5 text-sm font-semibold rounded-lg whitespace-nowrap transition-all focus:outline-none focus:ring-2 focus:ring-choir-blue focus:ring-offset-1 active:translate-y-[1px] ${
                selectedYear === year
                  ? 'bg-choir-blue text-white'
                  : 'bg-white text-gray-700 border border-gray-300 hover:border-choir-blue'
              }`}
            >
              {year}
            </button>
          ))}
        </div>
      </div>

      {/* Month grid - 6x2 layout */}
      <div className="grid grid-cols-6 gap-1.5">
        {allMonths.map((month) => {
          const hasPost = monthsInYear.has(month)
          const bucket = `${month}/${selectedYear}`
          const isActive = activeBucket === bucket

          return (
            <button
              key={month}
              onClick={() => hasPost && onBucketClick(bucket)}
              disabled={!hasPost}
              className={`px-2 py-1.5 text-xs font-medium rounded-md transition-all ${
                isActive
                  ? 'bg-choir-blue text-white'
                  : hasPost
                  ? 'bg-white text-gray-700 border border-gray-300 hover:border-choir-blue hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-choir-blue focus:ring-offset-1 active:translate-y-[1px]'
                  : 'bg-gray-100 text-gray-400 cursor-not-allowed opacity-50'
              }`}
            >
              {month}
            </button>
          )
        })}
      </div>
    </div>
  )
}
