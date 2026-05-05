# Canary Experiments

Use these when reasoning is not enough.

## 1. Frozen-Head Packet

Before canaries:
- record exact head SHA or plan revision
- record base ref
- record prior reviewed SHA if applicable
- capture changed files, author claims, and stated user/business goal

## 2. Goal -> Spec -> Code -> Test Trace

Use when:
- the branch claims to solve a real user or operator problem
- the user asks for plan or logic review
- tests look strong locally but real behavior is uncertain

Minimal canary:
- pick one primary promised outcome
- point to where the outcome is stated in issue, PR, spec, or docs
- identify the exact code path that is supposed to implement it
- identify the exact tests that claim to prove it
- if e2e is claimed, run or emulate the end-to-end path

Failure means the branch may be internally tidy but not actually deliver the promised value.

## 3. Identity / Rename Stability

Use when:
- `target_id`, stable IDs, ownership, queue keys, dedup markers, or repair payloads changed

Minimal canary:
- create state under old display/name key
- keep stable logical identity unchanged
- instantiate renamed target
- verify old delivered markers, pending backlog, repair state, and ownership are still visible or migrated

Failure means the branch still has cosmetic-rename state breakage.

## 4. Routing / Selection / Ambiguity

Use when:
- route constraints, pane selection, reviewer assignment, or tie-breaking changed

Minimal canaries:
- routed target plus stronger unrelated hint; route must still win
- two equal-score candidates; live delivery and preview must both fail closed
- route exists with empty bucket; target must be explicitly blocked, not silently widened
- preview and live path must choose from the same effective context

## 5. Batch / Queue Behavior

Use when:
- backlog, batching, drain behavior, or catch-up logic changed

Minimal canaries:
- queue old events, then rename target and verify backlog is still visible
- equal-score batch destination candidates must fail closed
- route-constrained backlog buckets must not escape their route session set
- delayed repair or queue drift must not over-clear or under-clear backlog

## 6. Redis / Database Degradation

Use when:
- status, selection, routing, repair, or manual controls depend on Redis or a datastore

Minimal canaries:
- outage before cycle start
- outage after polling but before route commit
- outage after external send but before durable commit
- outage during status rendering
- restart after a partial failure fence was written

Check:
- fail-closed behavior
- no false healthy snapshot
- no unsafe resend

## 7. Security Path And Blast Radius

Use when:
- untrusted input crosses boundaries
- the change touches auth, parsing, prompts, command execution, build/install paths, or dependencies

Minimal canaries:
- injection attempt at the narrowest boundary that accepts untrusted data
- spoofed metadata or identity marker where routing or authority depends on it
- compromised or unexpected dependency or asset path in the build or scan workflow
- one-bad-input test to see whether failure stays local or cascades

Check:
- rejection or containment happens at the right layer
- logs and status do not leak sensitive payloads
- blast radius is bounded to the minimum practical surface

## 8. Prompt / Token Use

Use when:
- the branch changes LLM prompts, summaries, batching, or relay text assembly

Check:
- repeated bodies are not duplicated unnecessarily
- prompts are bounded
- summaries do not include redundant metadata already available in links or state
- one large body does not get copied through multiple queues or layers

## 9. Docs / Operator Drift

Use when:
- status, CLI flags, specs, plans, or runtime state shape changed

Check:
- README, operations docs, specs, and status examples match the current runtime
- merge notes do not claim stronger isolation, safety, durability, or end-to-end completeness than exists
- any intentional compatibility fence is explicit

## 10. Plan Soundness Review

Use when:
- there is little or no code yet, but the plan is intended to drive implementation

Check:
- goal is explicit
- invariants are explicit
- security story exists
- compatibility and migration story exists
- rollout and rollback story exists
- observability and operator story exists
- tests and canaries are specified well enough to prove the plan later

Failure means the plan is not yet implementation-grade.

## 11. Recommended Reproduction Style

Prefer:
- tiny fakeredis or temp-dir harnesses
- patched tmux pane listings
- route fixtures with one or two explicit sessions
- deterministic event IDs
- short plan-to-code trace tables when reviewing design

Avoid:
- gigantic end-to-end rigs when a 20-line canary proves the invariant
- mock-only tests that bypass the real selector or state keying logic
- claiming end-to-end confidence when only unit-level evidence exists
