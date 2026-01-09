# Chichester Community Choir Website Rewrite Plan

Rewrite the existing Gleam monorepo site into a **modern JavaScript static-site generator** that enables non-technical choir members to update content independently.

---

## Goals

1. **Low maintenance** - Minimal server requirements, easy deployment
2. **Content-editable by non-devs** - Blog posts, events, news updates should be manageable via markdown files or a headless CMS
3. **Modern, responsive design** - Preserve/improve the existing aesthetics
4. **Future-proof** - TypeScript + popular framework for developer handoff ease

---

## Recommended Stack

| Layer | Technology | Rationale |
|-------|-----------|-----------|
| Framework | **Next.js 14 (App Router)** | Most popular React framework, great docs, huge community, supports SSG + ISR |
| Styling | **Tailwind CSS** | Rapid styling, works great with modern design patterns |
| CMS | **Markdown files in repo** (Phase 1) → **Decap CMS** or **Sanity** (Phase 2) | Start simple, add CMS later if choir needs GUI editing |
| Database | **None** (content in markdown) | Eliminates server costs and maintenance |
| Auth | **Remove for public site** / Add **NextAuth** if admin CMS needed | Current auth is for protected routes; static site removes need |
| Hosting | **Vercel** or **Netlify** | Free tier, automatic deploys from GitHub, built-in CDN |

> [!TIP]
> For the simplest possible solution, use markdown files with frontmatter stored in `/content/` directories. The choir leader can learn to edit markdown files in GitHub's web interface.

---

## Current Feature Mapping

| Existing Route | Content Type | Rewrite Strategy |
|----------------|--------------|------------------|
| `/` (Index) | Static hero, info boxes | Static page with Next.js, CTA buttons |
| `/about` | Directors, choir info, rehearsal info | Static page, images from CDN |
| `/events` | Blog posts (CRUD via admin) | Markdown files in `/content/posts/`, rendered with gray-matter + MDX |
| `/events/[slug]` | Individual post | Dynamic route `[slug]/page.tsx` |
| `/find-us` | Location, embedded map | Static page with Google Maps embed |
| `/membership` | Info about joining | Static page |
| `/repertoire` | Song list (members-only) | **Simplify**: Public listing, or password-protected page |
| `/repertoire/[slug]` | Song detail with link | Optional: keep as markdown if needed |
| `/admin` | Login, create/delete posts | **Replace with CMS or GitHub-based workflow** |

---

## Proposed Directory Structure

```
website/
├── app/                      # Next.js App Router pages
│   ├── layout.tsx            # Root layout with navbar/footer
│   ├── page.tsx              # Homepage
│   ├── about/page.tsx
│   ├── events/
│   │   ├── page.tsx          # Events listing
│   │   └── [slug]/page.tsx   # Individual event/post
│   ├── find-us/page.tsx
│   ├── membership/page.tsx
│   └── repertoire/
│       ├── page.tsx
│       └── [slug]/page.tsx   # Optional song detail
├── components/               # Reusable React components
│   ├── Navbar.tsx
│   ├── Footer.tsx
│   ├── PostCard.tsx
│   ├── HeroSection.tsx
│   └── InfoBox.tsx
├── content/                  # Markdown content (editable by choir)
│   ├── posts/                # Blog posts / events
│   │   ├── 2024-summer-concert.md
│   │   └── 2024-christmas-carols.md
│   └── songs/                # Repertoire (optional)
│       └── hallelujah.md
├── lib/                      # Utility functions
│   ├── posts.ts              # Parse and fetch markdown posts
│   └── songs.ts              # Parse and fetch songs
├── public/                   # Static assets
│   └── images/
├── styles/
│   └── globals.css           # Tailwind config
├── tailwind.config.ts
├── next.config.ts
├── package.json
└── CLAUDE.md                 # Instructions for Claude agent
```

---

## Content Format (Markdown with Frontmatter)

### Posts/Events (`content/posts/yyyy-event-name.md`)

```markdown
---
title: "Summer Concert 2024"
date: "2024-07-20"
excerpt: "Join us for our annual summer concert at Chichester Cathedral"
author: "Caroline"
tags: ["concert", "summer"]
---

Full event description in markdown...
```

### Songs (`content/songs/song-name.md`)

```markdown
---
title: "Hallelujah"
href: "https://example.com/sheet-music.pdf"
tags: ["classic", "leonard-cohen"]
---

Optional notes about the song...
```

---

## Implementation Phases

### Phase 1: Core Rewrite (MVP)

1. **Initialize Next.js 14 project** with TypeScript, Tailwind CSS
2. **Create base layout** - Navbar with links, footer
3. **Port static pages** - About, Find Us, Membership (direct HTML → JSX conversion)
4. **Implement homepage** - Hero banner, info boxes, CTAs
5. **Build events system** - Parse markdown, list posts, individual post pages
6. **Deploy to Vercel** - Connect GitHub repo, automatic deploys

### Phase 2: Content Management

7. **Document content editing** - README for choir leader on editing markdown
8. **Add Decap CMS (optional)** - Git-based CMS with WYSIWYG editor
9. **Protected repertoire (if needed)** - Simple password gate or member login

### Phase 3: Polish

10. **SEO optimization** - Meta tags, Open Graph, sitemap
11. **Performance** - Image optimization, lazy loading
12. **Analytics** - Add Plausible or Google Analytics

---

## Data Migration

### Posts
Export existing posts from SQLite database to markdown files:

```sql
SELECT title, content, excerpt, author, slug, created_at, updated_at
FROM posts;
```

Convert each row to a markdown file with frontmatter.

### Songs
Export songs similarly:

```sql
SELECT title, slug, href, created_at FROM songs;
```

---

## What Gets Removed

| Feature | Reason |
|---------|--------|
| Gleam codebase | Replaced entirely |
| SQLite database | Content moves to markdown files |
| Session-based auth | No longer needed for static site |
| Erlang/BEAM server | Replaced with static hosting |
| SSR hydration | Next.js handles this natively |

---

## Handoff Considerations

For the choir leader to update content:

1. **Simple path**: Edit markdown files directly on GitHub (web interface)
2. **Better path**: Install Decap CMS - provides WYSIWYG editor in browser
3. **Training needed**: ~30 min tutorial on adding/editing markdown files

---

## Verification Plan

### Automated Testing

```bash
# Run build to verify no errors
bun run build

# Run linter
bun run lint

# Run type check
bunx tsc --noEmit
```

### Manual Testing

1. **Homepage**: Verify banner image loads, info boxes display, all links work
2. **Events page**: Confirm posts list renders, search works, individual posts load
3. **Static pages**: Check About, Find Us, Membership render correctly
4. **Mobile responsiveness**: Test on mobile viewport sizes
5. **Deploy preview**: Verify Vercel preview deployments work

### User Acceptance

- Have choir leader review site design
- Verify they can edit a markdown file and see changes

---

## Risks & Mitigations

| Risk | Mitigation |
|------|-----------|
| Choir leader struggles with markdown | Add Decap CMS or create detailed tutorials |
| Images need to be uploaded | Use DigitalOcean Spaces (already in use) or Cloudinary |
| Need private member area | Add simple password protection or NextAuth with magic links |

---

## Estimated Effort

| Phase | Time Estimate |
|-------|--------------|
| Phase 1 (Core) | 1-2 days |
| Phase 2 (CMS) | 0.5-1 day |
| Phase 3 (Polish) | 0.5-1 day |
| **Total** | **2-4 days** |

---

## Next Steps

1. ✅ Analyze existing codebase (complete)
2. ✅ Create CLAUDE.md with instructions for implementing dev (complete)
3. ✅ User approval of this plan (approved)
4. ⏳ Initialize Next.js project and begin Phase 1

## Finalized Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Repertoire section | Keep as **public listing** | Removes auth complexity, simplifies site |
| CMS approach | **Markdown in GitHub** (Phase 1), optional Decap CMS later | Start simple, add GUI if choir needs it |
| Hosting | **Vercel** | Free tier, automatic deploys, excellent Next.js support |
