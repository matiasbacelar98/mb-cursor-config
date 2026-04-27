Generate a PR description and create the PR on GitHub.

## Input format

`{{input}}` supports these tokens (order doesn't matter):
- `branch:'feature/my-plan'` — the feature branch (required)
- `base:'<name>'` — base branch (optional, defaults to `main`)
- `title:'My PR title'` — PR title (optional, auto-generated if omitted)

Examples:
- `branch:'feature/my-plan'`
- `branch:'feature/my-plan' base:'develop'`
- `branch:'feature/my-plan' title:'Add user authentication'`
- `branch:'feature/my-plan' base:'develop' title:'Add user authentication'`

## Step 1: Check prerequisites

Run `gh --version`. If it fails or is not found, stop and output:
> **Error:** GitHub CLI (`gh`) is not installed or not available in PATH.
> Install it from https://cli.github.com and authenticate with `gh auth login`.

## Step 2: Check if branch is on the remote — push if not

```
git ls-remote --heads origin <branch>
```

If no output is returned, the branch is not on the remote yet. Push it:

```
git push -u origin <branch>
```

If the push fails, stop and output the git error verbatim.

## Step 3: Fetch the commits and diff

```
git log <base>..<branch> --oneline
git diff <base>..<branch>
```

If the log is empty, stop and output:
> **Error:** No commits found between `<base>` and `<branch>`. Is the base branch correct?

## Step 4: Generate the PR description

Using the commits and diff, produce:

---

# <title>

## Summary

One paragraph describing what this PR does and why.

## What changed

Bullet list of the meaningful changes, grouped logically.

## How to test

Step-by-step instructions to verify the change works.

## Risks

Any side effects, edge cases, or areas that need extra review attention. If none, write "None identified."

## Checklist

- [ ] Tests added or updated
- [ ] No unrelated changes included
- [ ] Ready for review

---

If no `title` param was provided, generate a short, descriptive title from the commits (max 72 characters, no generic wording like "update" or "fix stuff").

## Step 5: Create the PR

Show the generated title and description to the user, then run:
```
gh pr create \
  --base <base> \
  --head <branch> \
  --title "<title>" \
  --body "<description>"
```

After success, output the PR URL returned by `gh`.

Rules:
- Keep the description concise
- Group related changes
- Avoid generic wording like "updated code" or "made improvements"
- Focus on developer-facing explanation
