import { describe, it, expect } from 'vitest';
import { getAllSongs, getAllSongSlugs } from '../songs';

describe('getAllSongs', () => {
  it('returns an array', () => {
    const songs = getAllSongs();
    expect(Array.isArray(songs)).toBe(true);
  });

  it('returns songs with expected shape', () => {
    const songs = getAllSongs();
    for (const song of songs) {
      expect(song).toHaveProperty('slug');
      expect(song).toHaveProperty('title');
      expect(song).toHaveProperty('composer');
    }
  });
});

describe('getAllSongSlugs', () => {
  it('returns slugs matching song count', () => {
    const songs = getAllSongs();
    const slugs = getAllSongSlugs();
    expect(slugs.length).toBe(songs.length);
  });
});
