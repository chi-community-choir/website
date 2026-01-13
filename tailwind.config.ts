import type { Config } from 'tailwindcss'

const config: Config = {
  content: [
    './pages/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
    './app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        // Primary blues
        'choir-blue-dark': '#1a365d',
        'choir-blue': '#2c5282',
        'choir-blue-light': '#4a6fa5',

        // Warm accents
        'choir-coral': '#e8856e',
        'choir-peach': '#f4b088',
        'choir-gold': '#d4a574',

        // Warm backgrounds
        'choir-cream': '#faf7f2',
        'choir-warm-white': '#fdfbf7',
        'choir-warm-gray': '#e8e3db',
        'choir-peach-tint': '#fff5ee',
      },
      typography: {
        DEFAULT: {
          css: {
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
