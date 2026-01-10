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
│   ├── membership/
│   ├── repertoire/
│   ├── layout.tsx         # Root layout with nav/footer
│   └── page.tsx           # Homepage
├── components/            # React components
│   ├── Navbar.tsx
│   ├── Footer.tsx
│   ├── HeroSection.tsx
│   ├── InfoBox.tsx
│   └── PostCard.tsx
├── content/               # Markdown content
│   ├── posts/            # Blog posts/events
│   └── songs/            # Repertoire (future)
├── lib/                   # Utility functions
│   └── posts.ts          # Markdown processing
└── public/                # Static assets
```

## Pages

| Route | File | Content |
|-------|------|---------|
| `/` | `app/page.tsx` | Hero banner, info boxes (rehearsal, join, news) |
| `/about` | `app/about/page.tsx` | Directors section, choir info, rehearsal info |
| `/events` | `app/events/page.tsx` | List of posts from `content/posts/` |
| `/events/[slug]` | `app/events/[slug]/page.tsx` | Individual post, markdown rendered |
| `/find-us` | `app/find-us/page.tsx` | Location info with embedded map |
| `/membership` | `app/membership/page.tsx` | Joining info, contact details |
| `/repertoire` | `app/repertoire/page.tsx` | Public song listing |

## Components

| Component | Purpose |
|-----------|---------|
| `Navbar.tsx` | Main navigation with responsive menu |
| `Footer.tsx` | Footer with contact info and social links |
| `PostCard.tsx` | Event/post preview card for listings |
| `HeroSection.tsx` | Reusable hero banner component |
| `InfoBox.tsx` | Feature/info boxes used on homepage |

## Content Management

Blog posts and events are managed as markdown files in `content/posts/`.

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

## Styling Guidelines

- Tailwind CSS for all styling
- Color palette: Blues (`#1a365d`, `#2c5282`, `#2a4365`), white, light grays
- Responsive design with mobile-first approach
- Consistent spacing and typography using Tailwind utilities

## Assets

- Banner image: `https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/2019-12-13-Choir-Header-1.png`
- Director photos hosted on DigitalOcean Spaces CDN
- All external images should use the DigitalOcean CDN

## Technology Stack

- **Framework**: Next.js 15 (App Router)
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **Content**: Markdown with gray-matter, remark, remark-html
- **Runtime**: Bun (Node.js compatible)
- **Deployment**: Vercel

## Development Notes

- No authentication or admin interface (content managed via Git)
- Static site generation for optimal performance
- Markdown files are the source of truth for content
- All routes pre-rendered at build time

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

The site is deployed to Vercel with automatic deployments:
- Push to `main` branch triggers production deployment
- Pull requests generate preview deployments
- Build errors will prevent deployment

See `DEPLOYMENT.md` for detailed deployment information.
