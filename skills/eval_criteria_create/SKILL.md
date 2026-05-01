# skills/eval_criteria_create/SKILL.md

> Status: live
> Type: planner-time skill
> Inputs: a phased plan (markdown) plus a working directory
> Output: a flat-boolean manifest at `<workdir>/<task>_EVAL_CRITERIA_v1.md`
> Rule reference: see `docs/FLAT_BOOLEAN_RULE.md` (canonical) for the row
> template, the conjunction trigger token list, and the two integrity gates.

## Purpose

Turn a phased plan into an advisor-trackable manifest. One row per atomic
fact. No row stacks two facts. Both integrity gates green at write time.

## Input contract

1. **plan_path**: path to a markdown plan with phased implementation units.
   Each unit names files it touches and outcomes it produces.
2. **workdir**: directory where the manifest is written. Conventionally the
   same directory as the plan's working artifacts, NOT the plan's own
   directory.
3. **task_name**: short identifier used in the manifest filename.

## Output contract

A markdown file at `<workdir>/<task_name>_EVAL_CRITERIA_v1.md` with:

- Header naming the plan it derives from.
- A canonical row template block (copy from `docs/FLAT_BOOLEAN_RULE.md §2`).
- One section per phase from the plan. Each section contains one row per
  atomic fact the phase produces.
- Stop-condition inverse criteria (one row per stop condition the plan
  declares).
- Format-level integrity rows (`C-FMT-NO-STACK`, `C-FMT-ROW-SHAPE`,
  `C-FMT-EVIDENCE-ON-CHECKED`, `C-FMT-NOTE-ON-SKIP`).

Both integrity gates from `docs/FLAT_BOOLEAN_RULE.md §5` and `§6` must pass
on the manifest before the skill returns.

## Procedure

1. **Read the plan.** Extract phases, implementation units, and the
   verification field of each unit.

2. **For each unit, list atomic facts.** A fact is one of:
   - A file exists at a named path.
   - A file's content matches a named regex.
   - A grep over a named scope returns N matches (typically 0).
   - A line exists in a named log file matching a named pattern.
   - A command's output contains a named substring.

3. **Reject compound facts.** If a unit's verification reads "X and Y", the
   skill emits two rows. If it reads "X or Y" with two different observable
   outcomes, the skill stops and surfaces back to the planner -- the unit
   must be re-decomposed or the verification must be expressed as one regex.

4. **Compose row IDs.** Convention: `C-<PHASE>-<SUBJECT>-<TAG>` where TAG
   distinguishes facts within the same subject (e.g., `LIC`, `RBAN`, `EM`,
   `PII`, `SEC`). IDs must match `[A-Z0-9-]+`.

5. **Indent template rows by 4 spaces inside fenced code blocks.** Templates
   that name a placeholder (e.g., `<R>` for per-repo expansion) must not
   match the line anchor `^- \[`. Indenting prevents the integrity gates
   from tripping until the executor de-indents on expansion.

6. **Add stop-condition inverse rows.** For each stop condition the plan
   declares (per `cli_deep_dive_and_publish_prompt v1.0` Section 2 style),
   add a row asserting the condition did NOT trigger.

7. **Add format-level integrity rows.** Four rows that turn the manifest's
   own gates into criteria the advisor can verify.

8. **Run gates A and B against the new manifest.** If either fails, fix
   the violating row before returning. Surface to the planner if a fix is
   not obvious -- the planner's intent is the source of truth, not the
   skill's autocorrect.

## Output verification

Before returning, the skill validates:

- `grep -c '^- \[' MANIFEST.md` is non-zero.
- `grep -cE '^- \[[ x]\] C-[A-Z0-9-]+ \| '` matches the active row count.
- `grep -nE '^- \[[ x]\] C-' MANIFEST.md | grep -v 'C-FMT-NO-STACK' | grep -iE ' and | AND | & | plus | or | OR | either |, also '` is empty.

If any check fails, the skill reports the failing rows and does not declare
success.

## Failure modes

| Failure | Symptom | Mitigation |
|---|---|---|
| Plan's verification field is prose, not a path or command | Row's `<verification>` field is unparseable | Skill stops; planner must specify the artifact. |
| Unit produces an outcome with no observable (e.g., "the user is happy") | No row can be written for this unit | Skill stops; the unit is unverifiable. |
| Two units produce the same row ID | Manifest has duplicate IDs | Skill renames with a `-2` suffix and surfaces a warning. |
| Plan references files that do not exist yet | Verification target is a path that will exist post-execution | Allowed; the row's expected state is "post-execution". The skill only checks targets that should already exist. |

## Related

- `skills/eval_verdict_write/SKILL.md` consumes the output of this skill.
- `templates/eval_manifest_template.md` is the empty skeleton this skill
  starts from.
- `tools/lint_no_stack.sh` runs the gates this skill enforces.
- `examples/cli_publish_eval_manifest_v1.md` is a worked output of this
  skill against a real plan.
