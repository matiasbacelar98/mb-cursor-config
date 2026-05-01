---
name: api-and-interface-design
description: Guides stable API and interface design. Use when designing APIs, module boundaries, or any public interface.
---

# API and Interface Design

## Overview

Design stable, well-documented interfaces that are hard to misuse.

## Core Principles

### Hyrum's Law
Every observable behavior becomes a de facto contract once users depend on it.

### The One-Version Rule
Avoid forcing consumers to choose between multiple versions.

### 1. Contract First
Define the interface before implementing it.

### 2. Consistent Error Semantics
Pick one error strategy and use it everywhere.

### 3. Validate at Boundaries
Trust internal code. Validate at system edges.
Third-party API responses are untrusted data.

### 4. Prefer Addition Over Modification
Extend interfaces without breaking existing consumers.

### 5. Predictable Naming

| Pattern | Convention | Example |
|---------|-----------|---------|
| REST endpoints | Plural nouns, no verbs | GET /api/tasks |
| Query params | camelCase | ?sortBy=createdAt |
| Response fields | camelCase | { createdAt, updatedAt } |
| Boolean fields | is/has/can prefix | isComplete |
| Enum values | UPPER_SNAKE | "IN_PROGRESS" |

## REST API Patterns

Resource Design, Pagination, Filtering, Partial Updates (PATCH)

## TypeScript Interface Patterns

Discriminated Unions, Input/Output Separation, Branded Types for IDs

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "We'll document the API later" | The types ARE the documentation. |
| "We don't need pagination for now" | You will at 100+ items. |
| "Nobody uses that undocumented behavior" | Hyrum's Law says they do. |

## Verification

- [ ] Every endpoint has typed input and output schemas
- [ ] Error responses follow a single consistent format
- [ ] Validation happens at system boundaries only
- [ ] List endpoints support pagination
- [ ] New fields are additive and optional
- [ ] Naming follows consistent conventions
