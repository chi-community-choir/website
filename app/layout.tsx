import type { Metadata } from 'next'
import { Analytics } from '@vercel/analytics/next'
import { SpeedInsights } from '@vercel/speed-insights/next'
import localFont from 'next/font/local'
import './globals.css'
import Navbar from '@/components/Navbar'
import Footer from '@/components/Footer'
import { ParallaxBackground } from '@/components/ParallaxBackground'

// Font configurations - using local fonts for privacy and performance
const lora = localFont({
  src: '../public/fonts/Lora/Lora-VariableFont_wght.ttf',
  variable: '--font-lora',
  display: 'swap',
  weight: '100 900',
})

const sourceSans = localFont({
  src: '../public/fonts/Source_Sans_3/SourceSans3-VariableFont_wght.ttf',
  variable: '--font-source-sans',
  display: 'swap',
  weight: '100 900',
})

const SITE_URL = process.env.NEXT_PUBLIC_SITE_URL || 'https://dev.chicommunitychoir.com' // TODO: correct SITE_URL when deploying publicly

export const metadata: Metadata = {
  title: 'Chichester Community Choir',
  description: 'A vibrant community choir in Chichester. Join us in the joy of singing! No auditions required - just bring your enthusiasm and love for music.',
  keywords: ['community choir', 'Chichester', 'singing', 'choir', 'West Sussex', 'music', 'no auditions'],
  authors: [{ name: 'Chichester Community Choir' }],
  creator: 'Chichester Community Choir',
  publisher: 'Chichester Community Choir',

  metadataBase: new URL(SITE_URL),

  openGraph: {
    type: 'website',
    locale: 'en_GB',
    url: SITE_URL,
    title: 'Chichester Community Choir',
    description: 'A vibrant community choir in Chichester. Join us in the joy of singing! No auditions required.',
    siteName: 'Chichester Community Choir',
    images: [
      {
        url: '/2019-12-13-Choir-Header-1.png',
        width: 1200,
        height: 630,
        alt: 'Chichester Community Choir',
      },
    ],
  },

  twitter: {
    card: 'summary_large_image',
    title: 'Chichester Community Choir',
    description: 'A vibrant community choir in Chichester. Join us in the joy of singing!',
    site: '@ChicCommChoir',
    creator: '@ChicCommChoir',
    images: ['/2019-12-13-Choir-Header-1.png'],
  },

  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      'max-video-preview': -1,
      'max-image-preview': 'large',
      'max-snippet': -1,
    },
  },

}

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html lang="en" className={`${lora.variable} ${sourceSans.variable}`}>
      <body className={`${sourceSans.className} antialiased flex flex-col min-h-screen`}>
        <ParallaxBackground />
        <Navbar />
        <main className="flex-grow">
          {children}
        </main>
        <Footer />
        <Analytics />
        <SpeedInsights />
      </body>
    </html>
  )
}
