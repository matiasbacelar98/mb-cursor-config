---
name: code-review-and-quality
description: Conducts multi-axis code review. Use before merging any change. Use when reviewing code written by yourself, another agent, or a human.
---

# Code Review and Quality

## Overview

Multi-dimensional code review with quality gates. Every change gets reviewed before merge — no exceptions. Review covers five axes: correctness, readability, architecture, security, and performance.

**The approval standard:** Approve a change when it definitely improves overall code health, even if it isn't perfect.

## The Five-Axis Review

1. **Correctness** — Does the code do what it claims to do?
2. **Readability & Simplicity** — Can another engineer understand this without the author explaining?
3. **Architecture** — Does the change fit the system's design?
4. **Security** — Does the change introduce vulnerabilities?
5. **Performance** — Does the change introduce performance problems?

## Change Sizing

~100 lines changed   → Good
~300 lines changed   → Acceptable if single logical change
~1000 lines changed  → Too large. Split it.

## Review Process

Step 1: Understand the Context
Step 2: Review the Tests First
Step 3: Review the Implementation
Step 4: Categorize Findings (Critical / Nit / Optional / FYI)
Step 5: Verify the Verification

## Multi-Model Review Pattern

Model A writes code → Model B reviews → Model A addresses feedback → Human makes final call

## Dead Code Hygiene

After any refactoring, check for orphaned code. Ask before deleting.

## Review Speed

Respond within one business day. Ideal: shortly after request arrives.

## Handling Disagreements

1. Technical facts and data override opinions
2. Style guides are absolute authority on style
3. Software design evaluated on engineering principles
4. Codebase consistency is acceptable if it doesn't degrade health

## Dependency Discipline

Before adding any dependency: Does the existing stack solve this? How large? Actively maintained? Known vulnerabilities? License compatible?

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "It works, that's good enough" | Working code that's unreadable creates debt. |
| "I wrote it, so I know it's correct" | Authors are blind to their own assumptions. |
| "We'll clean it up later" | Later never comes. |
| "AI-generated code is probably fine" | AI code needs more scrutiny, not less. |
| "The tests pass, so it's good" | Tests don't catch architecture problems or security issues. |

## Verification

- [ ] All Critical issues are resolved
- [ ] All Important issues are resolved or deferred with justification
- [ ] Tests pass
- [ ] Build succeeds
- [ ] Verification story documented
