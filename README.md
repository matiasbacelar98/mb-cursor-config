# mb-cursor-config

Global configuration for Cursor AI agents.

This repository defines reusable commands and rules that improve consistency, clarity, and developer workflows across projects.

---

## 🧩 Structure

```
.cursor/
  commands/
    global/   # reusable commands (explicit actions you trigger manually)
  rules/
    global/   # agent behavior and writing guidelines (static instructions)
  skills/     # dynamic workflows and playbooks the agent can follow to solve tasks
  hooks/      # optional automation (post-edit, etc.)
```

The `global/` subdirectory holds configuration that applies across all projects. Project-specific commands and rules live at the top level of each project's `.cursor/` directory.

---

## ⚙️ Commands

Commands are explicit actions you trigger manually.

### Available commands

- `/global/commit-name`
  Generate a Conventional Commit message based on staged changes.

- `/global/pr-readme`
  Generate a pull request description from recent commits.

- `/global/write-doc`
  Generate structured project documentation.

- `/global/prompt-rewriting`
  Rewrite a rough idea into a clear, actionable prompt for an LLM or coding agent.

### Usage

```
/global/<command> <input>
```

Example:

```
/global/prompt-rewriting implement OCR fallback for PDFs with broken ligatures
```

---

## 📏 Rules

Rules define how the agent behaves.

### Current rules

- `global/ai-behavior.mdc` (Always Apply)
  Defines global response style (clarity, simplicity, structure).

- `global/language-enforcement.mdc` (Always Apply)
  Keeps agent communication in English unless explicitly asked otherwise.

- `global/documentation-style.mdc` (Apply Intelligently)
  Applies when generating documentation.

- `global/pr-writing.mdc` (Apply Intelligently)
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

This repository is meant to be added to a Cursor workspace alongside your project repositories:

```
workspace/
├─ cursor-config/    # this repo (or a fork of it)
├─ frontend/
└─ backend/
```

The config repo acts as a central place for all Cursor agent configuration in the workspace. It lives in its own repository so it can be versioned, shared, and reused across teams or machines.

### Organizing by scope

Use subdirectories to separate global configuration from project-specific configuration:

```
cursor-config/
  .cursor/
    commands/
      global/       # applies to any project (commit-name, pr-readme, etc.)
      frontend/     # frontend-specific commands
      backend/      # backend-specific commands
    rules/
      global/       # universal agent behavior
      frontend/     # frontend conventions (e.g., component patterns)
      backend/      # backend conventions (e.g., API style)
    skills/
      global/
      frontend/
      backend/
```

This keeps everything in one place while making it easy to scope commands and rules to specific projects.

---

## 🚀 Notes

- Keep rules small and focused to avoid context bloat
- Prefer commands for explicit tasks
- Add skills only when clear patterns emerge
- Iterate based on real usage
