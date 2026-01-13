interface BucketHeaderProps {
  bucket: string
}

export default function BucketHeader({ bucket }: BucketHeaderProps) {
  return (
    <div
      id={`bucket-${bucket}`}
      className="sticky top-0 z-10 bg-gradient-to-r from-choir-blue-dark to-choir-blue text-white py-3 px-6 mb-4 rounded-lg shadow-warm-md"
    >
      <h2 className="text-2xl font-bold">{bucket}</h2>
    </div>
  )
}
