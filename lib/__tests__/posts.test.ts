import { describe, it, expect } from 'vitest';
import { deriveTimeBucket } from '../posts';

describe('deriveTimeBucket', () => {
  it('parses valid ISO date string', () => {
    const result = deriveTimeBucket('2026-01-15');
    expect(result.year).toBe('2026');
    expect(result.month).toBe('January 2026');
    expect(result.bucket).toBe('01/2026');
  });

  it('returns Unknown bucket for empty date', () => {
    const result = deriveTimeBucket('');
    expect(result.bucket).toBe('Unknown');
    expect(result.year).toBe('');
    expect(result.month).toBe('');
  });

  it('zero-pads single-digit months', () => {
    const result = deriveTimeBucket('2025-12-01');
    expect(result.bucket).toBe('12/2025');
  });
});
