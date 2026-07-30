import type { NextConfig } from 'next'

const isDev = process.env.NODE_ENV === 'development'

const devDirectives = [
  "script-src 'self' 'unsafe-inline' 'unsafe-eval' https://vercel.live;",
  "connect-src 'self' https://fonts.gstatic.com https://fonts.googleapis.com https://vercel.live;",
]

const prodDirectives = [
  "script-src 'self';",
  "connect-src 'self' https://fonts.gstatic.com https://fonts.googleapis.com;",
]

const sharedDirectives = [
  "default-src 'self';",
  "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com;",
  "font-src 'self' https://fonts.googleapis.com https://fonts.gstatic.com;",
  "img-src 'self' data: blob: https://*.public.blob.vercel-storage.com;",
  "media-src 'self' data: blob: https://*.public.blob.vercel-storage.com;",
  "frame-src https://www.google.com;",
  "worker-src 'self' blob:;",
  "base-uri 'none';",
  "form-action 'self';",
  "frame-ancestors 'none';",
]

const nextConfig: NextConfig = {
  images: {
    unoptimized: true,
  },
  async headers() {
    const csp = [
      ...sharedDirectives,
      ...(isDev ? devDirectives : prodDirectives),
    ].join(' ')

    return [
      {
        source: '/(.*)',
        headers: [
          {
            key: 'Content-Security-Policy',
            value: csp,
          },
        ],
      },
    ]
  },
}

export default nextConfig
