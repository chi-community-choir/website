# CLAUDE.md - Next.js Rewrite

This file provides guidance for the Claude Code agent and new developers working on rewriting this choir website from Gleam to Next.js.

## Project Context

This was a Gleam-based full-stack web application for the **Chichester Community Choir**. The original codebase is being replaced with a Next.js static site to enable easier maintenance by future developers and content updates by non-technical choir members.

## Goal

Create a **low-maintenance static website** where the choir leader can update blog posts, events, and news by editing markdown files.

## Implementation Reference

See the full plan in: [implementation_plan.md](./implementation_plan.md)

## Quick Start

```bash
# Create new Next.js project in this directory
bunx create-next-app@latest . --typescript --tailwind --app --no-src-dir --no-import-alias

# Install markdown dependencies
bun install gray-matter remark remark-html
```

## Pages to Implement

| Route | Source Reference | Content |
|-------|-----------------|---------|
| `/` | `client/src/client/routes/index.gleam` | Hero banner, info boxes (rehearsal, join, news) |
| `/about` | `client/src/client/routes/about.gleam` | Directors section, choir info, rehearsal info |
| `/events` | `client/src/client/routes/events.gleam` | List of posts from `content/posts/` |
| `/events/[slug]` | `client/src/client/routes/events.gleam` | Individual post, markdown rendered |
| `/find-us` | `client/src/client/routes/find_us.gleam` | Location info with embedded map |
| `/membership` | `client/src/client/routes/membership.gleam` | Joining info, contact details |
| `/repertoire` | `client/src/client/routes/repertoire.gleam` | Public song listing |
| `/repertoire/[slug]` | `client/src/client/routes/repertoire.gleam` | Song detail with external link |

## Key Components

```
components/
├── Navbar.tsx       # Main navigation (from client/src/client/components/navbar.gleam)
├── Footer.tsx       # Footer with contact/social links
├── PostCard.tsx     # Event/post preview card
├── HeroSection.tsx  # Reusable hero banner
└── InfoBox.tsx      # Feature/info boxes from homepage
```

## Content Structure

Create `content/posts/` directory for blog posts:

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

## Styling Guidelines

- Use Tailwind CSS for all styling
- Color palette: Blues (`#1a365d`, `#2c5282`, `#2a4365`), white, light grays
- Match the existing aesthetic from Gleam views
- Responsive design with mobile-first approach

## Existing Assets

- Banner image: `https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/2019-12-13-Choir-Header-1.png`
- Director photos: Same CDN space
- Keep using DigitalOcean Spaces for images

## Data Migration

Export existing data from SQLite database `lfs.db`:

```sql
-- Export posts
SELECT title, content, excerpt, author, slug, created_at FROM posts;

-- Export songs (if keeping repertoire)
SELECT title, slug, href FROM songs;
```

Convert to markdown files in `content/posts/` and `content/songs/`.

## What NOT to Implement

- Admin login/authentication (use GitHub for content editing)
- User sessions
- Song creation UI
- Post creation UI (create markdown files instead)
- SQLite database

## Testing Checklist

1. [ ] All pages render without errors
2. [ ] Markdown posts render correctly
3. [ ] Navigation works on all pages
4. [ ] Mobile responsive on all pages
5. [ ] Deploy to Vercel succeeds
6. [ ] Images load from CDN

## Development Workflow

```bash
# Start dev server
bun run dev

# Check for errors
bun run build

# Type check
bunx tsc --noEmit

# Lint
bun run lint
```

## Deployment

1. Push to GitHub
2. Connect repo to Vercel
3. Vercel auto-deploys on push to main
