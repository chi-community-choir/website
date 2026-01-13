import type { Config } from 'tailwindcss'

const config: Config = {
  content: [
    './pages/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
    './app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      fontFamily: {
        serif: ['var(--font-lora)', 'Georgia', 'serif'],
        sans: ['var(--font-source-sans)', 'system-ui', 'sans-serif'],
      },
      fontSize: {
        base: ['19px', '1.7'],
      },
      colors: {
        // Primary blues
        'choir-blue-dark': '#1a365d',
        'choir-blue': '#2c5282',
        'choir-blue-light': '#4a6fa5',

        // Warm accents
        'choir-coral': '#7c082f',
        'choir-coral-dark': '#4a051C', // Darker coral for accessible buttons
        'choir-peach': '#f4b088',
        'choir-gold': '#d4a574',
        'choir-sunshine': '#ffd816', // Bright and warm for CTA

        // Warm backgrounds
        'choir-cream': '#f5f3ef', // Slightly darker for better container contrast
        'choir-warm-white': '#ffffff', // Pure white for containers
        'choir-warm-gray': '#ddd8cc',
        'choir-peach-tint': '#fff5ee',
      },
      typography: {
        DEFAULT: {
          css: {
            '--tw-prose-body': '#374151',
            '--tw-prose-headings': '#1a365d',
            fontSize: '19px',
            lineHeight: '1.7',
            'h1, h2, h3, h4, h5, h6': {
              fontFamily: 'var(--font-lora), Georgia, serif',
              fontWeight: '700',
              letterSpacing: '-0.015em',
            },
            'p': {
              fontFamily: 'var(--font-source-sans), system-ui, sans-serif',
              lineHeight: '1.7',
              letterSpacing: '0.01em',
            },
            'img': {
              maxWidth: '65%',
              marginLeft: 'auto',
              marginRight: 'auto',
              borderRadius: '0.5rem',
              boxShadow: '0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)',
            },
          },
        },
      },
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
}

export default config
