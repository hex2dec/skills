# Gitee Review-Mode Auto PR Rules

Source: https://help.gitee.com/enterprise/code-manage/%E4%BB%A3%E7%A0%81%E8%AF%84%E5%AE%A1/Change%20Request/%E4%BF%9D%E6%8A%A4%E5%88%86%E6%94%AF-%E8%AF%84%E5%AE%A1%E6%A8%A1%E5%BC%8F%E4%BB%8B%E7%BB%8D#%E8%87%AA%E5%8A%A8%E5%88%9B%E5%BB%BA%E6%9B%B4%E6%96%B0-pull-request-%E8%A7%84%E5%88%99
Last verified: 2026-03-11

## Core Behavior

- A protected branch can use review mode instead of standard direct-push protection.
- In review mode, if a repository member does not have permission to push directly to the protected branch, a push creates or updates a pull request instead of being merged directly.
- The push response includes the created or updated pull request URL.
- The same pull request can also be updated by pushing to the generated `auto-*` source branch.

## Commit-Set Rule

Gitee updates an existing auto-created pull request only when the new pushed commit set fully contains that pull request's diff commits. If the existing PR's commits are no longer a subset of the new pushed history, Gitee creates a new pull request.

## Example Commit Histories

Base history:

```text
1-2-3-4
```

Create the first auto PR:

```text
1-2-3-4-5
```

- Push to the protected branch.
- Gitee creates PR-a with commit `5`.

Update the same PR:

```text
1-2-3-4-5-6
```

- Push to the protected branch again.
- Gitee updates PR-a because commits from PR-a are still included.

Create a new PR after history rewrite:

```text
1-2-3-4-5-7
```

- This can happen after `amend`, `rebase`, `reset`, or `revert`.
- Push to the protected branch.
- Gitee creates PR-b because the previous PR commit set is no longer fully contained.

## Recommended Working Styles

### Local feature branch workflow

- Develop on a normal local branch.
- Push that branch to the protected target branch when you want Gitee to auto-create the PR.
- Keep adding commits on top if you want later pushes to update the same PR.

### Local protected-branch workflow

- Develop locally while tracking the protected branch name.
- Push to the protected branch in review mode to create or update the PR.
- Use extra care because history rewrites still trigger the same new-PR rule.

## Practical Guidance For Codex

- If the user says "update the current PR", prefer additive commits over rewritten history.
- If the user already rewrote history but insists on keeping the same PR, find and push to the existing `auto-*` source branch instead of pushing to the protected branch again.
- If a push lands directly on the target branch, do not assume review mode worked for this account. Report that the branch protection or permissions do not match the expected setup.
