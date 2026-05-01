# advisor-trackable-eval-skills

Two composable skills for turning a phased plan into an advisor-trackable
verification surface, using flat-boolean criteria that are mechanically
impossible to stack.

The pattern is: **one row = one fact = one verifiable observation.** No row
combines two clauses via `and`, `or`, `&`, `plus`, `either`, or any other
conjunction. Each row points to a file path or a command, names an expected
output, and leaves an `EVIDENCE` field for the executor to fill in. When the
executor returns, an Opus advisor reads the manifest plus the named artifacts
and writes a verdict file with PASS / FAIL / SKIP per row.

The format prevents lying. A compound row ("all repos have LICENSE") hides N
sub-facts and lets the executor tick the box without doing the work. A flat
row ("repo X has LICENSE at path Y") forces a specific file or grep result
before the box can be ticked.

## Quick start

1. Plan the work as phased units.
2. For each unit, list the atomic facts the work produces.
3. Run `skills/eval_criteria_create/` against the plan; it emits a manifest
   with one row per atomic fact.
4. Validate the manifest with `tools/lint_no_stack.sh`.
5. The executor populates `EVIDENCE:` on each row as work completes.
6. On return, run `skills/eval_verdict_write/` to read the manifest plus
   artifacts and emit `<task>_VERDICT_v1.md`.

## Skills in this bundle

| Skill | Purpose |
|---|---|
| `eval_criteria_create` | Turns a phased plan into a flat-boolean manifest |
| `eval_verdict_write`   | Turns a populated manifest + artifacts into a verdict file |

## Format rules

See `docs/FLAT_BOOLEAN_RULE.md` for the canonical no-stacking specification
(reproduced from the source plan's `§C-FMT-NO-STACK`).

The row template:

```
- [ ] C-NNN | <phase> | <subject> | <verification: file path or command> | <expected> | EVIDENCE: <one-line fact> | NOTE: <optional>
```

Two integrity gates the manifest must pass before an executor begins:

```
# row-shape gate (every row matches the canonical pipe shape)
grep -cE '^- \[[ x]\] C-[A-Z0-9-]+ \| ' MANIFEST.md
# expected: matches total `^- \[` row count

# no-stack gate (no row body contains a conjunction trigger)
grep -nE '^- \[[ x]\] C-' MANIFEST.md \
  | grep -v 'C-FMT-NO-STACK' \
  | grep -iE ' and | AND | & | plus | or | OR | either |, also '
# expected: empty
```

`tools/lint_no_stack.sh` runs both.

## Worked example

`examples/cli_publish_eval_manifest_v1.md` is a real run with 80 flat-boolean
rows covering an 8-phase GitHub publication workflow. `examples/cli_publish_plan_v1.md`
is the plan that produced it. Read these two together to see how a plan and
its eval manifest stay in sync.

## License

Apache-2.0. See `LICENSE`.

## Origin

Created 2026-04-30 from a Cowork-Opus session that needed to instrument an
existing GitHub publication run for advisor-trackable verification on return.
The session pattern was: read the run state, identify the verification surface,
write the plan, write the manifest, run the manifest's own integrity gates,
fix the bug the gates caught, ship. The bundle generalizes that workflow.

See `SESSION_LOG_2026-04-30.md` for the full session record.
