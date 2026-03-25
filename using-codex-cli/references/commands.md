# Codex CLI Command Reference

Use these patterns when you need exact terminal commands. Re-run the relevant
`--help` command if the installed CLI version may differ.

## Basic Checks

```bash
codex --version
codex --help
```

## Interactive Sessions

Start an interactive session in the current directory:

```bash
codex
```

Start an interactive session with an initial prompt:

```bash
codex "Inspect this repository and summarize the test setup."
```

Start in a specific repository with safe defaults:

```bash
codex -C /path/to/repo --sandbox workspace-write -a on-request \
  "Fix the failing test and run the narrowest relevant verification."
```

Use the convenience preset for low-friction sandboxed execution:

```bash
codex -C /path/to/repo --full-auto \
  "Implement the requested change and summarize the result."
```

Attach images to the first prompt:

```bash
codex -i screenshot.png "Explain the UI issue shown in the image."
```

## Non-Interactive Runs

Run a one-shot task:

```bash
codex exec -C /path/to/repo \
  "Update the README to document the new environment variable."
```

Read the prompt from stdin:

```bash
printf '%s\n' \
  'Review the current repository and list the highest-risk areas.' \
  | codex exec -C /path/to/repo -
```

Emit JSONL events for automation:

```bash
codex exec -C /path/to/repo --json \
  "Summarize the recent changes in this repository."
```

Write the final message to a file:

```bash
codex exec -C /path/to/repo -o last-message.txt \
  "Draft release notes from the current git diff."
```

Run outside a git repository only when needed:

```bash
codex exec --skip-git-repo-check \
  "Create a short shell script that prints system information."
```

## Reviews

Review uncommitted work:

```bash
codex review --uncommitted
```

Review against a base branch:

```bash
codex review --base main
```

Review a specific commit:

```bash
codex review --commit abc1234
```

Add custom instructions to the review:

```bash
codex review --base main \
  "Focus on regressions, missing tests, and unsafe migrations."
```

## Session Management

Resume the most recent interactive session:

```bash
codex resume --last
```

Resume a specific session and continue with a new prompt:

```bash
codex resume <session-id> "Continue from the last plan and implement the fix."
```

Fork the most recent session to try a different approach:

```bash
codex fork --last "Take a simpler approach and minimize file changes."
```

## Other Useful Commands

Apply a previously produced Codex task diff locally:

```bash
codex apply <task-id>
```
