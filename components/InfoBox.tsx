import Link from 'next/link'

interface InfoBoxProps {
  title: string
  children: React.ReactNode
  linkHref?: string
  linkText?: string
  className?: string
}

export default function InfoBox({ title, children, linkHref, linkText, className = '' }: InfoBoxProps) {
  return (
    <div className={`${className || 'bg-white'} border-2 border-choir-warm-gray rounded-lg p-6 text-center transition-all hover:shadow-warm-lg hover:scale-[1.02] hover:border-choir-peach shadow-warm`}>
      <h2 className="text-choir-blue-dark text-2xl font-bold mb-4">{title}</h2>
      <div className="text-gray-700 text-lg mb-4">{children}</div>
      {linkHref && linkText && (
        <Link
          href={linkHref}
          className="inline-block bg-choir-coral text-white px-6 py-3 rounded-lg text-lg no-underline mt-2 transition-all hover:bg-choir-coral/90 focus:outline-none focus:ring-2 focus:ring-choir-coral focus:ring-offset-2 active:translate-y-[1px] shadow-warm-md"
        >
          {linkText}
        </Link>
      )}
    </div>
  )
}
