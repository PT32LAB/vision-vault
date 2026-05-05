#!/usr/bin/env bash
set -euo pipefail

repo_dir="${1:-.}"
out_dir="${2:-$repo_dir/.aegis-tool-sweep}"

mkdir -p "$out_dir"
cd "$repo_dir"

have() {
  command -v "$1" >/dev/null 2>&1
}

run_log() {
  local name="$1"
  shift
  {
    printf '== %s ==\n' "$name"
    "$@"
  } >"$out_dir/$name.log" 2>&1 || true
}

printf 'repo_dir=%s\n' "$PWD"
printf 'out_dir=%s\n' "$out_dir"

if have semgrep; then
  run_log semgrep semgrep scan --config p/default --metrics=off .
fi

if have gitleaks; then
  run_log gitleaks gitleaks detect --source . --no-git --no-banner --redact
fi

if have detect-secrets; then
  run_log detect-secrets detect-secrets scan --all-files .
fi

shell_files="$(rg --files -g '*.sh' -g '*.bash' -g '*.zsh' 2>/dev/null || true)"
if [[ -n "$shell_files" ]] && have shellcheck; then
  printf '%s\n' "$shell_files" >"$out_dir/shell-files.txt"
  {
    printf '== shellcheck ==\n'
    printf '%s\n' "$shell_files" | xargs -r shellcheck
  } >"$out_dir/shellcheck.log" 2>&1 || true
fi

yaml_files="$(rg --files -g '*.yml' -g '*.yaml' 2>/dev/null || true)"
if [[ -n "$yaml_files" ]] && have yamllint; then
  printf '%s\n' "$yaml_files" >"$out_dir/yaml-files.txt"
  {
    printf '== yamllint ==\n'
    printf '%s\n' "$yaml_files" | xargs -r yamllint
  } >"$out_dir/yamllint.log" 2>&1 || true
fi

if [[ -f package-lock.json || -f npm-shrinkwrap.json ]] && have npm; then
  run_log npm-audit npm audit --audit-level=high
fi

if [[ -f go.mod ]] && have govulncheck; then
  run_log govulncheck govulncheck ./...
fi

if [[ -f Cargo.toml ]] && have cargo-audit; then
  run_log cargo-audit cargo-audit
fi

if have osv-scanner; then
  run_log osv-scanner osv-scanner scan source -r .
fi

printf 'logs:\n'
find "$out_dir" -maxdepth 1 -type f | sort
