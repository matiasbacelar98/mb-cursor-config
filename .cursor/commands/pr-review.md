Review the GitHub PR at {{input}}.

## Step 1: Check prerequisites

Run `gh --version`. If the command fails or is not found, stop and output:

> **Error:** GitHub CLI (`gh`) is not installed or not available in PATH.
> Install it from https://cli.github.com and authenticate with `gh auth login`.

## Step 2: Fetch the PR

Run the following commands using the PR URL:

```
gh pr view {{input}} --json title,body,author,baseRefName,headRefName,additions,deletions,changedFiles,files
gh pr diff {{input}}
```

If either command fails (e.g. invalid URL, no access, not authenticated), stop and display the error message from `gh`.

## Step 3: Review the PR

Using the fetched metadata and diff, apply the code-review-and-quality skill to conduct a full review.

Structure the output as:

### PR Summary
- Title, author, base → head branch
- Files changed, additions, deletions

### Review

For each finding use this format:

- 🔴 **Critical** — must fix before merge
- 🟡 **Important** — should fix, or defer with justification
- 🔵 **Nit** — minor, non-blocking
- ⚪ **FYI** — informational, no action required

### Verdict

One of:
- ✅ **Approve** — ready to merge
- 🔄 **Request Changes** — critical or important issues found
- 💬 **Comment** — feedback only, no blocking issues
