'use client'

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
  if (buckets.length === 0) {
    return null
  }

  return (
    <div className="bg-gray-50 border-2 border-gray-200 rounded-lg p-3 shadow-sm">
      <h3 className="text-xs font-bold text-choir-blue-dark mb-2 uppercase tracking-wide">
        Jump to Date
      </h3>

      {activeBucket && (
        <button
          onClick={onClear}
          className="w-full mb-2 px-2 py-1 text-xs bg-gray-200 text-gray-700 rounded hover:bg-gray-300 transition-colors"
        >
          Clear Selection
        </button>
      )}

      <div className="space-y-1 max-h-48 overflow-y-auto pr-1">
        {buckets.map((bucket) => (
          <button
            key={bucket}
            onClick={() => onBucketClick(bucket)}
            className={`w-full px-2 py-1.5 text-left text-xs rounded transition-colors ${
              activeBucket === bucket
                ? 'bg-choir-blue text-white font-semibold'
                : 'text-gray-700 hover:bg-gray-100'
            }`}
          >
            {bucket}
          </button>
        ))}
      </div>
    </div>
  )
}
