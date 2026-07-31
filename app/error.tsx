'use client';

import { useEffect } from 'react';

export default function Error({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  useEffect(() => {
    console.error('Page error:', error);
  }, [error]);

  return (
    <div className="min-h-screen flex items-center justify-center bg-choir-cream">
      <div className="text-center px-4">
        <h1 className="text-4xl font-serif text-choir-blue-dark mb-4">
          Something went wrong
        </h1>
        <p className="text-choir-warm-gray-dark mb-6 text-lg">
          We&apos;re sorry — an unexpected error occurred.
        </p>
        <button
          onClick={() => reset()}
          className="inline-block bg-choir-blue-dark text-white px-6 py-3 rounded-lg hover:bg-choir-blue transition-colors"
        >
          Try again
        </button>
      </div>
    </div>
  );
}
