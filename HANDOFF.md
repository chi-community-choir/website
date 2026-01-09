# Website Handoff Guide for Chichester Community Choir

This document explains how to manage your website after handoff. No technical knowledge required!

## 🔑 Account Access

You'll need access to these accounts (credentials will be provided separately):

### 1. GitHub Account
- **Website**: https://github.com
- **Purpose**: Store website code and content
- **What you'll use it for**: Adding/editing blog posts and news

### 2. Vercel Account
- **Website**: https://vercel.com
- **Purpose**: Hosts and deploys the website
- **What you'll use it for**: Rarely - it auto-deploys when you update GitHub

### 3. Cloudflare Account
- **Website**: https://cloudflare.com
- **Purpose**: Manages your domain name (chicommunitychoir.com)
- **What you'll use it for**: Very rarely - only if changing domain settings

## 📝 How to Add a Blog Post/News Article

This is the most common task you'll do. Here's how:

### Step 1: Go to GitHub
1. Log in to https://github.com
2. Navigate to your repository: `chi-comm-choir`
3. Click on the `content` folder
4. Click on the `posts` folder

### Step 2: Create a New File
1. Click the **"Add file"** button
2. Select **"Create new file"**

### Step 3: Name Your File
Use this format: `YYYY-MM-DD-title-with-dashes.md`

Example: `2026-01-15-spring-concert-announcement.md`

### Step 4: Add Content

Copy and paste this template:

```markdown
---
title: "Your Post Title Here"
date: "2026-01-15"
excerpt: "A short description that appears on the events page (1-2 sentences)"
author: "Caroline"
tags: ["concert", "news"]
---

# Your Main Heading

Write your post content here. You can use:

- Bullet points like this
- Multiple bullet points

## Subheadings

Regular paragraphs of text.

**Bold text** and *italic text*

[Links like this](https://example.com)
```

### Step 5: Save (Commit)
1. Scroll to the bottom
2. In "Commit new file" box, write a brief message like "Add spring concert post"
3. Click **"Commit new file"**

### Step 6: Wait 2-3 Minutes
Your website will automatically update! Check the Events page to see your new post.

## 🖼️ How to Add Images

Images should be stored in your DigitalOcean Spaces (already set up):
- URL: https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/

To use an image in a post:
```markdown
![Image description](https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/your-image-name.jpg)
```

## ✏️ How to Edit Existing Content

### Edit a Blog Post:
1. Go to GitHub → `content` → `posts`
2. Click on the file you want to edit
3. Click the pencil icon (Edit)
4. Make your changes
5. Scroll down and click "Commit changes"

### Edit Page Content (About, Membership, etc.):
1. Go to GitHub → `app` folder
2. Find the page folder (e.g., `about`, `membership`)
3. Click on `page.tsx`
4. Click the pencil icon
5. Edit the text between quotes and tags
6. Commit changes

**Note**: Editing `.tsx` files is a bit more technical. For major changes, contact your web developer.

## 🚨 Common Issues & Solutions

### "My post isn't showing up"
- Wait 3-5 minutes - deployment takes time
- Check your file name follows the format: `YYYY-MM-DD-title.md`
- Make sure the file is in `content/posts/` folder

### "The website is down"
1. Check https://vercel.com - log in and check dashboard
2. Look for any red error messages
3. If you see errors, contact: [Developer Contact]

### "I made a mistake in a post"
- No problem! Just edit the file again and commit the changes
- Previous versions are saved in GitHub history

## 📧 Contact for Technical Help

**Website Developer**: [Your contact info here]
**Emergency Only**: For critical issues (site completely down)

## 🔐 Security Best Practices

1. **Never share login credentials publicly**
2. **Use a password manager** (like 1Password or LastPass)
3. **Enable two-factor authentication** on GitHub and Vercel
4. **Change passwords** if you suspect compromise

## 📚 Useful Links

- **Live Website**: https://chicommunitychoir.com
- **GitHub Repository**: https://github.com/[username]/chi-comm-choir
- **Vercel Dashboard**: https://vercel.com/dashboard
- **Markdown Guide**: https://www.markdownguide.org/basic-syntax/

## 💡 Tips for Non-Technical Users

- **Don't be afraid to experiment** - you can't break anything permanently
- **Preview before committing** - GitHub shows how it will look
- **Start with small edits** - practice on test posts first
- **Ask for help** - the developer community is friendly!

---

*Last updated: 2026-01-09*
