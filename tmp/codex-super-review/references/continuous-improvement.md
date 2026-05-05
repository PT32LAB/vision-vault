# Continuous Improvement

Aegis is a reviewer, not a cheerleader. Improvement is mandatory when a miss is found, and durable learning is mandatory after every run.

## Review Closeout Rule

Every completed review must:
- mark the run finished with `scripts/review-run.sh finish ...`
- append a memory entry with `scripts/finalize-review.sh ...`

Use the run log during the review, not only at the end.

If there is no new lesson, say so explicitly:
- `No new invariant class; existing checklist held.`

## Learning Contract

Aegis must learn from:
- its own misses and near-misses
- stronger findings or arguments from other reviewers
- good patterns that led to real findings
- failed canaries and successful canaries
- new tools or new ways to use existing tools
- host/environment failures that weakened validation or recovery

Every run should leave behind durable memory for the next run, even if the outcome is `clean`.

## Run State

Persistent run logs live under:
- `/home/drow/.codex/memories/aegis-runs/`

Each run should preserve:
- current state snapshot
- event log
- artifact pointers
- enough phase and summary data to recover after a crash or stall

Preferred commands:
- `scripts/review-run.sh start ...`
- `scripts/review-run.sh checkpoint ...`
- `scripts/review-run.sh heartbeat ...`
- `scripts/review-run.sh artifact ...`
- `scripts/review-run.sh show ...`
- `scripts/review-run.sh resume ...`
- `scripts/review-run.sh finish ...`

## What To Log

After an important review or a confirmed miss, capture:
- repo and SHA
- review outcome: `clean`, `findings`, or `blocked`
- short description of the miss, new technique, or confirmed invariant
- invariant class that was missed or deliberately re-checked
- why the earlier review failed to catch it, if relevant
- what another reviewer caught that Aegis did not, or why Aegis disagreed and what evidence resolved it
- concrete check or canary that should exist next time
- useful issue-finding patterns that worked well on this run
- any new tool, command, or source that should be part of future reviews
- whether the issue was logic, state, security, docs, tests, external-context drift, or host/tooling friction
- where the review run log or artifacts live if they matter for later recovery

## Typical Failure Classes

- trusted docs but not live code
- trusted tests that mocked away the real path
- checked per-event flow but not batch, repair, or restart flow
- checked routing logic but not durable state keys
- checked local correctness but not operator contract
- checked code but not exploitability or current advisory context
- missed a same-class issue in an adjacent path after a targeted fix
- assumed local tool installation would work when the host had `noexec`, linker, or disk/cache constraints
- lost review progress because no heartbeat or checkpoints were persisted
- ignored another reviewer's stronger evidence instead of reconciling it

## Improvement Rule

Every real miss must produce one of:
- a new checklist item
- a new canary experiment
- a new search pattern
- a new external-context source to consult
- a new tool selection rule
- a new checkpoint or heartbeat practice if recovery was weak

Every strong external finding should produce one of:
- a confirmed adoption into the checklist
- a documented rejection with evidence
- a new comparator test for future reviews

## Memory File

Use the persistent Aegis memory file at:
- `/home/drow/.codex/memories/aegis-reviewer.md`

Do not overwrite history casually. Append concise lessons.
