# Workflow

This document describes the end-to-end development workflow enforced by the agent configuration in this repository.

![Workflow diagram](https://github.com/user-attachments/assets/0ec6d243-2c33-424d-a3cf-192ec7fd410d)

---

## Phase 1: Build the Plan

The agent uses the `planning-and-task-breakdown` skill to produce a structured plan before any code is written.

Each task in the plan includes:

- Description and acceptance criteria
- Verification steps
- Dependencies on other tasks
- Files likely touched
- Estimated scope (S/M/L)
- **Expected commits** — number and brief breakdown of what each commit will contain

The plan always ends with two fixed final phases (Testing Checklist and Security/Performance Review).

The agent operates in read-only mode during planning. No code is written until the plan is approved.

**You review and approve the plan before implementation begins.**

---

## Phase 2: Implement

The agent follows the `incremental-implementation` skill to execute each task in small, verifiable slices.

### Per task

Each task is broken into one or more **logical commit groups**. A commit group is a coherent set of changes that belong together — it may touch multiple repos if the change is cross-cutting.

For each commit group:

1. Agent implements the changes
2. Agent runs tests and verifies the build passes
3. Agent presents a summary of all changes in the group (across all repos) and the planned commit message for each repo
4. **You review the changes**
5. You run `/approve` to signal approval
6. Agent executes all commits in the group

The `commit-approval` rule enforces this pause unconditionally — the agent will never commit without `/approve`.

### Across tasks

The agent works through tasks sequentially, following the dependency order defined in the plan. Checkpoints are built into the plan at the end of each phase.

---

## Phase 3: Testing Checklist

After all tasks are complete and all commits are approved, the agent produces a **manual testing checklist** covering everything implemented:

- Every feature and behaviour added
- How to test each item manually
- Edge cases and error scenarios to verify

**You run the tests yourself.** Once complete, you confirm to the agent that testing is done.

---

## Phase 4: Security and Performance Review

After testing is confirmed, the agent reviews the **full changeset** across all tasks:

- Security review using the `security-and-hardening` skill (JS/web projects)
- Performance review using the `performance-optimization` skill (JS/web projects)

The agent surfaces findings categorized by severity. Critical findings must be resolved before proceeding.

This phase reviews the complete diff — not per task — giving the agent the full picture to spot patterns that per-commit reviews would miss.

---

## Phase 5: Ship

Once findings are resolved, create the PRs:

```
/create-pr branch:'feature/my-plan'
```

Run once per repo. The command auto-pushes the branch if not already on the remote, generates the PR description from the branch commits, and opens the PR on GitHub.

---

## Rules enforced throughout

| Rule                     | What it enforces                                                        |
| ------------------------ | ----------------------------------------------------------------------- |
| `feature-branch`         | Always work on a feature branch — never commit to main/master           |
| `commit-approval`        | Never commit without `/approve` — one approval per logical commit group |
| `commit-style`           | Conventional commits format on every commit                             |
| `engagement-preferences` | Agent confirms intent, asks before assuming, waits for approval         |

---

## Skills used per phase

| Phase                    | Skill loaded                                    |
| ------------------------ | ----------------------------------------------- |
| Plan                     | `planning-and-task-breakdown`                   |
| Implement                | `incremental-implementation`                    |
| Implement (if UI)        | `frontend-ui-engineering`, `accessibility` rule |
| Implement (if API)       | `api-and-interface-design`                      |
| Implement (if tests)     | `testing` rule                                  |
| Implement (if debugging) | `debugging-and-error-recovery`                  |
| Code review              | `code-review-and-quality`                       |
| Security review          | `security-and-hardening`                        |
| Performance review       | `performance-optimization`                      |
