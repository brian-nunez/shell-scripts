---
name: shell-add-tool
description: Add or update tools, aliases, environment variables, and dependency checks in this cross-platform shell configuration. Use for new shell commands, developer tools, or environment setup.
---

# Add a Shell Tool

## Supported Systems

- macOS ARM64 with Zsh
- Ubuntu Desktop 24 AMD64 with Bash
- Omarchy x86_64 with Bash

## Inspect First

- Read `init.sh`, the related tool script, `validate.sh`, and the relevant documentation.
- Preserve existing user-facing aliases, functions, prompts, and integrations unless the request explicitly replaces them.
- Confirm the exact executable, version requirement, package name, and installation command locally. Do not guess package names.

## Implementation Rules

- Keep tool configuration in a focused top-level script sourced explicitly by `init.sh`.
- Preserve dependency order in `init.sh`: platform environment, shell, tools, helpers, aliases, then local secrets.
- Detect the active shell with `${ZSH_VERSION:-}` or `${BASH_VERSION:-}`. Never infer it from the operating system or `$SHELL`.
- Use `uname -s` only for genuine operating-system differences.
- Use `_shell_scripts_prepend_path` for PATH additions so repeated sourcing remains idempotent.
- Add optional tool-specific directories only when they exist.
- Quote all path and argument expansions.
- Keep temporary initialization variables private by unsetting them before returning control to the user.
- Guard aliases, completion generation, `eval`, and external commands when their dependency may be absent.
- Do not perform network requests, installations, or expensive command generation during shell startup.
- Initialize completion systems at most once per shell session and use available caches.
- Keep prompt functions fast; avoid enumerating repositories, branches, or files on every prompt render.

## Security Rules

- Never place credentials, tokens, private keys, or passwords in tracked files.
- Never print secret values during initialization or validation.
- Keep machine-local secret files ignored by Git.
- Do not broaden environment-variable exposure or file permissions without explicit approval.

## Dependency Validation

- Add every required executable to `validate.sh` for all supported platforms.
- Validate required versions, configuration files, and installed components when presence alone is insufficient.
- Provide exact macOS, Ubuntu 24, and Omarchy installation commands.
- Report optional tools separately from required failures.
- Validation must be read-only; installation commands are printed, never executed.

## Documentation

- Update `README.md` when requirements or top-level features change.
- Update `docs/dependencies.md` with installation and configuration commands.
- Update `docs/tools.md` for aliases, functions, and integrations.
- Update `docs/architecture.md` when initialization order or cross-platform behavior changes.

## Verification

- Run `bash -n` and `zsh -n` for every shell script.
- Source `init.sh` in isolated Bash and Zsh processes.
- Source it twice and confirm PATH entries are not duplicated.
- Run `./validate.sh` and verify its exit status.
- Do not install missing software without explicit user approval.
