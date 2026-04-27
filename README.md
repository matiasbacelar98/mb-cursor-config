# mb-cursor-config

Cursor AI agent configuration: commands, rules, and skills that enforce consistent workflows across projects.

---

## Usage

Add this repo to your Cursor workspace alongside your project repositories:

```
workspace/
├─ mb-cursor-config/   # this repo
├─ frontend/
└─ backend/
```

Cursor merges `.cursor/` configuration from all repos in the workspace. This means rules, commands, and skills defined here are combined with any `.cursor/` configuration each project repo has of its own.

> **Keep this in mind when adding always-apply rules or large skills.** Everything marked `alwaysApply: true` here will load in every conversation across every project in the workspace — including projects that may not need it. Prefer Apply Intelligently rules and on-demand skills wherever possible.

---

## Structure

```
.cursor/
  commands/   # explicit actions triggered manually via /command
  rules/      # agent behavior constraints (always-on or context-triggered)
  skills/     # detailed playbooks the agent loads on demand
```

---

## Commands

| Command | Description |
|---------|-------------|
| `/approve` | Approve the pending commit group — agent executes all commits in the group |
| `/create-pr` | Generate a PR description and open the PR on GitHub |
| `/pr-review` | Fetch a GitHub PR and run a structured code review |

### `/create-pr` usage

```
/create-pr branch:'feature/my-plan'
/create-pr branch:'feature/my-plan' base:'develop'
/create-pr branch:'feature/my-plan' title:'Add user authentication'
/create-pr branch:'feature/my-plan' base:'develop' title:'Add user authentication'
```

### `/pr-review` usage

```
/pr-review https://github.com/owner/repo/pull/123
```

---

## Rules

### Always Apply

These rules are loaded in every conversation regardless of context.

| Rule | Description | Est. tokens |
|------|-------------|-------------|
| `commit-approval.mdc` | Require `/approve` before executing any logical commit group | ~171 |
| `feature-branch.mdc` | Never commit to main/master — always work on a feature branch | ~129 |
| `engagement-preferences.mdc` | How the agent should engage: confirm intentions, ask before assuming, prefer multiple choice | ~112 |
| `commit-style.mdc` | Conventional commits format, max 72 chars first line | ~79 |
| **Total** | | **~491 tokens** |

### Apply Intelligently

These rules are loaded only when the agent determines they are relevant.

| Rule | Trigger | Est. tokens |
|------|---------|-------------|
| `accessibility.mdc` | Creating, editing, or reviewing UI components, forms, or interactive elements | ~251 |
| `testing.mdc` | Writing, editing, or reviewing tests | ~199 |
| `documentation-style.mdc` | Generating or updating documentation | ~129 |

---

## Skills

Skills are detailed playbooks loaded on demand. They are never loaded unless the agent determines the context matches.

| Skill | Trigger | Est. tokens |
|-------|---------|-------------|
| `incremental-implementation` | Actively implementing a task touching more than one file | ~2,384 |
| `planning-and-task-breakdown` | Breaking work into implementable tasks from a spec or requirement | ~2,198 |
| `code-review-and-quality` | Reviewing code — PR, agent output, or conversational request | ~675 |
| `security-and-hardening` | Handling user input, auth, data storage, or external integrations in JS/web projects | ~553 |
| `frontend-ui-engineering` | Building or reviewing frontend UI components | ~539 |
| `api-and-interface-design` | Designing or reviewing APIs and interfaces | ~496 |
| `performance-optimization` | Performance requirements or suspected regressions in JS/web projects | ~433 |
| `debugging-and-error-recovery` | Investigating bugs, errors, or unexpected behavior | ~403 |

---

## Token Budget

The following estimates use Sonnet 4.6 (200,000 token context window) as a reference point.

| Category | Tokens | % of context |
|----------|--------|--------------|
| Always-apply rules | ~491 | 0.25% |
| Apply Intelligently rules (if all triggered) | ~579 | 0.29% |
| Skills (worst case: planning + incremental loaded together) | ~4,582 | 2.29% |
| **Max realistic overhead** | **~5,652** | **~2.83%** |

Rules are never a concern. Even with the two largest skills loaded simultaneously, overhead stays under 3% of the context window.

---

## Workflow

See [WORKFLOW.md](WORKFLOW.md) for the full implementation workflow: planning, implementing with human-in-the-loop commit approval, testing, security/performance review, and shipping.

---

## Design Philosophy

- **Commands** → explicit actions you trigger
- **Rules** → behavioral constraints on the agent
- **Skills** → detailed execution playbooks

Goals: reduce prompt repetition, improve consistency, keep context minimal.
