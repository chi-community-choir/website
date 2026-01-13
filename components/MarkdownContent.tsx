'use client'

import ReactMarkdown from 'react-markdown'
import remarkGfm from 'remark-gfm'
import Image from 'next/image'
import type { Components } from 'react-markdown'

interface MarkdownContentProps {
  content: string
  className?: string
}

export default function MarkdownContent({ content, className = '' }: MarkdownContentProps) {
  const components: Components = {
    h1: ({ ...props }) => (
      <h1 className="text-4xl font-bold text-choir-blue-dark mb-6 mt-8 first:mt-0" {...props} />
    ),
    h2: ({ ...props }) => (
      <h2 className="text-3xl font-bold text-choir-blue-dark mb-4 mt-8" {...props} />
    ),
    h3: ({ ...props }) => (
      <h3 className="text-2xl font-semibold text-choir-blue mb-3 mt-6" {...props} />
    ),
    h4: ({ ...props }) => (
      <h4 className="text-xl font-semibold text-choir-blue mb-3 mt-4" {...props} />
    ),
    p: ({ ...props }) => (
      <p className="text-lg leading-relaxed text-gray-700 mb-4" {...props} />
    ),
    ul: ({ ...props }) => (
      <ul className="list-disc list-inside space-y-2 mb-4 text-lg text-gray-700" {...props} />
    ),
    ol: ({ ...props }) => (
      <ol className="list-decimal list-inside space-y-2 mb-4 text-lg text-gray-700" {...props} />
    ),
    blockquote: ({ ...props }) => (
      <blockquote className="border-l-4 border-choir-blue pl-4 py-2 my-4 italic text-gray-600" {...props} />
    ),
    a: ({ ...props }) => (
      <a className="text-choir-blue hover:text-choir-blue-dark underline transition-colors" {...props} />
    ),
    img: ({ ...props }) => {
      const { src, alt } = props
      if (!src || typeof src !== 'string') return null

      return (
        <span className="block my-8">
          <Image
            src={src}
            alt={alt || ''}
            width={800}
            height={600}
            className="rounded-lg shadow-md mx-auto"
            style={{ maxWidth: '65%', height: 'auto' }}
          />
        </span>
      )
    },
    hr: () => <hr className="my-8 border-t-2 border-gray-200" />,
  }

  return (
    <div className={className}>
      <ReactMarkdown
        remarkPlugins={[remarkGfm]}
        components={components}
      >
        {content}
      </ReactMarkdown>
    </div>
  )
}
