# advisor-trackable-eval-skills-v01

Composable eval skills that turn a phased plan into an advisor-trackable flat-boolean verification surface.

## Status

R&D / Experimental. Maintained by Sage / 0SxD as part of an ongoing prompt-engineering and agent-skills research portfolio.

## What this is

Two composable skills for turning a phased plan into a verification surface that an Opus advisor can review without re-running the workflow. The pattern is: one row = one fact = one verifiable observation. No row combines two clauses via conjunction. Each row points to a file path or command, names an expected output, and leaves an EVIDENCE field for the executor to fill in. On return, an advisor reads the manifest plus the named artifacts and writes a verdict file with PASS / FAIL / SKIP per row. Aligns with the AGENTS.md spec and the agentskills.io pattern for composable, host-agnostic skill bundles.

The format was developed iteratively against advisor review (see NOTICES.md). Related evaluation methodology appears in work such as RaR (arXiv:2507.17746) and checklist-driven evaluation research (arXiv:2507.18624).

## Layout

- `skills/eval_criteria_create/` - turns a phased plan into a flat-boolean manifest
- `skills/eval_verdict_write/` - turns a populated manifest plus artifacts into a verdict file
- `docs/FLAT_BOOLEAN_RULE.md` - canonical no-stacking specification
- `docs/HOW_IT_WORKS.md` - end-to-end workflow walkthrough
- `docs/WORKED_EXAMPLE.md` - annotated example
- `tools/lint_no_stack.sh` - integrity gate script (row-shape check + no-stack check)
- `examples/cli_publish_plan_v1.md` - real plan that produced the example manifest
- `examples/cli_publish_eval_manifest_v1.md` - 80-row flat-boolean manifest from that plan
- `AGENTS.md` - universal agent entry point; read this first
- `NOTICES.md` - attribution and origin notes
- `SESSION_LOG_2026-04-30.md` - full session record from the originating Cowork-Opus session

## Quick start

1. Plan the work as phased units.
2. For each unit, list the atomic facts the work produces.
3. Run `skills/eval_criteria_create/` against the plan; it emits a manifest with one row per atomic fact.
4. Validate the manifest with `tools/lint_no_stack.sh`.
5. The executor populates `EVIDENCE:` on each row as work completes.
6. On return, run `skills/eval_verdict_write/` to read the manifest plus artifacts and emit `<task>_VERDICT_v1.md`.

## License

MIT. See `LICENSE`.
Author: Sage / 0SxD

## Notes

This repo is part of an active R&D portfolio. Content may move, change, or be withdrawn. Issues welcome but reviews are best-effort.
