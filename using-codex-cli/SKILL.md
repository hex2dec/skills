---
name: using-codex-cli
description: Teach another agent or user how to use the Codex CLI from a terminal. Use when Codex needs to explain or perform terminal workflows such as starting an interactive `codex` session, running `codex exec` or `codex review`, resuming or forking sessions, choosing sandbox and approval settings, attaching images, enabling web search, or applying a Codex task diff locally.
---

# Using Codex CLI

## Overview

Teach how to run `codex` safely and effectively from a shell. Prefer exact commands and flags verified from local `codex --help`, and re-check subcommand help before giving instructions when the installed CLI version may differ.

## Start With the Right Entry Point

- Use plain `codex [PROMPT]` for an interactive terminal session.
- Use `codex exec [PROMPT]` for one-shot execution, automation, or machine-readable output.
- Use `codex review` when the task is code review rather than implementation.
- Use `codex resume` to continue an earlier interactive session.
- Use `codex fork` to branch from an earlier session and try a different approach.
- Use `codex apply <task-id>` only when the user already has a Codex task diff to apply locally.

## Shape the Invocation

- Start by confirming `codex` exists with `codex --version` if the environment is unknown.
- Run from the target repository root when possible. Otherwise pass `-C <dir>`.
- Put the goal, scope, constraints, and required verification in the initial prompt.
- Prefer stdin for long prompts with `codex exec -`.
- Attach screenshots or mockups with `-i <file>` when the task depends on images.
- Use `-m <model>` or `-p <profile>` only when there is a clear reason to override defaults.

Example prompt shape:

```text
Fix the failing test in packages/api. Work only in this repository. Run the
narrowest relevant verification and summarize the root cause.
```

## Choose Safe Defaults

- Prefer `--sandbox workspace-write` for normal coding work.
- Use `--sandbox read-only` for explanation, inspection, or audit tasks that should not write.
- Use `--add-dir <dir>` for specific extra writable locations instead of widening the root blindly.
- Prefer `-a on-request` for interactive sessions.
- Prefer `-a never` only for controlled non-interactive automation where failure should return directly.
- Use `--full-auto` when sandboxed low-friction execution is acceptable.
- Avoid `--dangerously-bypass-approvals-and-sandbox` unless the environment is already externally sandboxed and the user explicitly accepts the risk.
- Enable `--search` only when the task needs current web information.

## Handle Common Terminal Workflows

- Use `codex review --uncommitted`, `--base <branch>`, or `--commit <sha>` for review workflows.
- Use `codex apply <task-id>` only when the user already has a task diff produced by Codex.

## Teach With Minimal Friction

- Give the smallest command that solves the request, then explain only the flags that matter.
- Prefer concrete invocations over abstract descriptions.
- If the user asks how to use Codex in a terminal, answer with a recommended starter command plus the next one or two commands they are likely to need.
- If asked to run Codex on the user's behalf, execute the CLI command instead of only describing it unless that would start a long-lived interactive session they did not ask to launch.
- Do not invent subcommands or flags. Inspect `codex <subcommand> --help` first when unsure.

## Resources

- Read `references/commands.md` for verified command patterns and example invocations.
