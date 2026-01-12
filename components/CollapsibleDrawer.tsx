'use client'

import { useState, useRef, useEffect } from 'react'

interface CollapsibleDrawerProps {
  title: string
  children: React.ReactNode
  defaultOpen?: boolean
  className?: string
}

export default function CollapsibleDrawer({
  title,
  children,
  defaultOpen = false,
  className = '',
}: CollapsibleDrawerProps) {
  const [isOpen, setIsOpen] = useState(defaultOpen)
  const [height, setHeight] = useState<number | undefined>(defaultOpen ? undefined : 0)
  const contentRef = useRef<HTMLDivElement>(null)

  useEffect(() => {
    if (isOpen) {
      const contentHeight = contentRef.current?.scrollHeight
      setHeight(contentHeight)
    } else {
      setHeight(0)
    }
  }, [isOpen])

  const toggleDrawer = () => {
    setIsOpen(!isOpen)
  }

  return (
    <div className={`border border-gray-200 rounded-lg overflow-hidden ${className}`}>
      <button
        onClick={toggleDrawer}
        className="w-full flex items-center justify-between p-4 bg-gray-50 hover:bg-gray-100 transition-colors text-left"
        aria-expanded={isOpen}
      >
        <h3 className="text-lg font-semibold text-gray-700">{title}</h3>
        <svg
          className={`w-5 h-5 text-gray-600 transition-transform duration-200 ${
            isOpen ? 'rotate-180' : ''
          }`}
          fill="none"
          stroke="currentColor"
          viewBox="0 0 24 24"
        >
          <path
            strokeLinecap="round"
            strokeLinejoin="round"
            strokeWidth={2}
            d="M19 9l-7 7-7-7"
          />
        </svg>
      </button>
      <div
        style={{ height }}
        className="transition-all duration-300 ease-in-out overflow-hidden"
      >
        <div ref={contentRef} className="p-4 bg-white">
          {children}
        </div>
      </div>
    </div>
  )
}
