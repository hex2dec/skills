# Agent Skills Hub

A small collection of agent skills for workflow automation and repository operations, with compatibility for Codex-style skill workflows.

This repository is an agent skills hub: each skill lives in its own directory and includes a `SKILL.md` entrypoint plus any supporting files it needs, such as agent configs or reference material.

For new Gitee terminal workflows, prefer [`gitee-cli`](https://github.com/hex2dec/gitee-cli) and the matching [`using-gitee-cli`](https://github.com/hex2dec/gitee-cli/tree/main/skills/using-gitee-cli) skill. They provide a broader, agent-first command surface for repository, issue, and pull request operations.

## Available Skills

- **using-codex-cli** — Teach another agent or user how to use the Codex CLI from a terminal, including interactive sessions, `codex exec`, `codex review`, session management, and safe execution defaults.

  ```bash
  npx skills@latest add hex2dec/skills/using-codex-cli
  ```

- **gitee-checkout-pr** — Fetch a Gitee pull request by number into a local branch and switch to it by auto-detecting the repository's Gitee remote instead of hardcoding the remote URL.

  ```bash
  npx skills@latest add hex2dec/skills/gitee-checkout-pr
  ```

## Deprecated Skills

- **gitee-auto-pr** — Deprecated. Kept only for legacy repositories that still rely on Gitee protected branches in review mode to auto-create or auto-update PRs from `git push`.

  Prefer `gitee-cli` plus the `using-gitee-cli` skill for new repository, issue, and pull request workflows.

  ```bash
  npx skills@latest add hex2dec/skills/deprecated/gitee-auto-pr
  ```

## License

MIT. See [LICENSE](./LICENSE).
