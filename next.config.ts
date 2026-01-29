import type { NextConfig } from 'next'

const nextConfig: NextConfig = {
  images: {
    unoptimized: true,
  },
  async headers() {
    return [
      {
        source: '/(.*)',
        headers: [
          {
            key: 'Content-Security-Policy',
            value: [
              "default-src 'self';",
              "script-src 'self' 'unsafe-inline' 'unsafe-eval' https://vercel.live;",
              "script-src-elem 'self' 'unsafe-inline';",
              "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com;",
              "style-src-elem 'self' 'unsafe-inline' https://fonts.googleapis.com;",
              "font-src 'self' https://fonts.googleapis.com https://fonts.gstatic.com;",
              "img-src 'self' data: blob: https://*.public.blob.vercel-storage.com;",
              "media-src 'self' data: blob: https://*.public.blob.vercel-storage.com;",
              "frame-src https://www.google.com;",
              "connect-src 'self' https://fonts.gstatic.com https://fonts.googleapis.com https://vercel.live;",
              "worker-src 'self' blob:;",
              "base-uri 'none';",
              "form-action 'self';",
              "frame-ancestors 'none';",
            ].join(' '),
          },
        ],
      },
    ]
  },
}

export default nextConfig
