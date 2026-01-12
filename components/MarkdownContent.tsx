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
    img: ({ ...props }) => {
      const { src, alt } = props
      if (!src || typeof src !== 'string') return null

      return (
        <span className="block my-6">
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
