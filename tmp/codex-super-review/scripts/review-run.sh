#!/usr/bin/env bash
set -euo pipefail

base_dir="${AEGIS_RUNS_DIR:-/home/drow/.codex/memories/aegis-runs}"
mkdir -p "$base_dir"

slugify() {
  printf '%s' "$1" | tr '[:upper:]' '[:lower:]' | sed 's#[^a-z0-9._-]#-#g; s#--*#-#g; s#^-##; s#-$##'
}

now_utc() {
  date -u +%Y-%m-%dT%H:%M:%SZ
}

resolve_run_dir() {
  local ref="$1"
  case "$ref" in
    latest)
      printf '%s\n' "$base_dir/latest"
      ;;
    latest-*)
      printf '%s\n' "$base_dir/$ref"
      ;;
    *)
      printf '%s\n' "$ref"
      ;;
  esac
}

require_run_dir() {
  local run_dir
  run_dir="$(resolve_run_dir "$1")"
  if [[ -L "$run_dir" ]]; then
    run_dir="$(readlink -f "$run_dir")"
  fi
  if [[ ! -d "$run_dir" ]]; then
    echo "run dir not found: $run_dir" >&2
    exit 1
  fi
  printf '%s\n' "$run_dir"
}

state_get() {
  local run_dir="$1"
  local key="$2"
  awk -F '\t' -v k="$key" '$1 == k { print substr($0, index($0, $2)) }' "$run_dir/state.tsv"
}

write_state() {
  local run_dir="$1"
  local run_id="$2"
  local repo="$3"
  local sha="$4"
  local kind="$5"
  local workdir="$6"
  local status="$7"
  local phase="$8"
  local step="$9"
  local started_at="${10}"
  local updated_at="${11}"
  local heartbeat_at="${12}"
  local last_summary="${13}"

  cat > "$run_dir/state.tsv" <<STATE
run_id	$run_id
repo	$repo
sha	$sha
kind	$kind
workdir	$workdir
status	$status
current_phase	$phase
current_step	$step
started_at	$started_at
updated_at	$updated_at
heartbeat_at	$heartbeat_at
last_summary	$last_summary
STATE
}

append_event() {
  local run_dir="$1"
  local event_type="$2"
  local phase="$3"
  local status="$4"
  local summary="$5"
  printf '%s\t%s\t%s\t%s\t%s\n' "$(now_utc)" "$event_type" "$phase" "$status" "$summary" >> "$run_dir/events.log"
}

cmd_start() {
  local repo="${1:?repo required}"
  local sha="${2:?sha required}"
  local kind="${3:?kind required}"
  local workdir="${4:-}"
  local goal="${5:-}"
  local ts repo_slug run_id run_dir started_at

  ts="$(date -u +%Y%m%dT%H%M%SZ)"
  repo_slug="$(slugify "$repo")"
  run_id="${ts}-${repo_slug}-${sha:0:12}"
  run_dir="$base_dir/$run_id"
  started_at="$(now_utc)"

  mkdir -p "$run_dir/artifacts"
  : > "$run_dir/events.log"

  write_state "$run_dir" "$run_id" "$repo" "$sha" "$kind" "$workdir" "running" "freeze_scope" "start" "$started_at" "$started_at" "$started_at" "review started"
  append_event "$run_dir" "start" "freeze_scope" "running" "goal=${goal:-unspecified}"

  ln -sfn "$run_dir" "$base_dir/latest"
  ln -sfn "$run_dir" "$base_dir/latest-$repo_slug"

  printf '%s\n' "$run_dir"
}

cmd_checkpoint() {
  local run_dir phase step status summary repo sha kind workdir started_at heartbeat_at run_id updated_at
  run_dir="$(require_run_dir "${1:?run dir required}")"
  phase="${2:?phase required}"
  step="${3:?step required}"
  status="${4:?status required}"
  summary="${5:-}"

  run_id="$(state_get "$run_dir" run_id)"
  repo="$(state_get "$run_dir" repo)"
  sha="$(state_get "$run_dir" sha)"
  kind="$(state_get "$run_dir" kind)"
  workdir="$(state_get "$run_dir" workdir)"
  started_at="$(state_get "$run_dir" started_at)"
  heartbeat_at="$(state_get "$run_dir" heartbeat_at)"
  updated_at="$(now_utc)"

  write_state "$run_dir" "$run_id" "$repo" "$sha" "$kind" "$workdir" "$status" "$phase" "$step" "$started_at" "$updated_at" "$heartbeat_at" "$summary"
  append_event "$run_dir" "checkpoint" "$phase" "$status" "$step: ${summary:-none}"
}

cmd_heartbeat() {
  local run_dir phase summary repo sha kind workdir started_at status step run_id updated_at heartbeat_at
  run_dir="$(require_run_dir "${1:?run dir required}")"
  phase="${2:?phase required}"
  summary="${3:-alive}"

  run_id="$(state_get "$run_dir" run_id)"
  repo="$(state_get "$run_dir" repo)"
  sha="$(state_get "$run_dir" sha)"
  kind="$(state_get "$run_dir" kind)"
  workdir="$(state_get "$run_dir" workdir)"
  started_at="$(state_get "$run_dir" started_at)"
  status="$(state_get "$run_dir" status)"
  step="$(state_get "$run_dir" current_step)"
  updated_at="$(now_utc)"
  heartbeat_at="$updated_at"

  write_state "$run_dir" "$run_id" "$repo" "$sha" "$kind" "$workdir" "$status" "$phase" "$step" "$started_at" "$updated_at" "$heartbeat_at" "$summary"
  append_event "$run_dir" "heartbeat" "$phase" "$status" "$summary"
}

cmd_artifact() {
  local run_dir label path
  run_dir="$(require_run_dir "${1:?run dir required}")"
  label="${2:?label required}"
  path="${3:?path required}"
  printf '%s\t%s\t%s\n' "$(now_utc)" "$label" "$path" >> "$run_dir/artifacts.tsv"
  append_event "$run_dir" "artifact" "$(state_get "$run_dir" current_phase)" "$(state_get "$run_dir" status)" "$label -> $path"
}

cmd_finish() {
  local run_dir outcome summary repo sha kind workdir started_at run_id updated_at
  run_dir="$(require_run_dir "${1:?run dir required}")"
  outcome="${2:?outcome required}"
  summary="${3:-review finished}"

  run_id="$(state_get "$run_dir" run_id)"
  repo="$(state_get "$run_dir" repo)"
  sha="$(state_get "$run_dir" sha)"
  kind="$(state_get "$run_dir" kind)"
  workdir="$(state_get "$run_dir" workdir)"
  started_at="$(state_get "$run_dir" started_at)"
  updated_at="$(now_utc)"

  write_state "$run_dir" "$run_id" "$repo" "$sha" "$kind" "$workdir" "$outcome" "finished" "finish" "$started_at" "$updated_at" "$updated_at" "$summary"
  append_event "$run_dir" "finish" "finished" "$outcome" "$summary"
}

cmd_show() {
  local run_dir
  run_dir="$(require_run_dir "${1:-latest}")"
  printf 'run_dir\t%s\n' "$run_dir"
  cat "$run_dir/state.tsv"
  if [[ -f "$run_dir/artifacts.tsv" ]]; then
    printf '\n[artifacts]\n'
    cat "$run_dir/artifacts.tsv"
  fi
  printf '\n[recent events]\n'
  tail -n 20 "$run_dir/events.log" || true
}

cmd_resume() {
  cmd_show "${1:-latest}"
}

cmd_list() {
  find "$base_dir" -mindepth 1 -maxdepth 1 -type d | sort
}

case "${1:-}" in
  start)
    shift
    cmd_start "$@"
    ;;
  checkpoint)
    shift
    cmd_checkpoint "$@"
    ;;
  heartbeat)
    shift
    cmd_heartbeat "$@"
    ;;
  artifact)
    shift
    cmd_artifact "$@"
    ;;
  finish)
    shift
    cmd_finish "$@"
    ;;
  show)
    shift
    cmd_show "$@"
    ;;
  resume)
    shift
    cmd_resume "$@"
    ;;
  list)
    shift
    cmd_list "$@"
    ;;
  *)
    cat >&2 <<USAGE
usage:
  review-run.sh start <repo> <sha> <kind> [workdir] [goal]
  review-run.sh checkpoint <run_dir|latest> <phase> <step> <status> [summary]
  review-run.sh heartbeat <run_dir|latest> <phase> [summary]
  review-run.sh artifact <run_dir|latest> <label> <path>
  review-run.sh finish <run_dir|latest> <clean|findings|blocked> [summary]
  review-run.sh show [run_dir|latest|latest-<repo-slug>]
  review-run.sh resume [run_dir|latest|latest-<repo-slug>]
  review-run.sh list
USAGE
    exit 1
    ;;
esac
