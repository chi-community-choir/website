'use client';

import { useCallback, useEffect, useRef, useState } from 'react';

interface UseInfiniteScrollOptions {
  itemsPerPage: number;
  threshold?: number;
  rootMargin?: string;
}

export function useInfiniteScroll<T>(items: T[], options: UseInfiniteScrollOptions) {
  const { itemsPerPage, threshold = 0.1, rootMargin = '100px' } = options;
  const sentinelRef = useRef<HTMLDivElement>(null);
  const [visibleCount, setVisibleCount] = useState(itemsPerPage);

  useEffect(() => {
    setVisibleCount(itemsPerPage);
  }, [items, itemsPerPage]);

  useEffect(() => {
    const sentinel = sentinelRef.current;
    if (!sentinel) return;

    const observer = new IntersectionObserver(
      ([entry]) => {
        if (entry.isIntersecting) {
          setVisibleCount((prev) => Math.min(prev + itemsPerPage, items.length));
        }
      },
      { rootMargin, threshold },
    );

    observer.observe(sentinel);
    return () => observer.disconnect();
  }, [items.length, itemsPerPage, rootMargin, threshold]);

  const loadMore = useCallback(() => {
    setVisibleCount((prev) => Math.min(prev + itemsPerPage, items.length));
  }, [itemsPerPage, items.length]);

  const displayed = items.slice(0, visibleCount);
  const hasMore = visibleCount < items.length;

  return { displayed, hasMore, loadMore, sentinelRef, setVisibleCount };
}
