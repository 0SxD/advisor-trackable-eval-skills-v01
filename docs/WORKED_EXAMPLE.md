# WORKED_EXAMPLE.md

The CLI publish workflow at `examples/cli_publish_eval_manifest_v1.md` is a
real run with 80 flat-boolean rows covering an 8-phase 0SxD GitHub
publication. The companion plan at `examples/cli_publish_plan_v1.md` is the
plan that produced it. Read these two together.

## Origin context

A Cowork-Opus session executing `cli_deep_dive_and_publish_prompt v1.0`
paused at a Phase 3 gate awaiting Sage's wave-1 confirmation. The session
needed to hand the rest of the workflow to a separate PowerShell session
(for the `gh` and `gitleaks` calls the Cowork sandbox could not run) and
verify completion on return.

The compound failure mode the session was guarding against: a runner script
that says "all repos pushed" without specifying which repos, or "all
gitleaks scans clean" without specifying per-repo evidence. A flat manifest
forces per-repo rows.

## Section walkthrough

### Phase 0 -- Pre-flight already complete

The first eight rows reference work already in the progress log. EVIDENCE
fields point at log lines by timestamp. This is the cheapest verification:
the advisor on return reads the log line and confirms it exists.

### Phase 1 -- Read-only inventory already complete

Eight more rows referencing inventory file presence and the bulk-grep log
lines that the inventory pass produced. Same pattern: file exists, log
line exists, no execution needed by the advisor.

### Phase 2 -- Quarantine confirmed

Eight rows, one per quarantined folder, each pointing at the row in
`REPO_INVENTORY_v1.md` that documents it. Plus one inverse row asserting
the quarantine count is under the stop-condition limit of 50.

### Phase 3 -- Sage gate (15 questions)

One row per question Q-001 through Q-015. Each row's verification target
is `CLI_QUESTIONS_FOR_SAGE.md` and the expected output is one line matching
`^(ANSWER|DEFAULT_ACCEPTED):` after the Q-block. This is regex alternation
(allowed) describing one observable.

The 15 rows are the most important in the manifest. The Phase 4 template
expansion depends on Q-015's answer; Q-005 determines which of two near-
identical SageX plugin repos enters wave-1; Q-007 and Q-008 determine
whether two placeholder repos stay private.

### Phase 4 -- Per-repo staging (template)

A 7-row template per wave-1 repo, indented 4 spaces inside a code fence so
the integrity gates skip it until expansion. Each repo gets:

- LICENSE present
- README banner present  
- em-dash count zero
- tier-1 PII grep returns zero matches
- secret pattern grep returns zero matches
- `.gitignore` present
- per-repo report file written

For 5 wave-1 repos, expansion produces 35 active rows.

### Phase 5 -- Runner generation + post-execution

Twelve rows verifying the PowerShell runner contains each step it must
perform (gh auth check, git init, commit, gitleaks detect, gh repo create,
push, defensive gitleaks, gh repo edit visibility, gh repo view, batch
prompt). Each row's verification is a `grep` over the runner script.

A 3-row template per repo for post-execution state (pushed, gitleaks
clean, public).

### Phase 6 -- Sub-agent probes

Six rows asserting three deliverable files exist and are non-empty.
Cheap, structural, mechanical.

### Phase 7 -- C: drive scan

Three rows asserting the C: drive candidates file exists, is non-empty,
and excludes any quarantine identifier strings.

### Phase 8 -- Closing report

Five rows. The interesting one is `C-P8-ZERO-OPEN`: the manifest itself
has zero unchecked rows. This is the gate that fires when the executor
tries to call the workflow done while leaving rows open without NOTE.

### Stop conditions -- inverse criteria

Eight rows asserting that none of the prompt's Section 2 stop conditions
triggered. Each is a grep over the progress log expecting zero matches.

### Format-level integrity

Four rows running the manifest's own gates against itself: no stacking,
canonical row shape, EVIDENCE on every checked row, NOTE on every SKIP.

## What the worked example demonstrates

1. **The same pattern scales from 8 rows (Phase 0) to 80 rows (full
   manifest).** Each row remains one fact.

2. **Templates with placeholder identifiers are valid.** Indented
   templates inside fenced blocks pass the gates because they fail the
   line anchor. The executor's expansion produces canonical-shape rows
   with concrete IDs.

3. **Inverse criteria are flat.** "STOP-Q5: no network failure recorded"
   is one observable (grep returns zero matches) even though it expresses
   the absence of an event.

4. **Format gates are self-applied.** The manifest contains rows whose
   verification targets are the manifest itself. The advisor on return
   runs them, the same way the planner ran them at write time.

## Reading order

For the full picture:

1. `examples/cli_publish_plan_v1.md` -- understand the work being verified.
2. `examples/cli_publish_eval_manifest_v1.md` -- read top to bottom, paying
   attention to how each section's rows are constructed.
3. Run `tools/lint_no_stack.sh` against the manifest. Both gates green.
4. Read `docs/FLAT_BOOLEAN_RULE.md §3` (trigger tokens) and grep the
   manifest yourself for any of them. The only hit is the `C-FMT-NO-STACK`
   row, exempted by ID.

For implementing your own workflow:

1. Read `docs/HOW_IT_WORKS.md` for the three-session model.
2. Read `skills/eval_criteria_create/SKILL.md` for how to turn a plan into
   a manifest.
3. Use `templates/eval_manifest_template.md` as the starting skeleton.
