interface BucketHeaderProps {
  bucket: string
}

export default function BucketHeader({ bucket }: BucketHeaderProps) {
  return (
    <div
      id={`bucket-${bucket}`}
      className="sticky top-0 z-10 bg-choir-blue-dark text-white py-3 px-6 mb-4 rounded-lg shadow-md"
    >
      <h2 className="text-2xl font-bold">{bucket}</h2>
    </div>
  )
}
