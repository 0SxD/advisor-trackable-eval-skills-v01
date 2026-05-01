# skills/eval_verdict_write/SKILL.md

> Status: live
> Type: advisor-return skill
> Inputs: a populated manifest plus the artifacts it references
> Output: a verdict file at `<workdir>/<task>_EVAL_VERDICT_v1.md`
> Rule reference: see `docs/FLAT_BOOLEAN_RULE.md §7` (closing-state semantics)
> and `§8` (verdict file shape).

## Purpose

Read a manifest the executor has populated with EVIDENCE. For each row,
declare PASS, FAIL, or SKIP. Write a verdict file that downstream consumers
can grep for `OVERALL=PASS` or `OVERALL=FAIL`.

## Input contract

1. **manifest_path**: path to a populated eval manifest. Every row must be
   in a final state: `[x]` with non-empty EVIDENCE, `[SKIP]` with non-empty
   NOTE, or `[ ]` with non-empty NOTE describing the blocker.
2. **artifacts_root**: directory containing the artifacts the manifest's
   verification fields reference. May be unreadable (advisor sees only the
   manifest); the skill handles read-only mode.
3. **mode**: one of `verify` (re-run each verification target where
   possible) or `trust` (accept EVIDENCE as recorded).

## Output contract

A markdown file at `<workdir>/<task_name>_EVAL_VERDICT_v1.md` with:

- Top header naming the manifest path it judges.
- Mode line declaring `verify` or `trust`.
- Counts: `PASS_COUNT`, `FAIL_COUNT`, `SKIP_COUNT`, `OPEN_COUNT`, `OVERALL`.
- One line per `C-NNN` row in the manifest.

The line format:

```
C-NNN: PASS | FAIL | SKIP | OPEN -- <one-line basis>
```

`OVERALL` is `PASS` only when:

- `FAIL_COUNT == 0`
- `OPEN_COUNT == 0`
- Every `[x]` row has non-empty EVIDENCE
- Every `[SKIP]` row has non-empty NOTE

Any other state yields `OVERALL=FAIL` with the failing condition cited at
the top of the file.

## Procedure

1. **Read the manifest.** Parse each row into `(state, id, phase, subject,
   verification, expected, evidence, note)`.

2. **Run the integrity gates first.** If `C-FMT-ROW-SHAPE` or
   `C-FMT-NO-STACK` fail on the manifest as it stands, the verdict is
   `OVERALL=FAIL` with reason "manifest violates its own format rules";
   the advisor stops here.

3. **For each row, validate state.**
   - `[x]` row with empty EVIDENCE -> FAIL with reason "checked but no
     evidence recorded".
   - `[SKIP]` row with empty NOTE -> FAIL with reason "skipped without
     justification".
   - `[ ]` row with empty NOTE -> OPEN (not FAIL; the row is incomplete
     but the executor may not have intended to close it).
   - `[ ]` row with non-empty NOTE describing a blocker -> SKIP with the
     blocker as basis.

4. **In verify mode, re-run each row's verification target.**
   - File-existence rows: stat the path.
   - Grep rows: re-run the grep with the same pattern and scope.
   - Line-existence rows: grep the named log for the named pattern.
   - Compare result to `<expected>`. Match -> PASS. Mismatch -> FAIL with
     the diff captured.

5. **In trust mode, accept EVIDENCE without re-running.** Useful when the
   advisor session lacks access to the artifacts. The verdict file's mode
   line declares `trust`; downstream consumers know this is a read-only
   verdict.

6. **Compute counts and OVERALL.**

7. **Write the verdict file.** Use the same convention as the manifest:
   one line per row, no narrative, no reasoning beyond the one-line basis.

## Failure modes

| Failure | Symptom | Mitigation |
|---|---|---|
| Manifest has rows in `[ ]` state | OPEN_COUNT > 0 | Verdict declares OVERALL=FAIL; downstream stops; executor must close or NOTE the open rows. |
| EVIDENCE field is narrative not fact | Verify-mode re-run finds discrepancy | FAIL row cites the discrepancy. |
| Artifacts not readable | verify mode cannot run | Skill auto-falls-back to trust mode and flags it in the mode line. |
| Verdict file would be empty (no manifest rows) | manifest_path is wrong | Skill stops with explicit "manifest had zero C-NNN rows" error. |

## Related

- `skills/eval_criteria_create/SKILL.md` produced the input.
- `templates/verdict_template.md` is the empty skeleton this skill writes.
- `tools/lint_no_stack.sh` runs the integrity gates this skill verifies.
- `docs/FLAT_BOOLEAN_RULE.md §7` defines the closing-state semantics.
- `docs/FLAT_BOOLEAN_RULE.md §8` defines the verdict file shape.
