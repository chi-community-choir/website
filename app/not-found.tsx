import Link from 'next/link';

export default function NotFound() {
  return (
    <div className="min-h-screen flex items-center justify-center bg-choir-cream">
      <div className="text-center px-4">
        <h1 className="text-4xl font-serif text-choir-blue-dark mb-4">
          Page not found
        </h1>
        <p className="text-choir-warm-gray-dark mb-6 text-lg">
          The page you&apos;re looking for doesn&apos;t exist.
        </p>
        <Link
          href="/"
          className="inline-block bg-choir-blue-dark text-white px-6 py-3 rounded-lg hover:bg-choir-blue transition-colors"
        >
          Go home
        </Link>
      </div>
    </div>
  );
}
