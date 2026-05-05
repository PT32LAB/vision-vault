#!/usr/bin/env bash
set -euo pipefail

repo_dir="${1:-.}"
base_ref="${2:-origin/main}"
pr_number="${3:-}"
old_reviewed_sha="${4:-}"

cd "$repo_dir"

printf '== REVIEW PACKET ==\n'
printf 'repo_dir: %s\n' "$PWD"
printf 'head_sha: '
git rev-parse HEAD
printf 'base_ref: %s\n' "$base_ref"

printf '\n== STATUS ==\n'
git status --short

printf '\n== DIFF CHECK ==\n'
git diff --check "$base_ref...HEAD" || true

printf '\n== DIFF STAT ==\n'
git diff --stat "$base_ref...HEAD" || true

printf '\n== CHANGED FILES ==\n'
git diff --name-only "$base_ref...HEAD" || true

if [[ -n "$old_reviewed_sha" ]]; then
  printf '\n== RANGE DIFF ==\n'
  git range-diff "${old_reviewed_sha}...HEAD" || true
fi

if command -v gh >/dev/null 2>&1 && [[ -n "$pr_number" ]]; then
  printf '\n== PR VIEW ==\n'
  gh pr view "$pr_number" \
    --json number,title,state,isDraft,author,headRefName,headRefOid,baseRefName,mergeable,updatedAt \
    || true

  printf '\n== PR FILES ==\n'
  gh pr diff "$pr_number" --name-only || true
fi
