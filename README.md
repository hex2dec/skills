# Codex Skills

A small collection of Codex skills for workflow automation and repository operations.

Each skill lives in its own directory and includes a `SKILL.md` entrypoint plus any supporting files it needs, such as agent configs or reference material.

## Available Skills

- **gitee-auto-pr** — Create or update Gitee pull requests by pushing to protected branches in review mode instead of opening PRs manually in the web UI.

  ```bash
  npx skills@latest add hex2dec/skills/gitee-auto-pr
  ```

- **gitee-checkout-pr** — Fetch a Gitee pull request by number into a local branch and switch to it by auto-detecting the repository's Gitee remote instead of hardcoding the remote URL.

  ```bash
  npx skills@latest add hex2dec/skills/gitee-checkout-pr
  ```

## License

MIT. See [LICENSE](./LICENSE).
