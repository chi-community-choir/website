# Website Handoff Guide for Chichester Community Choir

This document explains how to manage your website after handoff. No technical knowledge required!

## 📖 Quick Navigation

**Most Common Tasks:**
- [How to Add a Blog Post/News Article](#-how-to-add-a-blog-postnews-article)
- [How to Add Songs to Repertoire](#-how-to-add-songs-to-repertoire)
- [How to Edit Existing Content](#-how-to-edit-existing-content)

**Detailed Guides:**
- **Adding Posts**: See `docs/guides/adding-posts.md` for detailed instructions
- **Adding Songs**: See `docs/guides/adding-songs.md` for detailed instructions
- **Templates**: Find ready-to-use templates in `docs/templates/`

## 🔑 Account Access

You'll need access to these accounts (credentials will be provided separately):

### 1. GitHub Account
- **Website**: https://github.com
- **Purpose**: Store website code and content
- **What you'll use it for**: Adding/editing blog posts, news, and repertoire

### 2. Vercel Account
- **Website**: https://vercel.com
- **Purpose**: Hosts and deploys the website
- **What you'll use it for**: Rarely - it auto-deploys when you update GitHub

### 3. Cloudflare Account
- **Website**: https://cloudflare.com
- **Purpose**: Manages your domain name (chicommunitychoir.com)
- **What you'll use it for**: Very rarely - only if changing domain settings

### 4. DigitalOcean Spaces (Optional)
- **Website**: https://cloud.digitalocean.com
- **Purpose**: Store files (sheet music PDFs, audio files, images)
- **What you'll use it for**: Uploading resources for songs and posts

## 📝 How to Add a Blog Post/News Article

Blog posts appear on the **Events** page.

### Quick Steps:

1. Go to GitHub → `chi-comm-choir` → `content` → `posts`
2. Click **"Add file"** → **"Create new file"**
3. Name your file: `YYYY-MM-DD-title.md` (e.g., `2026-01-15-spring-concert.md`)
4. Copy the template from `docs/templates/post-template.md`
5. Fill in your content
6. Scroll down and click **"Commit new file"**
7. Wait 2-3 minutes for your post to appear

### Need More Help?
📘 **Full detailed guide**: `docs/guides/adding-posts.md`

## 🎵 How to Add Songs to Repertoire

Songs appear on the **Repertoire** page with optional sheet music and audio files.

### Quick Steps:

1. Go to GitHub → `chi-comm-choir` → `content` → `songs`
2. Click **"Add file"** → **"Create new file"**
3. Name your file: `song-title.md` (e.g., `amazing-grace.md`)
4. Copy the template from `docs/templates/song-template.md`
5. Fill in song details:
   - Basic info: title, composer, arranger (optional)
   - Resources: sheet music URLs, audio file URLs (all optional)
   - Description and notes
6. Scroll down and click **"Commit new file"**
7. Wait 2-3 minutes for your song to appear

### Resource Flexibility

**You can add:**
- ✅ Zero resources (just song info)
- ✅ One sheet music file
- ✅ Multiple sheet music files (full score, parts, different editions)
- ✅ One or many audio files (full arrangement, SATB parts, practice tracks)
- ✅ Any combination of the above

**The system is completely flexible!** Add what you have, leave out what you don't.

### Need More Help?
📘 **Full detailed guide**: `docs/guides/adding-songs.md`

## 🖼️ How to Add Images and Files

### For Images in Blog Posts:
Upload to DigitalOcean Spaces, then reference in markdown:
```markdown
![Image description](https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/your-image.jpg)
```

### For Sheet Music and Audio:
1. Upload PDF and MP3 files to DigitalOcean Spaces
2. Organize in folders: `/sheet-music/` and `/audio/`
3. Copy the full URL
4. Add to your song's frontmatter (see song template)

## ✏️ How to Edit Existing Content

### Edit a Blog Post:
1. Go to GitHub → `content` → `posts`
2. Click on the file you want to edit
3. Click the pencil icon (✏️) in the top right
4. Make your changes
5. Scroll down and click "Commit changes"

### Edit a Song:
1. Go to GitHub → `content` → `songs`
2. Click on the file you want to edit
3. Click the pencil icon (✏️)
4. Make your changes (add resources, update description, etc.)
5. Scroll down and click "Commit changes"

### Edit Page Content (About, Membership, etc.):
1. Go to GitHub → `app` folder
2. Find the page folder (e.g., `about`, `membership`)
3. Click on `page.tsx`
4. Click the pencil icon
5. Edit the text (be careful with code syntax)
6. Commit changes

**Note**: Editing `.tsx` files is more technical. For major changes, contact your web developer.

## 🚨 Common Issues & Solutions

### "My post/song isn't showing up"
- ✅ Wait 3-5 minutes - deployment takes time
- ✅ Check file name format:
  - Posts: `YYYY-MM-DD-title.md`
  - Songs: `song-title.md`
- ✅ Check file location:
  - Posts: `content/posts/`
  - Songs: `content/songs/`

### "The website is down"
1. Check https://vercel.com - log in and check dashboard
2. Look for any red error messages
3. If you see errors, contact your developer

### "Audio/sheet music isn't showing"
- ✅ Verify URLs are complete and correct
- ✅ Make sure files are publicly accessible
- ✅ Check indentation in the YAML (see template)
- ✅ Audio files should be MP3, sheet music should be PDF

### "I made a mistake"
- ✅ No problem! Just edit the file again
- ✅ All previous versions are saved in GitHub history
- ✅ You can always revert changes if needed

## 📧 Contact for Technical Help

**Website Developer**: [Your contact info here]
**Emergency Only**: For critical issues (site completely down)

## 🔐 Security Best Practices

1. **Never share login credentials publicly**
2. **Use a password manager** (like 1Password or LastPass)
3. **Enable two-factor authentication** on GitHub and Vercel
4. **Change passwords** if you suspect compromise

## 📚 Documentation Files

All documentation is organized in the `docs/` folder:

### Templates (Ready to Copy & Paste)
- `docs/templates/post-template.md` - Blog post template
- `docs/templates/song-template.md` - Repertoire song template

### Guides (Detailed Instructions)
- `docs/guides/adding-posts.md` - Complete guide for blog posts
- `docs/guides/adding-songs.md` - Complete guide for repertoire

### This File
- `HANDOFF.md` - Quick reference and overview (you are here)

## 📚 External Resources

- **Live Website**: https://chicommunitychoir.com
- **GitHub Repository**: https://github.com/[username]/chi-comm-choir
- **Vercel Dashboard**: https://vercel.com/dashboard
- **Markdown Guide**: https://www.markdownguide.org/basic-syntax/
- **YAML Syntax**: https://yaml.org/spec/1.2.2/

## 💡 Tips for Non-Technical Users

- **Don't be afraid to experiment** - you can't break anything permanently
- **Use the templates** - copy from `docs/templates/` to get started quickly
- **Preview before committing** - GitHub shows how markdown will look
- **Start simple** - add basic info first, add resources later
- **Look at examples** - check existing posts/songs to see how they're structured
- **Ask for help** - your developer is here to support you!

## 🎯 Quick Reference

| Task | Location | Template | Guide |
|------|----------|----------|-------|
| Add blog post | `content/posts/` | `docs/templates/post-template.md` | `docs/guides/adding-posts.md` |
| Add song | `content/songs/` | `docs/templates/song-template.md` | `docs/guides/adding-songs.md` |
| Edit post | `content/posts/` | N/A | Click pencil icon |
| Edit song | `content/songs/` | N/A | Click pencil icon |
| Upload files | DigitalOcean Spaces | N/A | Use web interface |

---

*Last updated: 2026-01-11*
