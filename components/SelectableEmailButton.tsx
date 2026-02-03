'use client'

import Image from 'next/image'

interface SelectableEmailButtonProps {
  email: string
  label?: string
}

export function SelectableEmailButton({ email, label = 'Email' }: SelectableEmailButtonProps) {
  return (
    <a
      href={`mailto:${email}`}
      draggable={false}
      onClick={(e) => {
        // If user has selected text, don't navigate
        if (window.getSelection()?.toString()) {
          e.preventDefault()
        }
      }}
      className="inline-flex flex-col sm:flex-row items-center gap-2 sm:gap-3 bg-choir-coral hover:bg-choir-coral/90 text-white font-bold text-lg sm:text-xl px-8 sm:px-10 py-4 rounded-full shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-1"
    >
      <Image src="/icons/mail.svg" alt="Mail icon" width={24} height={24} className="shrink-0 brightness-0 invert" />
      <span className="text-center select-text">
        {label}
        <span className="block text-sm font-normal opacity-90">{email}</span>
      </span>
    </a>
  )
}
