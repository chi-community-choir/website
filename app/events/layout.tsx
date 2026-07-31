import type { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'Events | Chichester Community Choir',
  description: 'Upcoming performances, concerts, and events',
}

export default function EventsLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return children
}
