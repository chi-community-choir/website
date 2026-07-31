import type { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'Repertoire | Chichester Community Choir',
  description: 'Our current and past repertoire',
}

export default function RepertoireLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return children
}
