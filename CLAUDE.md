# CLAUDE.md

This file provides guidance for the Claude Code agent and developers working on the **Chichester Community Choir** website.

## Project Context

This is a Next.js static website for the **Chichester Community Choir**. Built with TypeScript, Tailwind CSS, and markdown-based content management to enable easy maintenance by developers and content updates by non-technical choir members.

## Quick Start

```bash
# Install dependencies
bun install

# Start development server
bun run dev

# Build for production
bun run build

# Start production server
bun run start
```

## Project Structure

```
chi-comm-choir/
├── app/                    # Next.js app directory (routes)
│   ├── about/
│   ├── events/
│   │   └── [slug]/        # Dynamic event pages
│   ├── find-us/
│   ├── repertoire/
│   │   └── [slug]/        # Dynamic song pages
│   ├── layout.tsx         # Root layout with nav/footer
│   └── page.tsx           # Homepage
├── components/            # React components
├── content/               # Markdown content
│   ├── posts/            # Blog posts/events
│   └── songs/            # Repertoire
├── docs/                  # Documentation and templates
├── lib/                   # Utility functions
└── public/                # Static assets
```

## Technology Stack

- **Framework**: Next.js 15.1.4 (App Router)
- **Language**: TypeScript 5.7.2
- **Styling**: Tailwind CSS 3.4.17 with custom design system
- **Content Processing**:
  - `gray-matter` for markdown frontmatter
  - `react-markdown` for rendering
  - `remark-gfm` for GitHub-flavored markdown
  - `rehype-raw` for HTML in markdown
- **Typography**: @tailwindcss/typography plugin
- **Runtime**: Bun (Node.js compatible)
- **Deployment**: Vercel with static export

## Design System

### Typography

| Usage | Font | Weight |
|-------|------|--------|
| Headings | Lora (serif) | 700 |
| Body | Source Sans 3 (sans-serif) | 400 |

- Base font size: 19px with 1.7 line-height for readability
- Next.js font optimization with variable fonts

### Color Palette

**Primary Blues:**
- `choir-blue-dark`: `#1a365d` - Headers, footer
- `choir-blue`: `#2c5282` - Primary actions
- `choir-blue-light`: `#4a6fa5` - Hover states

**Warm Accents:**
- `choir-coral`: `#7c082f` - Accent color
- `choir-peach`: `#f4b088` - Highlights
- `choir-gold`: `#d4a574` - Premium touches
- `choir-sunshine`: `#ffd816` - CTAs

**Backgrounds:**
- `choir-cream`: `#f5f3ef` - Main background
- `choir-warm-white`: `#ffffff` - Card backgrounds
- `choir-warm-gray`: `#ddd8cc` - Borders
- `choir-peach-tint`: `#fff5ee` - Soft sections

**Shadows:** Custom warm-toned shadows (`warm-sm` to `warm-2xl`)

### Design Principles

- High readability and accessibility (larger text, clear contrast)
- Warm, inviting color palette
- Classical typography that feels established and trustworthy
- Subtle depth and warmth
- Mobile-first responsive design

See `DESIGN.md` for full design direction and implementation phases.

## Pages

| Route | File | Content |
|-------|------|---------|
| `/` | `app/page.tsx` | Hero banner, info boxes (rehearsal, join, news) |
| `/about` | `app/about/page.tsx` | Directors section, choir info, rehearsal info |
| `/events` | `app/events/page.tsx` | List of posts from `content/posts/` |
| `/events/[slug]` | `app/events/[slug]/page.tsx` | Individual post, markdown rendered |
| `/find-us` | `app/find-us/page.tsx` | Location info with embedded map |
| `/repertoire` | `app/repertoire/page.tsx` | Public song listing |
| `/repertoire/[slug]` | `app/repertoire/[slug]/page.tsx` | Individual song details |

## Components

| Component | Purpose |
|-----------|---------|
| `Navbar.tsx` | Main navigation with responsive menu |
| `Footer.tsx` | Footer with contact info and social links |
| `HeroSection.tsx` | Reusable hero banner component |
| `InfoBox.tsx` | Feature/info boxes used on homepage |
| `PostCard.tsx` | Event/post preview card for listings |
| `SongCard.tsx` | Song preview card for repertoire |
| `MarkdownContent.tsx` | Custom markdown renderer with styling |
| `CollapsibleDrawer.tsx` | Expandable sections for song resources |
| `SearchInput.tsx` | Search functionality |
| `TimelineFilter.tsx` | Event filtering by time period |
| `BucketHeader.tsx` | Header component |

## Content Management

Blog posts/events and songs are managed as markdown files.

### Adding a New Post

1. Create a new file: `content/posts/YYYY-MM-DD-slug.md`
2. Add frontmatter and content:

```markdown
---
title: "Event Title"
date: "2024-01-15"
excerpt: "Brief description for card view"
author: "Author Name"
tags: ["concert", "event"]
---

Full markdown content here...
```

3. Commit and push to trigger deployment

### Adding a New Song

1. Create a new file: `content/songs/slug.md`
2. Add frontmatter:

```markdown
---
title: "Song Title"
composer: "Composer Name"
arranger: "Arranger Name"
tags: ["classical", "folk"]
excerpt: "Brief description"
sheetMusic:
  - name: "SATB"
    url: "https://example.com/satb.pdf"
audio:
  - name: "Demo"
    url: "https://example.com/demo.mp3"
---

Optional description content...
```

Templates available in `docs/templates/`.

## Library Functions

| File | Purpose |
|------|---------|
| `lib/posts.ts` | Post data fetching, sorting, time bucketing |
| `lib/songs.ts` | Song data fetching, alphabetical sorting |

## Assets

**Image Hosting:** Vercel Blob Storage
- Base URL: `https://[random-prefix].public.blob.vercel-storage.com/`
- Banner image: `2019-12-13-Choir-Header-1.png`

**Local Assets:** `public/` directory (currently minimal)

## Configuration

| File | Purpose |
|------|---------|
| `next.config.ts` | Static export enabled, image optimization disabled |
| `tailwind.config.ts` | Custom design system with typography plugin |
| `tsconfig.json` | TypeScript strict mode, path aliases (`@/*`) |
| `postcss.config.mjs` | Standard PostCSS configuration |

## Development Notes

- No authentication or admin interface (content managed via Git)
- Static site generation (`output: 'export'`) for optimal performance
- Markdown files are the source of truth for content
- All routes pre-rendered at build time
- Build output: `/out` directory

## Development Workflow

```bash
# Start development server
bun run dev

# Build for production (check for errors)
bun run build

# Type check
bunx tsc --noEmit

# Lint code
bun run lint
```

## Deployment

**Hosting:** Vercel (free tier)
**DNS:** Cloudflare (CNAME to Vercel)

Process:
1. Push to GitHub
2. Vercel auto-deploys from `main` branch
3. Cloudflare proxies to custom domain

**Cost:** Free tier (100GB/month bandwidth, unlimited builds)

Pull requests generate preview deployments. Build errors will prevent deployment.

See `DEPLOYMENT.md` for detailed deployment information.

## Documentation

- `DESIGN.md` - Design system documentation and implementation plan
- `DEPLOYMENT.md` - Deployment guide
- `HANDOFF.md` - Support handoff guide
- `docs/templates/` - Content templates for posts and songs
- `docs/guides/` - Content creation guides
