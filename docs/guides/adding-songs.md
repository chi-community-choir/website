# How to Add Songs to the Repertoire

This guide shows you how to add songs to your choir's repertoire with sheet music and audio learning files.

## Overview

Songs appear on the **Repertoire** page of your website. Each song can include:
- Basic information (title, composer, arranger)
- Description and performance notes
- Sheet music downloads (one or multiple files)
- Audio files (full arrangements and individual parts)

**You can add as many or as few resources as you have** - it's completely flexible!

## Step-by-Step Instructions

### Step 1: Prepare Your Files (Optional)

If you have sheet music PDFs or audio files (MP3), upload them to DigitalOcean Spaces first:
- URL: https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/
- Organize in folders: `/sheet-music/` and `/audio/`
- Note the URLs - you'll need them in Step 4

**Don't have files yet?** No problem! You can add the song without resources and add them later.

### Step 2: Go to GitHub

1. Log in to https://github.com
2. Navigate to your repository: `chi-comm-choir`
3. Click on the `content` folder
4. Click on the `songs` folder

### Step 3: Create a New File

1. Click the **"Add file"** button in the top right
2. Select **"Create new file"**

### Step 4: Name Your File

**IMPORTANT**: Your file name becomes the song's URL slug.

**Format:**
```
song-title.md
```

**Examples:**
- ✅ `amazing-grace.md`
- ✅ `seal-lullaby.md`
- ✅ `hallelujah-chorus.md`
- ❌ `Amazing Grace.md` (has spaces, use dashes)
- ❌ `song.md` (not descriptive)

**Rules:**
- Use lowercase letters (recommended)
- Replace spaces with dashes (-)
- Keep it short but descriptive
- End with `.md`
- No dates needed (unlike posts)

### Step 5: Add Content

Copy the template from `docs/templates/song-template.md` and paste it into the editor.

Here's a minimal example to get started:

```markdown
---
title: "Amazing Grace"
composer: "John Newton"
excerpt: "A timeless hymn of redemption and grace"
tags: ["traditional", "hymn", "sacred"]
---

# About This Piece

Write your description here.
```

### Step 6: Customize the Song Details

#### Required Fields:
- `title`: The song's title (in quotes)
- `composer`: The composer's name (in quotes)

#### Optional Fields (delete if not needed):
- `arranger`: The arranger's name (in quotes)
- `excerpt`: Brief description for the listing page (1-2 sentences)
- `tags`: Genre/style categories (see tag suggestions below)
- `sheetMusic`: Array of sheet music files
- `audio`: Array of audio files

### Step 7: Add Resources

#### Adding Sheet Music

You can add one or multiple sheet music files:

**Single file:**
```yaml
sheetMusic:
  - label: "Full Score (SATB)"
    url: "https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/sheet-music/amazing-grace.pdf"
```

**Multiple files:**
```yaml
sheetMusic:
  - label: "Full Score (SATB)"
    url: "https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/sheet-music/amazing-grace-full.pdf"
  - label: "Soprano Part Only"
    url: "https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/sheet-music/amazing-grace-soprano.pdf"
  - label: "Alto Part Only"
    url: "https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/sheet-music/amazing-grace-alto.pdf"
  - label: "Simplified Version"
    url: "https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/sheet-music/amazing-grace-simple.pdf"
```

**Key points:**
- The `label` is what users will see (e.g., "Full Score", "Soprano Part")
- The `url` is the full link to the PDF file
- Maintain the exact indentation (2 spaces for `-`, 4 spaces for `label` and `url`)

#### Adding Audio Files

You can add one or multiple audio files:

**Basic example:**
```yaml
audio:
  - label: "Full Arrangement"
    url: "https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/audio/amazing-grace-full.mp3"
  - label: "Soprano Part"
    url: "https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/audio/amazing-grace-soprano.mp3"
  - label: "Alto Part"
    url: "https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/audio/amazing-grace-alto.mp3"
  - label: "Tenor Part"
    url: "https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/audio/amazing-grace-tenor.mp3"
  - label: "Bass Part"
    url: "https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/audio/amazing-grace-bass.mp3"
```

**Advanced example with practice tracks:**
```yaml
audio:
  - label: "Full Arrangement (Studio Recording)"
    url: "https://example.com/full-studio.mp3"
  - label: "Full Arrangement (Live Performance)"
    url: "https://example.com/full-live.mp3"
  - label: "Soprano Part (Slow Practice - 60 bpm)"
    url: "https://example.com/soprano-slow.mp3"
  - label: "Soprano Part (Performance Tempo)"
    url: "https://example.com/soprano-full.mp3"
  - label: "Alto Part"
    url: "https://example.com/alto.mp3"
```

**Key points:**
- You can have as many audio files as you need
- Label them clearly (e.g., "Slow Practice", "Performance Tempo")
- Audio files should be MP3 format for best compatibility

### Step 8: Add Description Content

Below the `---` section, add information about the piece:

```markdown
# About This Piece

Write details about the song here. Include:
- Historical background
- Information about the composer
- Why you chose this piece
- Character and style notes

## Performance Notes

Tips for choir members:
- Suggested tempo (e.g., ♩ = 80-92)
- Difficult passages to watch for
- Interpretation guidance
- Dynamic markings

## Lyrics

Include lyrics if helpful for reference.
```

Use markdown formatting (headings, bullet points, bold, italic) as needed.

### Step 9: Save Your Song

1. Scroll to the bottom of the page
2. In the "Commit new file" box:
   - Add a message like: "Add Amazing Grace to repertoire"
3. Make sure "Commit directly to the main branch" is selected
4. Click the green **"Commit new file"** button

### Step 10: Wait for Deployment

- The website will automatically update in **2-3 minutes**
- Visit the Repertoire page to see your new song
- Click on the song to view its detail page

## Complete Example

Here's a complete song file as reference:

```markdown
---
title: "The Seal Lullaby"
composer: "Eric Whitacre"
excerpt: "A beautiful, gentle lullaby with rich harmonies"
tags: ["contemporary", "lullaby", "a cappella"]
sheetMusic:
  - label: "Full Score (SATB)"
    url: "https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/sheet-music/seal-lullaby.pdf"
audio:
  - label: "Full Arrangement"
    url: "https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/audio/seal-lullaby-full.mp3"
  - label: "Soprano Part"
    url: "https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/audio/seal-lullaby-soprano.mp3"
  - label: "Alto Part"
    url: "https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/audio/seal-lullaby-alto.mp3"
  - label: "Tenor Part"
    url: "https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/audio/seal-lullaby-tenor.mp3"
  - label: "Bass Part"
    url: "https://chicommunitychoir.lon1.cdn.digitaloceanspaces.com/audio/seal-lullaby-bass.mp3"
---

# About This Piece

"The Seal Lullaby" was commissioned for the animated film *Kung Fu Panda* but ultimately went unused. Despite this, it has become one of Eric Whitacre's most beloved choral works.

## Performance Notes

- **Tempo**: ♩ = 60-66
- **Character**: Gentle and flowing
- Focus on smooth, connected phrasing (legato)
- Balance between parts to highlight the melody
```

## Common Tags

Use tags to categorize your songs:

**Style:**
- `classical`, `contemporary`, `folk`, `jazz`, `gospel`, `pop`, `rock`

**Era:**
- `renaissance`, `baroque`, `romantic`, `modern`

**Type:**
- `sacred`, `secular`, `a cappella`, `lullaby`, `carol`, `madrigal`, `hymn`

**Season/Event:**
- `christmas`, `easter`, `wedding`, `memorial`

**Language:**
- `english`, `latin`, `french`, `german`, `italian`

Example:
```yaml
tags: ["classical", "sacred", "christmas", "latin"]
```

## Editing Existing Songs

To update a song:

1. Go to GitHub → `content` → `songs`
2. Click on the file you want to edit
3. Click the pencil icon (✏️) in the top right
4. Make your changes
5. Scroll down and click "Commit changes"

Common edits:
- Adding new audio files or sheet music
- Updating descriptions
- Fixing typos
- Adding performance notes

## Removing Resources

To remove sheet music or audio files, simply delete those lines:

**Before:**
```yaml
audio:
  - label: "Old File"
    url: "https://example.com/old.mp3"
  - label: "Keep This One"
    url: "https://example.com/keep.mp3"
```

**After:**
```yaml
audio:
  - label: "Keep This One"
    url: "https://example.com/keep.mp3"
```

## Troubleshooting

### "My song isn't showing up"
- Wait 2-5 minutes for deployment
- Check that file is in `content/songs/` folder
- Verify file ends with `.md`
- Check for syntax errors (quotes, dashes, indentation)

### "Resources aren't displaying"
- Verify URLs are correct and complete (start with `https://`)
- Check indentation (use exactly 2 or 4 spaces, not tabs)
- Make sure the `label:` and `url:` are properly aligned
- Ensure each entry starts with `  - label:` (2 spaces, dash, space)

### "Formatting looks wrong"
- Check that you have the `---` lines at top and bottom of metadata section
- Verify all quotes are matched (every opening quote has closing quote)
- Check indentation in sheetMusic and audio sections
- Use spaces, not tabs

### "Audio player not working"
- Make sure audio files are MP3 format
- Verify URLs are publicly accessible
- Check that URL ends with `.mp3`

## Tips for Success

1. **Start simple**: Add just title and composer first, then add resources later
2. **Test URLs**: Click on your file URLs to make sure they work before adding them
3. **Consistent naming**: Use clear, consistent labels (e.g., always "Soprano Part" not sometimes "Sop" or "S")
4. **Copy existing songs**: Look at the example songs to see how they're structured
5. **Maintain indentation**: The spacing matters! Copy from the template to get it right

## YAML Indentation Reference

This is the trickiest part. Here's the exact spacing:

```yaml
sheetMusic:          ← No spaces before
  - label: "Text"    ← 2 spaces before dash
    url: "https..."  ← 4 spaces before url
  - label: "Text"    ← 2 spaces before dash
    url: "https..."  ← 4 spaces before url
```

**Pro tip**: Copy and paste an existing section, then just change the text and URLs.

## Need Help?

- **Full Template**: See `docs/templates/song-template.md`
- **Example Songs**: Look in `content/songs/` for complete examples
- **YAML Guide**: https://yaml.org/spec/1.2.2/#chapter-2-language-overview
- **Contact Developer**: [Your contact info]

---

*Last updated: 2026-01-11*
