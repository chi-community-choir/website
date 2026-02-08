# Using Images in Markdown

A quick reference guide for adding images to choir website content.

## Image Sizes

Control how large your image appears by adding a size word in quotes after the image URL:

| Syntax | Result | Best For |
|--------|--------|----------|
| `![Photo](url "small")` | 300px wide | Portraits, headshots, thumbnails |
| `![Photo](url "medium")` | 500px wide | General photos, default size |
| `![Photo](url "large")` | 900px wide | Landscapes, group photos |
| `![Photo](url "full")` | Full width | Hero images, dramatic impact |

## Image Alignment

Control where your image appears on the page:

| Syntax | Result |
|--------|--------|
| `![Photo](url "left")` | Aligns to left side of page |
| `![Photo](url "center")` | Centers the image (default) |
| `![Photo](url "right")` | Aligns to right side of page |

## Combining Size and Alignment

You can combine both size and alignment (order doesn't matter):

```markdown
![Choir Director](photo.jpg "small left")
![Concert Hall](venue.jpg "large center")
![Group Photo](ensemble.jpg "full right")
```

## Examples

### Small portrait, left aligned
```markdown
![Our Director](director-photo.jpg "small left")
```
*Result: A 300px wide portrait positioned on the left side*

### Large landscape, centered
```markdown
![The Minerva Theatre](venue.jpg "large center")
```
*Result: A 900px wide photo centered on the page*

### Full-width hero image
```markdown
![Summer Concert 2024](concert.jpg "full")
```
*Result: Image spans the full width of the content area*

## Tips

- **Always include descriptive alt text** for accessibility (e.g., `![Choir performing](photo.jpg)`)
- Use quotes around the size/alignment words
- Images default to medium size and centered if you don't specify anything
- The size words are designed to be guessable - use plain English!
- If you specify multiple sizes, the last one wins (e.g., `"small large"` = large)

## Default Behavior

If you don't include any title attribute:
```markdown
![Photo](url)
```
The image will be **medium size (700px)** and **centered**.

## Need Help?

If you're unsure which size to use:
- **Small**: Individual people, headshots
- **Medium**: Groups of 2-4 people, general photos
- **Large**: Groups of 5+ people, landscapes, venues
- **Full**: Special occasions, header images, dramatic effect
