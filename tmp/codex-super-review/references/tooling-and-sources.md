# Tooling And Sources

Use the smallest set that materially increases review confidence, but do not skip ecosystem-specific tools when the repo actually uses that ecosystem.

## Installed Baseline On This Host

Universal and ops:
- `git diff --check`
- `gh` and the GitHub plugin
- `semgrep`
- `gitleaks`
- `detect-secrets`
- `shellcheck`
- `yamllint`

Python:
- `mypy`
- `ruff`
- `bandit`
- `pylint`
- `vulture`
- `pip-audit`
- `safety`

JavaScript / TypeScript:
- `npm audit`
- repo-native type/lint commands when available

Go:
- `govulncheck`

Rust:
- `cargo`
- `cargo-audit`

Cross-ecosystem vulnerability scan:
- `osv-scanner`

## When To Use Which

Universal and ops:
- `semgrep` for structural security and logic patterns
- `gitleaks` and `detect-secrets` for secret exposure
- `shellcheck` for shell scripts and service wrappers
- `yamllint` for workflow, config, and deployment YAML

Python:
- `mypy` for type and contract drift
- `ruff` for fast correctness and import problems
- `bandit` for Python security antipatterns
- `pylint --errors-only` for parser and runtime-shape issues
- `vulture` for dead code and stale branches
- `pip-audit` and `safety` for package advisories

JavaScript / TypeScript:
- `npm audit` for dependency advisories
- repo-native `tsc`, `eslint`, `vitest`, or `jest` when they exist and are part of the project contract

Go:
- `govulncheck ./...` for reachable advisory scan, not just version presence

Rust:
- `cargo audit` for dependency advisories
- use `cargo test`, `cargo clippy`, or project-native commands when the repo already depends on them

Cross-ecosystem:
- `osv-scanner scan source -r <repo>` for language-agnostic dependency and manifest coverage

## Review Tactics Worth Keeping

Borrowed and adapted from the Claude super-reviewer approach:
- start with a repo-wide consistency and drift pre-check before line-by-line reasoning
- run a real static baseline before trusting LLM judgment on type, dead-code, or secrets issues
- verify the live path before escalating a finding
- prefer one consolidated review packet over a long sequence of incremental comments

## Prefer Prebuilt Binaries When The Host Fights You

If the host has `noexec` temp mounts, linker restrictions, or tight build cache space:
- prefer official prebuilt release binaries over local compilation for heavyweight tools
- verify integrity using published checksums or release metadata
- record the environment constraint in the review if it changes what was validated

## External Sources

Use web research for current external context only when necessary.

Priority order:
- official vendor docs
- project release notes
- GitHub Security Advisories
- OSV
- NVD
- standards or protocol docs
- exploit references only when exploit realism matters to severity

## Good Future Additions

These make sense when the server workflow actually needs them:
- `trivy`
  - container, filesystem, IaC, SBOM, and image scanning
- `syft` and `grype`
  - SBOM generation plus vulnerability matching
- CodeQL
  - deeper semantic analysis when GitHub Advanced Security or CI integration exists
- mutation and coverage tools
  - critical logic, routing, repair, and parser surfaces
- protocol or schema contract tests
  - APIs, webhooks, and long-lived control-plane state

## Subagent Split

Only when explicitly authorized by the user:
- Explorer A: security and abuse-path pass
- Explorer B: tests and canary realism pass
- Explorer C: docs and ops drift pass
- Explorer D: external advisory or platform-context pass
- Worker: bounded reproduction harness or verification patch

The lead reviewer still owns the final judgment.
