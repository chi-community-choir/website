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
      boxShadow: {
        'warm-sm': '0 1px 2px 0 rgba(180, 130, 90, 0.05)',
        'warm': '0 1px 3px 0 rgba(180, 130, 90, 0.1), 0 1px 2px -1px rgba(180, 130, 90, 0.1)',
        'warm-md': '0 4px 6px -1px rgba(180, 130, 90, 0.15), 0 2px 4px -2px rgba(180, 130, 90, 0.1)',
        'warm-lg': '0 10px 15px -3px rgba(180, 130, 90, 0.15), 0 4px 6px -4px rgba(180, 130, 90, 0.1)',
        'warm-xl': '0 20px 25px -5px rgba(180, 130, 90, 0.15), 0 8px 10px -6px rgba(180, 130, 90, 0.1)',
        'warm-2xl': '0 25px 50px -12px rgba(180, 130, 90, 0.25)',
      },
      colors: {
        // Primary blues
        'choir-blue-dark': '#1a365d',
        'choir-blue': '#2c5282',
        'choir-blue-light': '#4a6fa5',

        // Warm accents
        'choir-coral': '#7c082f',
        'choir-coral-dark': '#4a051C',
        'choir-peach': '#f4b088',
        'choir-gold': '#d4a574',
        'choir-sunshine': '#ffd816',

        // Warm backgrounds
        'choir-cream': '#f2eee4',
        'choir-warm-white': '#e6dfcc',
        'choir-warm-gray': '#ddd8cc',
        'choir-peach-tint': '#fff5ee',
        'choir-sand': '#f2e4c5',
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
