'use client'

import { useEffect } from 'react'

/**
 * Updates the --scroll-y CSS variable on body for parallax background effect
 * The dotted pattern in globals.css uses this to create subtle depth
 */
export function ParallaxBackground() {
  useEffect(() => {
    let ticking = false

    const updateScrollY = () => {
      document.body.style.setProperty('--scroll-y', `${window.scrollY}px`)
      ticking = false
    }

    const onScroll = () => {
      if (!ticking) {
        requestAnimationFrame(updateScrollY)
        ticking = true
      }
    }

    window.addEventListener('scroll', onScroll, { passive: true })
    updateScrollY() // Initial value

    return () => window.removeEventListener('scroll', onScroll)
  }, [])

  return null
}
