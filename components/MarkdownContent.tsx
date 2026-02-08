'use client'

import ReactMarkdown from 'react-markdown'
import remarkGfm from 'remark-gfm'
import Image from 'next/image'
import type { Components } from 'react-markdown'

interface MarkdownContentProps {
  content: string
  className?: string
}

 import { visit } from 'unist-util-visit';

function remarkFigure() {
  return (tree: any) => {
    visit(tree, 'paragraph', (node, index, parent) => {
      if (!parent || index == null) return;
      if (node.children?.length !== 1) return;

      const img = node.children[0];
      if (img.type !== 'image') return;

      parent.children[index] = {
        type: 'figure',
        data: {
          hName: 'figure',
          hProperties: {
            'data-modifiers': img.title || '', // Pass modifiers to figure component
          },
          hChildren: [
            {
              type: 'element',
              tagName: 'img',
              properties: {
                src: img.url,
                alt: img.alt || '',
                title: img.title || '', // Pass through for img component fallback
              },
              children: [],
            },
            img.alt
              ? {
                  type: 'element',
                  tagName: 'figcaption',
                  properties: {},
                  children: [{ type: 'text', value: img.alt }],
                }
              : null,
          ].filter(Boolean),
        },
      };
    });
  };
}


/**
 * MarkdownContent Component
 *
 * Renders markdown content with warm, welcoming styling optimized for
 * older readers (55+). Features:
 *
 * - 20px base font with 1.75 line-height for readability
 * - Lora serif font for headings (tradition, elegance)
 * - Source Sans 3 for body text (clarity, readability)
 * - Choir color palette integration (blues, coral, peach)
 * - Full accessibility compliance (WCAG AA)
 * - Touch targets sized for older adults (48×48px minimum)
 * - Clear focus indicators for keyboard navigation
 *
 * Design Documentation: docs/design-specs/markdown-styling-specification.md
 */
export default function MarkdownContent({ content, className = '' }: MarkdownContentProps) {
  const components: Components = {
    // =========================================================================
    // HEADINGS (h1-h6)
    // =========================================================================
    // Design: Lora serif font with clear size progression for hierarchy.
    // Choir-blue-dark for primary headings, choir-blue for secondary.
    // Generous top margins prevent cramping; tracking-tight improves readability.

    h1: ({ ...props }) => (
      <h1
        className="font-serif text-[42px] leading-[1.15] text-choir-blue-dark mb-8 mt-12 first:mt-0 font-bold tracking-tight"
        {...props}
      />
    ),

    h2: ({ ...props }) => (
      <h2
        className="font-serif text-[32px] leading-[1.2] text-choir-blue-dark mb-6 mt-10 font-bold tracking-tight"
        {...props}
      />
    ),

    h3: ({ ...props }) => (
      <h3
        className="font-serif text-[24px] leading-[1.25] text-choir-blue mb-5 mt-8 font-semibold tracking-tight"
        {...props}
      />
    ),

    h4: ({ ...props }) => (
      <h4
        className="font-serif text-[20px] leading-[1.3] text-choir-blue mb-4 mt-6 font-semibold"
        {...props}
      />
    ),

    h5: ({ ...props }) => (
      <h5
        className="font-serif text-[18px] leading-[1.3] text-choir-blue mb-3 mt-5 font-semibold"
        {...props}
      />
    ),

    h6: ({ ...props }) => (
      <h6
        className="font-serif text-[16px] leading-[1.4] text-choir-blue mb-3 mt-4 font-semibold uppercase tracking-wide"
        {...props}
      />
    ),

    // =========================================================================
    // PARAGRAPHS
    // =========================================================================
    // Design: 20px base font optimized for older readers with 1.75 line height.
    // Max width of 650px prevents eye fatigue from long lines (60-75 chars).
    // Consistent mb-6 margins create vertical rhythm.

    p: ({ ...props }) => (
      <p
        className="text-[20px] leading-[1.75] text-gray-700 mb-6 max-w-[650px]"
        {...props}
      />
    ),

    // =========================================================================
    // LISTS
    // =========================================================================
    // Design: Coral markers add warmth and visual interest. Generous indentation
    // and spacing (pl-8, space-y-3) improve readability for older eyes.
    // Matches paragraph sizing and max width for consistency.

    ul: ({ ...props }) => (
      <ul
        className="list-disc list-outside text-[20px] leading-[1.75] text-gray-700 mb-6 max-w-[650px] pl-8 space-y-3 marker:text-choir-coral"
        {...props}
      />
    ),

    ol: ({ ...props }) => (
      <ol
        className="list-decimal list-outside text-[20px] leading-[1.75] text-gray-700 mb-6 max-w-[650px] pl-8 space-y-3 marker:text-choir-coral marker:font-semibold"
        {...props}
      />
    ),

    li: ({ ...props }) => (
      <li
        className="text-[20px] leading-[1.75] text-gray-700"
        {...props}
      />
    ),

    // =========================================================================
    // LINKS
    // =========================================================================
    // Design: Choir-blue maintains brand identity. 2px underline with 4px offset
    // creates clear visibility for older eyes. Coral hover adds warmth.
    // Focus indicators (coral ring) essential for keyboard navigation.
    // Touch targets sized for older adults (48×48px minimum).

    a: ({ ...props }) => (
      <a
        className="text-choir-blue underline underline-offset-2 underline-[2px] hover:text-choir-blue-dark hover:decoration-choir-coral focus:outline-none focus-visible:ring-2 focus-visible:ring-choir-coral focus-visible:ring-offset-2 transition-all duration-200 inline-block min-h-[48px] min-w-[48px] py-1"
        {...props}
      />
    ),

    // =========================================================================
    // BLOCKQUOTES
    // =========================================================================
    // Design: Coral border creates warm accent. Peach-tint background differentiates
    // from body text. Lora serif font adds elegant, traditional feel.
    // Larger text (22px) with italic styling clearly indicates quotation.

    blockquote: ({ ...props }) => (
      <blockquote
        className="font-serif text-[22px] leading-[1.7] text-gray-700 my-8 p-6 border-l-4 border-choir-coral bg-choir-sand italic rounded-r-lg"
        {...props}
      />
    ),

    // =========================================================================
    // CODE ELEMENTS
    // =========================================================================
    // Design: Inline code uses peach-tint background with coral border for warmth.
    // Code blocks use dark background to reduce eye strain with coral accent border.
    // Monospace font clearly indicates code content.

    code: ({ children, ...props }) => {
      // Check if this is inline code (not inside pre tag)
      const isInline = !(props as any).className?.includes('language-')

      if (isInline) {
        return (
          <code
            className="font-mono text-[18px] bg-choir-peach-tint text-choir-blue-dark px-2 py-1 rounded border border-choir-peach/50"
            {...props}
          >
            {children}
          </code>
        )
      }

      return <code {...props}>{children}</code>
    },

    pre: ({ ...props }) => (
      <pre
        className="font-mono text-[16px] leading-[1.6] bg-gray-900 text-gray-100 p-6 rounded-lg border-l-4 border-choir-coral my-8 overflow-x-auto max-w-full shadow-warm-md"
        {...props}
      />
    ),

    // =========================================================================
    // TEXT EMPHASIS
    // =========================================================================
    // Design: Strong text uses coral color for warm emphasis while maintaining
    // visibility. Em text keeps italic with slightly darker color for visibility.

    strong: ({ ...props }) => (
      <strong
        className="font-semibold text-choir-blue-dark"
        {...props}
      />
    ),

    em: ({ ...props }) => (
      <em
        className="italic text-gray-800"
        {...props}
      />
    ),

    // =========================================================================
    // TABLES
    // =========================================================================
    // Design: Choir-blue-dark header maintains brand identity. Alternating row
    // backgrounds (zebra striping) improve readability across wide tables.

    table: ({ ...props }) => (
      <div className="my-8 overflow-x-auto max-w-full bg-choir-cream rounded-lg shadow-warm-md border border-choir-warm-gray">
        <table
          className="text-[20px] min-w-full border-collapse"
          {...props}
        />
      </div>
    ),

    thead: ({ ...props }) => (
      <thead
        className="bg-choir-blue-dark text-white"
        {...props}
      />
    ),

    th: ({ ...props }) => (
      <th
        className="font-semibold text-left p-4 border-b-2 border-choir-coral"
        {...props}
      />
    ),

    tbody: ({ ...props }) => (
      <tbody
        className="divide-y divide-gray-300"
        {...props}
      />
    ),

    tr: ({ ...props }) => (
      <tr
        className="even:bg-choir-warm-white"
        {...props}
      />
    ),

    td: ({ ...props }) => (
      <td
        className="p-4"
        {...props}
      />
    ),

    // =========================================================================
    // FIGURE (for standalone images)
    // =========================================================================
    // Handles size and alignment for standalone images transformed by remarkFigure.
    // Alt text becomes the caption. Title attribute contains size/alignment modifiers.
    //
    // Modifiers: "small", "medium", "large", "full", "left", "center", "right"
    // Example: ![Choir performance](url "small left")
    // Defaults: medium size (500px), centered alignment

    figure: ({ children, ...props }) => {
      const modifiers = (props as any)['data-modifiers']?.toLowerCase()?.trim()?.split(/\s+/) || []

      let maxWidth = 'max-w-[500px]'  // default medium
      let alignment = 'mx-auto'  // default centered

      for (const modifier of modifiers) {
        switch (modifier) {
          case 'small':
            maxWidth = 'max-w-[300px]'
            break
          case 'medium':
            maxWidth = 'max-w-[500px]'
            break
          case 'large':
            maxWidth = 'max-w-[900px]'
            break
          case 'full':
            maxWidth = 'max-w-full'
            break
          case 'left':
            alignment = 'mr-auto'
            break
          case 'center':
            alignment = 'mx-auto'
            break
          case 'right':
            alignment = 'ml-auto'
            break
        }
      }

      return (
        <figure className={`my-10 ${maxWidth} ${alignment}`}>
          {children}
        </figure>
      )
    },

    figcaption: ({ children, ...props }) => (
      <figcaption
        className="text-[18px] text-gray-600 text-center mt-3 italic"
        {...props}
      >
        {children}
      </figcaption>
    ),

    // =========================================================================
    // IMAGES
    // =========================================================================
    // For standalone images: wrapped in <figure> by remarkFigure with caption
    // For inline images: rendered directly without wrapper
    //
    // Size & Alignment: Use the title attribute with modifiers:
    // - Sizes: "small", "medium", "large", "full"
    // - Alignment: "left", "center", "right"
    // Example: ![Alt text](url "small left")
    // Defaults: 800x600, no wrapper for inline use

    img: ({ src, alt, title, ...props }) => {
      if (!src || typeof src !== 'string') return null

      const modifiers = title?.toLowerCase()?.trim()?.split(/\s+/) || []

      let imgWidth = 800
      let imgHeight = 600

      for (const modifier of modifiers) {
        switch (modifier) {
          case 'small':
            imgWidth = 400
            imgHeight = 300
            break
          case 'medium':
            imgWidth = 600
            imgHeight = 450
            break
          case 'large':
            imgWidth = 1000
            imgHeight = 750
            break
          case 'full':
            imgWidth = 1200
            imgHeight = 900
            break
        }
      }

      return (
        <Image
          src={src}
          alt={alt || ''}
          width={imgWidth}
          height={imgHeight}
          className="rounded-xl shadow-warm-lg w-full h-auto"
          style={{ objectFit: 'cover' }}
        />
      )
    },

    // =========================================================================
    // HORIZONTAL RULES
    // =========================================================================
    // Design: Coral accent with 30% opacity adds warmth without harshness.
    // 3px thickness improves visibility for older eyes.
    // Generous margins (my-12) create clear section breaks.

    hr: ({ ...props }) => (
      <hr
        className="my-12 border-t-0 border-b-[3px] border-choir-coral/30"
        {...props}
      />
    ),
  }

  return (
    <div className={`markdown-content ${className}`}>
      <ReactMarkdown
        remarkPlugins={[remarkGfm, remarkFigure]}
        components={components}
      >
        {content}
      </ReactMarkdown>
    </div>
  )
}
