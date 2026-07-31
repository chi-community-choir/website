import fs from 'fs';
import path from 'path';
import matter from 'gray-matter';

const POSTS_DIR = path.join(process.cwd(), 'content', 'posts');
const SONGS_DIR = path.join(process.cwd(), 'content', 'songs');

/**
 * @param {string} file
 * @param {string} field
 * @param {string} message
 */
function error(file, field, message) {
  return { file, field, message };
}

function validatePosts() {
  const errors = [];
  if (!fs.existsSync(POSTS_DIR)) return errors;

  const files = fs.readdirSync(POSTS_DIR).filter((f) => f.endsWith('.md'));
  for (const file of files) {
    const fullPath = path.join(POSTS_DIR, file);
    try {
      const raw = fs.readFileSync(fullPath, 'utf8');
      const { data } = matter(raw);

      if (!data.title) errors.push(error(file, 'title', 'Missing required field: title'));
      if (!data.date) {
        errors.push(error(file, 'date', 'Missing required field: date'));
      } else if (isNaN(new Date(data.date).getTime())) {
        errors.push(error(file, 'date', `Invalid date: "${data.date}"`));
      }
      if (!data.excerpt) errors.push(error(file, 'excerpt', 'Missing required field: excerpt'));
      if (!data.author) errors.push(error(file, 'author', 'Missing required field: author'));
      if (!Array.isArray(data.tags)) errors.push(error(file, 'tags', 'tags must be an array'));
    } catch (err) {
      errors.push(error(file, '(parse)', `YAML parse error: ${err instanceof Error ? err.message : String(err)}`));
    }
  }
  return errors;
}

function validateSongs() {
  const errors = [];
  if (!fs.existsSync(SONGS_DIR)) return errors;

  const files = fs.readdirSync(SONGS_DIR).filter((f) => f.endsWith('.md'));
  for (const file of files) {
    const fullPath = path.join(SONGS_DIR, file);
    try {
      const raw = fs.readFileSync(fullPath, 'utf8');
      const { data } = matter(raw);

      if (!data.title) errors.push(error(file, 'title', 'Missing required field: title'));
      if (!data.composer) errors.push(error(file, 'composer', 'Missing required field: composer'));
      if (!data.excerpt) errors.push(error(file, 'excerpt', 'Missing required field: excerpt'));

      if (data.sheetMusic) {
        if (!Array.isArray(data.sheetMusic)) {
          errors.push(error(file, 'sheetMusic', 'sheetMusic must be an array'));
        } else {
          data.sheetMusic.forEach((sm, i) => {
            if (sm && typeof sm === 'object') {
              if (!sm.label && !sm.title) {
                errors.push(error(file, `sheetMusic[${i}]`, 'Missing label/title for sheet music resource'));
              }
              if (!sm.url) {
                errors.push(error(file, `sheetMusic[${i}].url`, 'Missing url for sheet music resource'));
              }
            }
          });
        }
      }

      if (data.audio) {
        if (!Array.isArray(data.audio)) {
          errors.push(error(file, 'audio', 'audio must be an array'));
        } else {
          data.audio.forEach((a, i) => {
            if (a && typeof a === 'object') {
              if (!a.label && !a.title) {
                errors.push(error(file, `audio[${i}]`, 'Missing label/title for audio resource'));
              }
              if (!a.url) {
                errors.push(error(file, `audio[${i}].url`, 'Missing url for audio resource'));
              }
            }
          });
        }
      }
    } catch (err) {
      errors.push(error(file, '(parse)', `YAML parse error: ${err instanceof Error ? err.message : String(err)}`));
    }
  }
  return errors;
}

const errors = [...validatePosts(), ...validateSongs()];

if (errors.length > 0) {
  console.error(`\nFound ${errors.length} content validation error(s):\n`);
  for (const err of errors) {
    console.error(`  ${err.file}`);
    console.error(`    ${err.field}: ${err.message}\n`);
  }
  process.exit(1);
}

console.log('All content files validated successfully.');
