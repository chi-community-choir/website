#!/bin/bash

# Generate dummy event posts for testing pagination
echo "Generating dummy event posts..."

authors=("Caroline" "John" "Sarah" "Michael" "Emma")
tags=("concert" "rehearsal" "social" "fundraiser" "workshop" "news")

for i in {1..25}; do
  # Generate dates spanning several months
  month=$((1 + i % 12))
  day=$((1 + i % 28))
  date=$(printf "2025-%02d-%02d" $month $day)

  # Pick random author and tags
  author=${authors[$((i % ${#authors[@]}))]}
  tag1=${tags[$((i % ${#tags[@]}))]}
  tag2=${tags[$(((i + 1) % ${#tags[@]}))]}

  # Create filename
  filename="content/posts/${date}-test-event-${i}.md"

  # Generate content
  cat > "$filename" << EOF
---
title: "Test Event ${i}: ${tag1^} Edition"
date: "${date}"
excerpt: "This is test event number ${i} for pagination testing. It features ${tag1} and ${tag2} activities."
author: "${author}"
tags: ["${tag1}", "${tag2}"]
---

# Test Event ${i}

This is a dummy event post generated for testing pagination functionality.

## Event Details

- **Event Number**: ${i}
- **Category**: ${tag1^}
- **Organized by**: ${author}
- **Date**: ${date}

## Description

This event is part of our test suite to verify that pagination works correctly across multiple pages. The content here is deliberately varied to simulate real-world scenarios.

### What to Expect

- Various activities related to ${tag1}
- Community engagement
- Fun and music
- Refreshments provided

## Additional Information

For more information about this test event, please contact ${author} at the choir office.

### Important Notes

This is test content and should be removed before production deployment.
EOF

  echo "Created: $filename"
done

# Generate dummy songs for testing pagination
echo -e "\nGenerating dummy song entries..."

composers=("Mozart" "Beethoven" "Handel" "Bach" "Whitacre" "Lauridsen" "Rutter" "Jenkins")
song_tags=("classical" "contemporary" "baroque" "romantic" "a cappella" "accompanied" "sacred" "secular")
keys=("C Major" "D Major" "E♭ Major" "F Major" "G Major" "A Minor" "B♭ Major")

for i in {1..30}; do
  # Pick random attributes
  composer=${composers[$((i % ${#composers[@]}))]}
  tag1=${song_tags[$((i % ${#song_tags[@]}))]}
  tag2=${song_tags[$(((i + 2) % ${#song_tags[@]}))]}
  key=${keys[$((i % ${#keys[@]}))]}

  # Create filename (slug format)
  slug="test-song-${i}"
  filename="content/songs/${slug}.md"

  # Generate content
  cat > "$filename" << EOF
---
title: "Test Song ${i}"
composer: "${composer}"
excerpt: "A test piece in ${key} for pagination testing. Features ${tag1} and ${tag2} characteristics."
tags: ["${tag1}", "${tag2}", "test"]
sheetMusic:
  - label: "Full Score (SATB)"
    url: "https://example.com/sheet-music/${slug}-full.pdf"
  - label: "Vocal Score"
    url: "https://example.com/sheet-music/${slug}-vocal.pdf"
audio:
  - label: "Full Arrangement"
    url: "https://example.com/audio/${slug}-full.mp3"
  - label: "Soprano Part"
    url: "https://example.com/audio/${slug}-soprano.mp3"
  - label: "Alto Part"
    url: "https://example.com/audio/${slug}-alto.mp3"
  - label: "Tenor Part"
    url: "https://example.com/audio/${slug}-tenor.mp3"
  - label: "Bass Part"
    url: "https://example.com/audio/${slug}-bass.mp3"
---

# About This Piece

"Test Song ${i}" is a ${tag1} piece composed by ${composer} for testing pagination functionality. This is dummy content.

## Musical Details

- **Key**: ${key}
- **Style**: ${tag1^}
- **Period**: ${tag2^}
- **Difficulty**: Medium
- **Voicing**: SATB

## Performance Notes

This test song features:
- Systematic variation in content
- Multiple resource links
- Varied frontmatter for testing
- Realistic structure for pagination testing

### Technical Requirements

- Suitable for mixed choir
- Range: Standard SATB
- Duration: Approximately 3-4 minutes
- Accompaniment: A cappella or with piano

## Historical Context

This piece was generated as test data on $(date +%Y-%m-%d) for the purpose of verifying pagination functionality in the Chichester Community Choir website.

**Note**: This is test content and should be removed before production deployment.
EOF

  echo "Created: $filename"
done

echo -e "\nTest data generation complete!"
echo "Generated 25 event posts and 30 songs"
echo "Remember to commit these to a test branch only!"
