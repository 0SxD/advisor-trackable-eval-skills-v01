# Session log -- 2026-04-30

> Origin record for the advisor-trackable-eval-skills bundle.

## What this session was

Cowork-Opus session triggered by `/compound-engineering:ce-plan` with no feature
description. Sage's directive: produce a plan that lets an Opus advisor verify
completion on return, using flat-boolean criteria that cannot be stacked.

Targeted artifacts already on disk:

- `G:\My Drive\repo_staging\CLI_BOOT_HANDOFF.md`
- `G:\My Drive\repo_staging\CLI_PROGRESS_LOG.md`

(The CLI publish workflow paused at a Phase 3 gate. Resuming the workflow with
a verifiable closing surface was the concrete task.)

## What was produced

| Artifact | Path | Purpose |
|---|---|---|
| Plan | `SandBoxSetup\docs\plans\2026-04-30-001-feat-cli-publish-resume-eval-plan.md` | 10 implementation units covering Phases 2-8 plus Unit 10 advisor-return |
| Eval manifest | `G:\repo_staging\CLI_EVAL_CRITERIA_v1.md` | 80 flat-boolean rows, 8 phases, both integrity gates green |
| Pointer stub | `SandBoxSetup\docs\eval\cli_eval_pointer_2026-04-30.md` | One-line redirect from project to manifest |
| Bundle (this repo) | `G:\repo_staging\advisor-trackable-eval-skills-v01\` | Generalized skill bundle for the pattern |
| Bundle continuation prompt | `SandBoxSetup\wiki\handoffs\cli_boot_prompts\PROMPT_2026-04-30_advisor_trackable_eval_skills_bundle_continue.md` | Paste-and-go to finish the bundle without context drift |

## Sequence of work

1. Read the four primary-source files: boot handoff, progress log, questions
   bank, repo inventory.
2. Read the canonical IP scrub skill for tier-1 patterns.
3. Called advisor #1 -- locked the row template, separated the manifest from
   the plan, declared the G:-access precondition, skipped redundant research
   agents.
4. Wrote the plan with 10 implementation units.
5. Wrote the eval manifest with 78 initial rows in 8 phases plus stop-condition
   inverse criteria plus format-level integrity gates.
6. Ran the manifest's own integrity gates against itself.
7. Caught a self-triggering bug: the `C-FMT-NO-AND` row contained the
   conjunction trigger in its own body. Renamed to `C-FMT-NO-STACK` with
   self-exemption by ID.
8. Caught a template-row bug: per-repo Phase 4 templates inside code fences
   matched the format gate's regex. Indented templates by 4 spaces so the
   gate skips them until expansion.
9. Called advisor #2 -- caught a real blocker: `C-P8-MANIFEST-NO-OPEN`
   stacked two observables via "OR". Trigger list was AND-only and missed
   disjunction.
10. Split the row into `C-P8-ZERO-OPEN` and `C-P8-SKIPS-NOTED`. Added
    `C-P8-ADVISOR-INVOKED` for explicit verdict-file proof. Extended the
    trigger list to include OR-form. Reworded one Q-resolution row to use
    regex alternation instead of English "or".
11. Re-ran the canonical no-stack gate. Zero violations. Row count 80, all
    matching canonical shape.
12. Sage requested the work be packaged as a standalone skill bundle for
    publication. Drafted a six-element paste-and-go prompt with advisor
    #3 input, saved under `wiki/handoffs/cli_boot_prompts/`, executed.

## Lessons baked into the bundle

- **One row equals one fact.** A row with "and" or "or" inside hides a
  branch where the executor can pick which fact to record.
- **Self-exempt the gate row by ID, not by string contortion.** A row that
  describes the trigger token list will contain the trigger tokens. Excluding
  it by ID is robust; rewording the row to avoid its own trigger is fragile.
- **Templates inside code fences still match line-anchored regex.** Indent
  template rows so they fail the line anchor until the executor de-indents
  them on expansion.
- **The advisor catches what self-test does not.** The self-test gate said
  "no violations" because the trigger list missed disjunction. The advisor
  reading the manifest found the OR-stacked row in seconds.
- **Cp the worked example, do not regenerate it.** The byte-for-byte diff
  to canonical is the only way to catch context-pressure drift in a long
  build.

## Status at session close

- Plan: written, advisor-reviewed, complete.
- Manifest: written, both gates green, 80 rows, ready for executor.
- Bundle: 16 files (this log plus the 15-file build manifest plus README).
- Verdict skeleton: pending (Phase 7 of the prompt).
- Handoff: pending (Phase 7 of the prompt).
- Cowork agent target: takes the bundle path, the verdict path, and the
  handoff path; pushes the bundle as a public 0SxD repo per the publish
  workflow.

## Next session

The next session of this work picks up when the executor (Sage's PowerShell
or another CLI) has populated EVIDENCE on the manifest rows. At that point,
a new Opus advisor session reads the populated manifest and writes the
verdict file. See `skills/eval_verdict_write/SKILL.md`.
