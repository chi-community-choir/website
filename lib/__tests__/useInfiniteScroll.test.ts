import { describe, it, expect } from 'vitest';
import { renderHook, act } from '@testing-library/react';
import { useInfiniteScroll } from '../useInfiniteScroll';

describe('useInfiniteScroll', () => {
  it('shows first page of items initially', () => {
    const items = Array.from({ length: 50 }, (_, i) => i);
    const { result } = renderHook(() =>
      useInfiniteScroll(items, { itemsPerPage: 10 })
    );
    expect(result.current.displayed).toHaveLength(10);
    expect(result.current.hasMore).toBe(true);
  });

  it('loadMore advances to next page', () => {
    const items = Array.from({ length: 50 }, (_, i) => i);
    const { result } = renderHook(() =>
      useInfiniteScroll(items, { itemsPerPage: 10 })
    );
    act(() => result.current.loadMore());
    expect(result.current.displayed).toHaveLength(20);
    expect(result.current.hasMore).toBe(true);
  });

  it('hasMore is false when all items displayed', () => {
    const items = [1, 2, 3];
    const { result } = renderHook(() =>
      useInfiniteScroll(items, { itemsPerPage: 10 })
    );
    expect(result.current.displayed).toHaveLength(3);
    expect(result.current.hasMore).toBe(false);
  });

  it('resets when items change', () => {
    const items1 = Array.from({ length: 30 }, (_, i) => i);
    const { result, rerender } = renderHook(
      ({ items }) => useInfiniteScroll(items, { itemsPerPage: 10 }),
      { initialProps: { items: items1 } },
    );
    act(() => result.current.loadMore());
    expect(result.current.displayed).toHaveLength(20);

    const items2 = Array.from({ length: 5 }, (_, i) => i + 100);
    rerender({ items: items2 });
    expect(result.current.displayed).toHaveLength(5);
  });

  it('handles empty array', () => {
    const { result } = renderHook(() =>
      useInfiniteScroll<number>([], { itemsPerPage: 10 })
    );
    expect(result.current.displayed).toHaveLength(0);
    expect(result.current.hasMore).toBe(false);
  });

  it('returns sentinelRef', () => {
    const items = [1, 2, 3];
    const { result } = renderHook(() =>
      useInfiniteScroll(items, { itemsPerPage: 10 })
    );
    expect(result.current.sentinelRef).toBeDefined();
    expect(result.current.sentinelRef.current).toBeNull();
  });
});
