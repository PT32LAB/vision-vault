# Review Matrix

Use this matrix after freezing the head SHA or design revision. The goal is to walk invariants systematically instead of reviewing only by changed file.

## Core Surfaces

- user and business goals
- specs, plans, and rollout assumptions
- config validation and defaults
- main control flow
- routing or selection logic
- state persistence and migration
- queueing, batching, and retries
- recovery, repair, and restart safety
- status, logs, and operator controls
- docs and contract claims
- tests and canaries
- end-to-end flows

## For Each Surface, Check These Modes

- normal path
- no-op path
- fail-closed path
- fail-open hazard
- stale state / partial migration
- restart after partial write
- ambiguity / tie case
- rename or topology drift
- external dependency unavailable
- high-volume or boundary load
- attacker-controlled input or metadata
- partial rollout or mixed-version deployment

## Questions To Answer

### Goal And Spec Traceability

- What user or business goal is this work trying to satisfy?
- Where is that goal captured: issue, PR text, spec, plan, docs, or tests?
- Does the spec or plan actually cover the hard parts, or only the happy path?
- Does the code implement the promised behavior rather than a narrower internal proxy?
- Do tests and e2e behavior prove the actual goal?

### Logic

- What invariant is this code or plan trying to preserve?
- Is the invariant local or end-to-end?
- Does the implementation match the docs, specs, and tests?
- Are there older adjacent paths that still use the pre-fix behavior?
- If this is a plan, is the rollout, compatibility, and rollback story coherent?

### Security

- What input is untrusted at this layer?
- Can identity or authority be spoofed?
- Can a degraded path bypass a safety check?
- Can recovery or repair be abused to replay, suppress, or mutate state?
- Are secrets or credentials exposed to logs, files, prompts, comments, or artifacts?
- Are there injection surfaces: shell, SQL, template, HTML, path, deserialization, prompt, regex, config, IPC?
- Is there supply-chain trust: dependencies, generated code, release assets, lockfiles, build scripts, scanner assumptions?
- What is the blast radius if this component fails or is compromised?

### Stability

- Can a successful external action lose its durable commit?
- Can a failed durable commit still allow re-send after restart?
- Can queues or repair fences become orphaned?
- Can an outage create false healthy status?
- Can repeated partial failures create infinite retry or starvation?
- Can one broken dependency or state shard poison the rest of the workflow?

### Performance And Token Use

- Is the algorithmic complexity proportional to the workload?
- Is there duplicate scanning, serialization, or LLM prompt construction?
- Are large bodies or histories copied more than once?
- Is backlog summarization bounded and deduplicated?
- Does the implementation burn tokens proving internal state that could be represented more simply?

### Tests And End-To-End Coverage

- Are unit tests covering real logic rather than only mocks?
- Do integration tests hit the real boundaries that matter?
- Is there an end-to-end path proving the user-visible or operator-visible contract?
- If there is no full e2e test, is there a canary or harness that closes the gap?
- Are tests proving negative cases, degraded cases, and security-sensitive cases?

### Real-World Goal Alignment

- Does the PR or plan solve the user/operator goal or only move internal structure?
- Is the control-plane story usable on a real server?
- Are names, routes, panes, queues, repair actions, and runbooks understandable to operators?
- Are tests proving a realistic use case or only mocked internals?
- Is blast radius bounded in the way the business or operators would expect?

## Severity Heuristics

- Critical
  - credential or auth bypass
  - clear exploit path
  - destructive corruption or guaranteed replay
  - plan or implementation that silently violates the primary business or safety contract
- High
  - likely production incident
  - silent data loss
  - state corruption or unsafe double-send
  - end-to-end contract broken despite local tests passing
- Medium
  - real correctness gap or migration hole
  - contract drift that can misroute or strand work
  - missing invariant coverage in a risky area
  - plan missing a needed compatibility, security, or test story
- Low
  - docs drift
  - partial observability weakness
  - non-blocking but real maintainability hazard

## Review Closure Checklist

Before calling the review done, verify:

- every previous finding on the same PR head is either fixed or still explicitly present
- there is no same-class issue in adjacent paths
- the user or business goal is traceable through spec, code, and tests
- tests cover the real live path, not just mocks
- degraded, restart, rename, and attack-surface cases are covered if the branch touches state
- docs do not overclaim what is isolated, authenticated, durable, or end-to-end complete
- if this was a plan review, the plan is specific enough to implement and secure enough to trust
