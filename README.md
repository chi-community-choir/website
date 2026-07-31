# Chichester Community Choir Website

Website for the Chichester Community Choir (West Sussex, UK). Public-facing site with events, repertoire, membership info, and about pages.

## Tech Stack

- **Framework:** Next.js 16 (App Router)
- **Language:** TypeScript (strict mode)
- **Styling:** Tailwind CSS 3.4 with custom choir theme
- **Content:** Markdown files in `content/` (filesystem CMS, no database)
- **Hosting:** Vercel — `main` branch deploys to `dev.chicommunitychoir.com`, production is `chicommunitychoir.com` (promoted from dev)
- **Asset Storage:** Vercel Blob Storage

## Prerequisites

- **Node.js** >= 20 (see `.nvmrc`)
- **npm** >= 10

## Getting Started

```bash
# Clone the repository
git clone <repo-url> && cd chi-comm-choir

# Install dependencies
npm ci

# Start the dev server
npm run dev
# -> http://localhost:3000
```

## Scripts

| Command | Description |
|---------|-------------|
| `npm run dev` | Start development server |
| `npm run build` | Production build (includes type-checking, SSG via generateStaticParams) |
| `npm run start` | Serve production build |
| `npm run lint` | Run ESLint |
| `npx tsc --noEmit` | Type-check only (no emit) |

## Architecture

### Rendering
- **Static pages:** `/`, `/about`, `/find-us`, `/membership` are server-rendered with no client interactivity
- **Hybrid pages:** `/events` and `/repertoire` use server components (`page.tsx`) to fetch markdown content from `content/`, then pass serialized data to co-located client components (`*Client.tsx`) for search, filtering, and infinite scroll
- **Dynamic routes:** `generateStaticParams()` pre-builds all `/events/[slug]` and `/repertoire/[slug]` pages at build time

### Data Flow
```
content/posts/*.md  ->  lib/posts.ts  ->  app/events/page.tsx  ->  app/events/EventsClient.tsx  ->  components/PostCard
content/posts/*.md  ->  lib/posts.ts  ->  app/events/[slug]/page.tsx  ->  components/MarkdownContent
content/songs/*.md  ->  lib/songs.ts  ->  app/repertoire/page.tsx  ->  app/repertoire/RepertoireClient.tsx  ->  components/SongCard
content/songs/*.md  ->  lib/songs.ts  ->  app/repertoire/[slug]/page.tsx  ->  components/MarkdownContent
```

### Component Layout
- **Shared components** in `components/`: Navbar, Footer, PostCard, SongCard, MarkdownContent, SearchInput, etc.
- **Page-specific client components** co-located in `app/`: `EventsClient.tsx`, `RepertoireClient.tsx`

## Deployment

Hosted on Vercel with two environments:

| Environment | URL | Branch |
|-------------|-----|--------|
| Staging/Dev | `dev.chicommunitychoir.com` | `main` (auto-deploy on push) |
| Production | `chicommunitychoir.com` | Promoted from dev via Vercel dashboard |

The site uses:
- `@vercel/analytics` for traffic analytics
- `@vercel/speed-insights` for performance monitoring

## Content Authoring

Content is stored as Markdown files with YAML frontmatter in `content/posts/` and `content/songs/`. Non-technical users add content via GitHub's web UI — no local development required. See `docs/README.md` for step-by-step guides and templates.

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `NEXT_PUBLIC_SITE_URL` | No | `https://chicommunitychoir.com` | Base URL for metadata and OG tags |

See `.env.example` for the complete template.
