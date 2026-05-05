#!/usr/bin/env bash
set -euo pipefail

repo_name="${1:?repo required}"
sha="${2:?sha required}"
lesson_file="${3:?lesson file required}"
memory_file="/home/drow/.codex/memories/aegis-reviewer.md"

if [[ ! -f "$lesson_file" ]]; then
  echo "lesson file not found: $lesson_file" >&2
  exit 1
fi

{
  printf '\n## %s %s\n' "$repo_name" "$sha"
  cat "$lesson_file"
  printf '\n'
} >> "$memory_file"
