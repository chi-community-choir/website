# Architecture

## Rendering Strategy

The site uses a **hybrid rendering model** with Next.js App Router:

| Route | Strategy | Description |
|-------|----------|-------------|
| `/`, `/about`, `/find-us`, `/membership` | **Static** | Server-rendered at build time, no client interactivity |
| `/events`, `/repertoire` | **Hybrid** | Server component fetches data, passes to client component for search/filter/pagination |
| `/events/[slug]`, `/repertoire/[slug]` | **SSG** | `generateStaticParams()` pre-builds all pages from markdown content at build time |

## Server/Client Component Split

Server components (`page.tsx`) fetch content from markdown files and pass serialized data to client components (`*Client.tsx`) which manage interactivity.

```
  content/posts/*.md                    content/songs/*.md
        │                                      │
        v                                      v
  lib/posts.ts                          lib/songs.ts
  (gray-matter parsing)                 (gray-matter parsing)
        │                                      │
        v                                      v
  app/events/page.tsx                   app/repertoire/page.tsx
  (Server Component)                    (Server Component)
        │                                      │
        v                                      v
  app/events/EventsClient.tsx           app/repertoire/RepertoireClient.tsx
  (Client Component: search,            (Client Component: search,
   infinite scroll, timeline filter)     infinite scroll)
        │                                      │
        v                                      v
  components/PostCard                   components/SongCard
        │                                      │
        v                                      v
  app/events/[slug]/page.tsx            app/repertoire/[slug]/page.tsx
  (Server Component: fetch one post)    (Server Component: fetch one song)
        │                                      │
        v                                      v
  components/MarkdownContent            components/MarkdownContent
  (Client Component: render markdown)   (Client Component: render markdown)
```

## Route Map

```
/                           Home page with hero, info cards, CTA
/about                      Director bios, choir info, rehearsal details
/find-us                    Google Maps embed, directions, parking
/membership                 Pricing, payment info, FAQ
/events                     Blog-style posts with search, timeline, infinite scroll
/events/[slug]              Dynamic post detail page
/repertoire                 Song catalog with search, infinite scroll grid
/repertoire/[slug]          Dynamic song detail with sheet music/audio downloads
```

## Directory Structure

```
app/                          Route-based pages (Next.js App Router)
  page.tsx                    Home page
  layout.tsx                  Root layout (fonts, metadata, Navbar, Footer)
  globals.css                 Global styles (Tailwind + typography)
  error.tsx                   Error boundary fallback
  not-found.tsx               Custom 404 page
  events/
    layout.tsx                Events section metadata
    page.tsx                  Events list (server component)
    EventsClient.tsx          Events list (client: search, filter, scroll)
    [slug]/page.tsx           Event detail (server component)
  repertoire/
    layout.tsx                Repertoire section metadata
    page.tsx                  Repertoire list (server component)
    RepertoireClient.tsx      Repertoire list (client: search, scroll)
    [slug]/page.tsx           Song detail (server component)

components/                   Shared React components
  Navbar.tsx                  Site navigation
  Footer.tsx                  Contact, rehearsals, join CTA
  InfoBox.tsx                 Card with title, content, link
  PostCard.tsx                Blog post card
  SongCard.tsx                Song card with composer/excerpt/resource indicators
  MarkdownContent.tsx         Markdown renderer (react-markdown + remark-gfm)
  MusicalDivider.tsx          Decorative SVG dividers
  ParallaxBackground.tsx      Scroll-driven parallax dots
  SearchInput.tsx             Search input with icon
  SelectableEmailButton.tsx   Email button
  CollapsibleDrawer.tsx       Accordion for sheet music/audio sections
  TimelineFilter.tsx          Year/month grid selector for events

lib/                          Data access layer
  constants.ts                Shared business values (email, address, pricing, etc.)
  posts.ts                    Read and parse markdown posts from content/posts/
  songs.ts                    Read and parse markdown songs from content/songs/
  useInfiniteScroll.ts        Shared infinite scroll hook (IntersectionObserver)

content/                      Markdown content (filesystem CMS)
  posts/                      Blog posts (*.md with YAML frontmatter)
  songs/                      Repertoire songs (*.md with YAML frontmatter)

public/                       Static assets
  fonts/                      Self-hosted variable fonts (Lora, Source Sans 3)
  icons/                      SVG icons
  images/                     Stave images for dividers

docs/                         Documentation
  guides/                     Content author guides
  templates/                  Content templates
```

## Component Catalog

| Component | Type | Purpose |
|-----------|------|---------|
| `Navbar` | Server | Navigation links to all pages |
| `Footer` | Server | Contact info, rehearsal details, copyright |
| `InfoBox` | Server | Reusable card with title, markdown content, link |
| `PostCard` | Server | Blog post preview card |
| `SongCard` | Server | Song preview card |
| `MarkdownContent` | Client | Renders markdown with custom styling, figure plugin, image sizing |
| `MusicalDivider` | Server | Decorative SVG divider (icon or stave variant) |
| `ParallaxBackground` | Client | Scroll-driven CSS variable for parallax dots effect |
| `SearchInput` | Client | Controlled search input with magnifying glass icon |
| `SelectableEmailButton` | Client | Mailto button with text selection support |
| `CollapsibleDrawer` | Client | Animated accordion for sheet music and audio sections |
| `TimelineFilter` | Client | Year/month grid selector with scroll-to-bucket navigation |

## Content Model

Content is stored as Markdown files with YAML frontmatter. No database, no CMS.

### Post Frontmatter

```yaml
title: string (required)
date: YYYY-MM-DD (required)
excerpt: string (required)
author: string (required)
tags: string[] (optional)
```

### Song Frontmatter

```yaml
title: string (required)
composer: string (required)
arranger: string (optional)
excerpt: string (required)
tags: string[] (optional)
sheetMusic: Array<{ label: string, url: string }> (optional)
audio: Array<{ label: string, url: string }> (optional)
```

Files are parsed at build time via `gray-matter` in `lib/posts.ts` and `lib/songs.ts`. Posts are sorted by date (newest first), songs are sorted alphabetically.

## Deployment Pipeline

Hosted on Vercel with two environments:

| Environment | URL | Branch |
|-------------|-----|--------|
| Staging/Dev | `dev.chicommunitychoir.com` | `main` (auto-deploy on push) |
| Production | `chicommunitychoir.com` | Promoted from dev via Vercel dashboard |

The site uses `@vercel/analytics` and `@vercel/speed-insights` for monitoring.

## Environment Variables

| Variable | Required | Default |
|----------|----------|---------|
| `NEXT_PUBLIC_SITE_URL` | No | `https://chicommunitychoir.com` |

## Design Decisions

- **Filesystem CMS**: Content is plain markdown files. No database means no migrations, no CMS login, and content lives in version control. Non-technical users add content via GitHub's web UI.
- **Two separate client components**: EventsClient and RepertoireClient each implement their own search/filter. They share `useInfiniteScroll` (IntersectionObserver pagination) and `SearchInput`, but the filtering logic differs (events: date-aware search with bucket grouping; songs: simpler text search). Combining them would complicate both.
- **Self-hosted fonts**: Lora (serif headings) and Source Sans 3 (sans-serif body) are served as variable fonts from `public/fonts/`. No external font requests — better privacy and fewer CSP directives.
- **Custom markdown pipeline**: `MarkdownContent` uses `react-markdown` with a custom `remarkFigure` plugin that wraps standalone images in `<figure>` elements and passes size/alignment modifiers via the image title attribute.
