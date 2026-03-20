---
name: gitee-checkout-pr
description: Fetch a Gitee pull request by number into a local branch and switch to it from the current git repository. Use when Codex is asked to "checkout PR 448", "switch to a Gitee PR", "pull a PR locally", or fetch a Gitee pull ref without hardcoding the repository URL.
---

# Gitee Checkout PR

## Overview

Use this skill to fetch a pull request from the current repository's Gitee remote and switch to a local branch. The bundled script detects the remote from the active git repository, so do not hardcode a repo URL.

## Quick Start

Run the bundled script from the target repository or any subdirectory inside it:

```bash
scripts/gitee_checkout_pr.sh <pr-number> [branch-name]
```

Examples:

```bash
scripts/gitee_checkout_pr.sh 448
scripts/gitee_checkout_pr.sh 448 fix-pr-448
```

Default local branch name: `pr_<pr-number>`

## Remote Detection

The script chooses a Gitee remote in this order:

1. The current branch's upstream remote, if it points to Gitee
2. `origin`, if it points to Gitee
3. The only remote whose URL points to Gitee

If multiple Gitee remotes exist, set `GITEE_REMOTE=<remote-name>` before running the script.

## Workflow

The script:

- Validates that the current directory is inside a git work tree
- Resolves the correct Gitee remote from the repository configuration
- Runs `git fetch <remote> pull/<pr>/head`
- Runs `git switch -C <branch> FETCH_HEAD`

Use `git switch -C` intentionally so rerunning the script refreshes an existing local PR branch instead of leaving stale commits behind.

## Failure Modes

- If no Gitee remote exists, stop and tell the user to add one or set `GITEE_REMOTE`.
- If multiple Gitee remotes exist, stop and tell the user to choose one with `GITEE_REMOTE`.
- If `git fetch` fails, surface the git error directly; do not guess at credentials or permissions.
- If `git switch -C` fails because of local changes, report that state and let the user decide how to resolve it.

## Resources

### scripts/

- `scripts/gitee_checkout_pr.sh`: Fetch and switch to a Gitee PR from the current repository.
