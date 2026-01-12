Short version: **it’s annoyingly non-zero effort, but not hard**. You’re like 80% of the way there already.

Given your setup (Next.js, TS, MD files, client-side filtering, “load more”), this is basically a **state orchestration problem**, not an infra one.

---

## Mental model (important)

Stop thinking in terms of *pages*.
Think in terms of a **monotonic list with a moving window**.

You already have:

* all posts loaded
* a client-side slice (`visibleCount`)
* a “load more” affordance

Infinite scroll + vertical time list just adds:

1. **automatic increments** of `visibleCount`
2. **derived time breakpoints** inside the rendered list

No re-architecture required.

---

## Step 1: Replace “load more” with an observer (easy)

Use an `IntersectionObserver` on a sentinel div.

Conceptually:

* Keep `visibleCount`
* When sentinel enters viewport → `visibleCount += N`

This is literally your button, but triggered by scrolling instead of clicking.

If this part feels scary: it’s not. It’s boilerplate plus 10 lines of glue.

---

## Step 2: Compute time buckets once (important, cheap)

When you load markdown metadata, also compute:

* `year`
* `month`
* maybe a coarse bucket label (`"This month"`, `"2024"`, etc.)

Do **not** recompute this during render. Pre-derive.

You now have something like:

```ts
{
  title,
  date,
  year,
  month,
  bucket
}
```

This is crucial because it lets the UI stay dumb.

---

## Step 3: Inject headers while rendering (this is the “hard” part)

When rendering the visible slice:

* Track the last-seen bucket
* When the bucket changes → render a **header row** before the post

Pseudocode vibe:

```
for post in visiblePosts:
  if post.bucket !== lastBucket:
    render BucketHeader
    lastBucket = post.bucket
  render Post
```

This feels hacky but is correct and stable.
React is fine with this. The DOM will not combust.

---

## Step 4: Make the headers pull double duty (UX win)

Those bucket headers should be:

* visually distinct
* sticky-ish (optional but hot)
* clickable

Clicking a header:

* sets `visibleCount` to include all posts *up to that bucket*
* scrolls to that anchor

No filtering. No rerendering universe. Just widening the window.

This is what makes it feel *intentional* instead of “scroll soup”.

---

## Difficulty assessment (honest)

For a competent dev:

* IntersectionObserver: **15–30 min**
* Bucket derivation: **10 min**
* Header injection logic: **30–45 min**
* Polishing scroll + click behavior: **the time sink** (1–2h)

So: **half a day**, not a rewrite.

---

## Why this works unusually well for your setup

* Static content → no race conditions
* Client-side list → no cursor hell
* Markdown → metadata is cheap
* Hybrid pagination → already the right abstraction

You’re not fighting React, Next, or the browser here.
You’re just changing *when* you increase the slice and *how* you annotate it.

---

## One caution (learned the hard way)

**Do not virtualize prematurely**.

Unless you have thousands of posts:

* virtualization will break header logic
* it complicates scroll anchoring
* you will regret it

Infinite scroll ≠ virtualization. People conflate them. Don’t.

---

## Bottom line

This is one of those features that *sounds fancy* but is mechanically dull. The complexity is 90% conceptual and 10% code.

