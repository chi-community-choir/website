# How to Add a Blog Post or News Article

This guide shows you how to add news, announcements, and event updates to your website.

## Overview

Blog posts appear on the **Events** page of your website. They're perfect for:
- Concert announcements
- Rehearsal updates
- Social event information
- General news and updates

## Step-by-Step Instructions

### Step 1: Go to GitHub
1. Log in to https://github.com
2. Navigate to your repository: `chi-comm-choir`
3. Click on the `content` folder
4. Click on the `posts` folder

### Step 2: Create a New File
1. Click the **"Add file"** button in the top right
2. Select **"Create new file"**

### Step 3: Name Your File

**IMPORTANT**: Your file name must follow this exact format:

```
YYYY-MM-DD-title-with-dashes.md
```

**Examples:**
- ✅ `2026-01-15-spring-concert-announcement.md`
- ✅ `2026-03-20-new-rehearsal-schedule.md`
- ✅ `2026-05-01-summer-social-event.md`
- ❌ `spring concert.md` (missing date, has spaces)
- ❌ `2026-1-15-concert.md` (month needs two digits: 01 not 1)

**Rules:**
- Always start with the date in YYYY-MM-DD format
- Use dashes (-) instead of spaces
- End with `.md`
- Use lowercase letters (recommended)

### Step 4: Add Content

Click inside the file editor and paste the template. You can find the template in one of two places:

**Option A**: Copy from `docs/templates/post-template.md` in this repository

**Option B**: Copy this template:

```markdown
---
title: "Your Post Title Here"
date: "2026-01-15"
excerpt: "A short description that appears on the events page (1-2 sentences)"
author: "Your Name"
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

### Step 5: Customize the Content

Replace the placeholder text:

**In the Top Section (between the --- lines):**
- `title`: The headline that appears at the top of your post
- `date`: The post date (use YYYY-MM-DD format)
- `excerpt`: A short preview shown on the Events page
- `author`: Your name or "Chichester Community Choir"
- `tags`: Categories for your post (see tag suggestions below)

**In the Main Content:**
- Write your article using the markdown formatting shown
- Add headings, bullet points, links, etc.

### Step 6: Save Your Post

1. Scroll to the bottom of the page
2. In the "Commit new file" box:
   - Add a brief message like: "Add spring concert announcement"
3. Make sure "Commit directly to the main branch" is selected
4. Click the green **"Commit new file"** button

### Step 7: Wait for Deployment

- Your website will automatically update in **2-3 minutes**
- Visit your Events page to see the new post
- If it doesn't appear after 5 minutes, see the Troubleshooting section

## Markdown Formatting Guide

Here are the most useful formatting options:

### Headings
```markdown
# Large Heading
## Medium Heading
### Small Heading
```

### Text Styling
```markdown
**Bold text**
*Italic text*
***Bold and italic***
```

### Lists
```markdown
- Bullet point
- Another bullet point
  - Indented bullet (use 2 spaces)

1. Numbered list
2. Second item
3. Third item
```

### Links
```markdown
[Link text here](https://example.com)
```

### Images
```markdown
![Image description](https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/your-image.jpg)
```

## Common Tags

Choose tags that best describe your post:

**Event Types:**
- `concert` - Performance events
- `rehearsal` - Rehearsal information
- `social` - Social gatherings
- `workshop` - Educational events

**Content Types:**
- `news` - General news and updates
- `announcement` - Important announcements
- `event` - Upcoming events
- `review` - Post-event reviews

**Special:**
- `christmas` - Holiday related
- `summer` - Summer events
- `fundraising` - Fundraising activities

You can use multiple tags:
```markdown
tags: ["concert", "christmas", "announcement"]
```

## Editing Existing Posts

To edit a post you've already published:

1. Go to GitHub → `content` → `posts`
2. Click on the file you want to edit
3. Click the pencil icon (✏️) in the top right
4. Make your changes
5. Scroll down and click "Commit changes"

The website will automatically update in 2-3 minutes.

## Troubleshooting

### "My post isn't showing up"
- **Wait longer**: Deployment takes 2-5 minutes
- **Check file name**: Must be `YYYY-MM-DD-title.md` format
- **Check location**: File must be in `content/posts/` folder
- **Check the date**: Posts with future dates will still appear (sorted by date)

### "The formatting looks wrong"
- Check that you have the `---` lines at the top and after the metadata
- Make sure all quotes are matched (every opening quote has a closing quote)
- Verify the date format is YYYY-MM-DD in quotes

### "I see an error message"
- Read the error - GitHub usually tells you what's wrong
- Common issues:
  - Missing closing quote
  - Missing dash in the `---` section
  - Typo in a field name (should be: title, date, excerpt, author, tags)

## Tips

- **Preview before committing**: Scroll down to see a preview of how your post will look
- **Keep backups**: GitHub automatically saves all versions, so you can always go back
- **Start simple**: Begin with basic text and add formatting gradually
- **Copy existing posts**: Look at other posts in the folder to see examples

## Need Help?

- **Markdown Guide**: https://www.markdownguide.org/basic-syntax/
- **GitHub Help**: https://docs.github.com/en
- **Contact Developer**: [Your contact info]

---

*Last updated: 2026-01-11*
