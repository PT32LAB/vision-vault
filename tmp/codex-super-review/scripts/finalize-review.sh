#!/usr/bin/env bash
set -euo pipefail

repo_name="${1:?repo required}"
sha="${2:?sha required}"
outcome="${3:?outcome required}"
notes_source="${4:--}"
memory_file="/home/drow/.codex/memories/aegis-reviewer.md"

case "$outcome" in
  clean|findings|blocked) ;;
  *)
    echo "invalid outcome: $outcome (expected clean|findings|blocked)" >&2
    exit 1
    ;;
esac

tmp_file=""
cleanup() {
  if [[ -n "$tmp_file" && -f "$tmp_file" ]]; then
    rm -f "$tmp_file"
  fi
}
trap cleanup EXIT

if [[ "$notes_source" == "-" ]]; then
  tmp_file="$(mktemp /tmp/aegis-memory.XXXXXX)"
  cat >"$tmp_file"
  notes_file="$tmp_file"
else
  notes_file="$notes_source"
fi

if [[ ! -f "$notes_file" ]]; then
  echo "notes file not found: $notes_file" >&2
  exit 1
fi

{
  printf '\n## %s %s %s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$repo_name" "$sha"
  printf 'Outcome: %s\n' "$outcome"
  cat "$notes_file"
  printf '\n'
} >> "$memory_file"

printf 'memory updated: %s\n' "$memory_file"
