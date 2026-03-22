# mb-cursor-config

Global configuration for Cursor AI agents.

This repository defines reusable commands and rules that improve consistency, clarity, and developer workflows across projects.

---

## 🧩 Structure

```
.cursor/
  commands/   # reusable commands (explicit actions you trigger manually)
  rules/      # agent behavior and writing guidelines (static instructions)
  skills/     # dynamic workflows and playbooks the agent can follow to solve tasks
  hooks/      # optional automation (post-edit, etc.)
```

---

## ⚙️ Commands

Commands are explicit actions you trigger manually.

### Available commands

- `/commit-name`
  Generate a Conventional Commit message based on staged changes.

- `/pr-readme`
  Generate a pull request description from recent changes.

- `/write-doc`
  Generate structured project documentation.

- `/rewrite-prompt`
  Rewrite a rough idea into a clear prompt for an LLM or coding agent.

### Usage

```
/command <input>
```

Example:

```
/rewrite-prompt implement OCR fallback for PDFs with broken ligatures
```

---

## 📏 Rules

Rules define how the agent behaves.

### Current rules

- `ai-behavior.mdc` (Always Apply)
  Defines global response style (clarity, simplicity, structure).

- `documentation-style.mdc` (Apply Intelligently)
  Applies when generating documentation.

- `pr-writing.mdc` (Apply Intelligently)
  Applies when generating PR descriptions.

### Rule types

- **Always Apply** → always active
- **Apply Intelligently** → activated based on context
- **Manual** → used only when explicitly referenced

---

## 🧠 Design Philosophy

This setup follows a simple separation:

- **Commands** → trigger actions
- **Rules** → define behavior
- **(Future) Skills** → define workflows

Goal:

- reduce prompt repetition
- improve output consistency
- keep context clean and minimal

---

## 🧪 Usage in a Workspace

This repository is meant to be used alongside project repositories:

```
workspace/
├─ mb-cursor-config/
├─ frontend/
└─ backend/
```

Each project can define its own:

```
project/
  .cursor/
    rules/
    skills/
    commands/
  docs/
```

---

## 🚀 Notes

- Keep rules small and focused to avoid context bloat
- Prefer commands for explicit tasks
- Add skills only when clear patterns emerge
- Iterate based on real usage
