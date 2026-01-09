# Chichester Community Choir Website

A modern, easy-to-maintain website for the Chichester Community Choir built with Next.js.

## 🌐 Live Site

- **Production**: https://chicommunitychoir.com
- **Preview**: https://chi-comm-choir.vercel.app

## 📝 Adding Content (Non-Technical)

**See [HANDOFF.md](./HANDOFF.md) for detailed instructions on managing content.**

### Quick: Add a Blog Post

1. Go to `content/posts/` folder on GitHub
2. Click "Add file" → "Create new file"
3. Name it: `YYYY-MM-DD-title.md` (e.g., `2026-01-15-concert.md`)
4. Paste this template:

```markdown
---
title: "Your Post Title"
date: "2026-01-15"
excerpt: "Brief description for the events page"
author: "Caroline"
tags: ["concert", "news"]
---

Your post content here in markdown...
```

5. Click "Commit new file"
6. Wait 2-3 minutes - your post appears on the website!

## 🛠️ Technical Documentation

### Tech Stack

- **Framework**: Next.js 15 (App Router)
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **Hosting**: Vercel (auto-deploys from main branch)
- **CMS**: Markdown files in `/content/posts/`

### Local Development

```bash
# Install dependencies
bun install

# Run dev server
bun run dev

# Build for production
bun run build

# Type check
bunx tsc --noEmit

# Lint
bun run lint
```

### Project Structure

```
chi-comm-choir/
├── app/                    # Next.js pages
│   ├── page.tsx           # Homepage
│   ├── about/             # About page
│   ├── events/            # Events listing & posts
│   ├── find-us/           # Location page
│   ├── membership/        # Membership page
│   └── repertoire/        # Repertoire page
├── components/            # Reusable components
│   ├── Navbar.tsx
│   ├── Footer.tsx
│   ├── HeroSection.tsx
│   ├── InfoBox.tsx
│   └── PostCard.tsx
├── content/               # Markdown content
│   ├── posts/            # Blog posts/news
│   └── songs/            # Repertoire (optional)
├── lib/                   # Utility functions
│   └── posts.ts          # Markdown parsing
├── public/                # Static assets
├── HANDOFF.md            # Non-technical user guide
└── DEPLOYMENT.md         # Deployment instructions
```

### Adding New Pages

1. Create folder in `app/` (e.g., `app/gallery/`)
2. Add `page.tsx`:

```typescript
export const metadata = {
  title: 'Gallery | Chichester Community Choir',
}

export default function GalleryPage() {
  return <div>Your page content</div>
}
```

3. Add link to `components/Navbar.tsx`

### Environment Variables

None required! This is a static site.

## 🚀 Deployment

**Automatic deployment** is set up:
- Push to `main` branch → Vercel auto-deploys
- See [DEPLOYMENT.md](./DEPLOYMENT.md) for full setup

### Manual Deploy

```bash
# Build static export
bun run build

# Test the build locally
cd out && python3 -m http.server 8000
```

## 🎨 Design System

### Colors (Tailwind Config)

- `choir-blue-dark`: #1a365d
- `choir-blue`: #2c5282
- `choir-blue-light`: #2a4365

### Typography

- Headings: System font stack (optimized)
- Body: 18-20px base size
- Line height: 1.6-1.8 for readability

## 📦 Content Management

### Markdown Frontmatter

```yaml
---
title: "Post Title"
date: "YYYY-MM-DD"
excerpt: "Brief description"
author: "Author Name"
tags: ["tag1", "tag2"]
---
```

### Images

Store in DigitalOcean Spaces:
- CDN URL: `https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/`
- Use in markdown: `![Alt text](CDN_URL/image.jpg)`

## 🐛 Troubleshooting

### Build Fails
```bash
# Clear cache and rebuild
rm -rf .next node_modules
bun install
bun run build
```

### Type Errors
```bash
# Run type check
bunx tsc --noEmit
```

### Deployment Issues
- Check Vercel dashboard: https://vercel.com/dashboard
- View build logs for errors
- Rollback to previous deployment if needed

## 📞 Support

**For choir members**: See [HANDOFF.md](./HANDOFF.md)

**For developers**:
- Original implementation: Gleam monorepo (archived)
- Rewrite date: January 2026
- Maintainer: [Contact info]

## 📄 License

Private repository for Chichester Community Choir.

---

Built with ❤️ using Next.js and TypeScript
