---
name: performance-optimization
description: Optimizes application performance in JavaScript/web projects. Use when performance requirements exist or you suspect regressions in a JS/web project.
---

# Performance Optimization

## Overview

Measure before optimizing. Profile first, identify the bottleneck, fix it, measure again.

## Core Web Vitals Targets

| Metric | Good | Needs Improvement | Poor |
|--------|------|-------------------|------|
| LCP | ≤ 2.5s | ≤ 4.0s | > 4.0s |
| INP | ≤ 200ms | ≤ 500ms | > 500ms |
| CLS | ≤ 0.1 | ≤ 0.25 | > 0.25 |

## The Optimization Workflow

1. MEASURE → Establish baseline
2. IDENTIFY → Find the actual bottleneck
3. FIX → Address the specific bottleneck
4. VERIFY → Measure again
5. GUARD → Add monitoring

## Fix Common Anti-Patterns

- N+1 Queries (use joins/includes)
- Unbounded Data Fetching (paginate)
- Missing Image Optimization
- Unnecessary Re-renders (React.memo, useMemo, stable references)
- Large Bundle Size (tree-shaking, dynamic imports)
- Missing Caching

## Performance Budget

JavaScript bundle: < 200KB gzipped
CSS: < 50KB gzipped
API response time: < 200ms (p95)
Time to Interactive: < 3.5s on 4G
Lighthouse Performance: ≥ 90

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "We'll optimize later" | Performance debt compounds. |
| "It's fast on my machine" | Profile on representative hardware. |
| "This optimization is obvious" | If you didn't measure, you don't know. |

## Verification

- [ ] Before and after measurements exist
- [ ] Specific bottleneck identified and addressed
- [ ] Core Web Vitals within "Good" thresholds
- [ ] Bundle size hasn't increased significantly
- [ ] No N+1 queries in new code
