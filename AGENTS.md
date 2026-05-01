# AGENTS.md

This repo is `advisor-trackable-eval-skills`. It packages two composable skills
that turn a phased plan into an advisor-trackable verification surface using
flat-boolean criteria. One row equals one fact. No row stacks two facts.

This file is the universal entry point for any AI coding or research agent
that opens this repository. Read this first. Then read the SKILL.md files
under `skills/` in any order.

## What this is

Two-skill bundle for compound verification workflows:

1. `eval_criteria_create` consumes a phased plan and emits a flat-boolean
   manifest with one row per atomic fact the work produces. Runs at planning
   time. Output is a checklist file the executor populates as work proceeds.

2. `eval_verdict_write` consumes a populated manifest plus the artifacts it
   references, ticks each row PASS / FAIL / SKIP, and emits a verdict file.
   Runs at advisor-return time after the executor reports complete. The
   verdict is the closing artifact for the workflow.

The bundle is host-agnostic and language-agnostic. Both skills work with any
plan whose work decomposes into observable facts. Originally extracted from
a CLI publish workflow where the same orchestrator session needed to plan
the work, hand off execution to a separate PowerShell session, and verify
on return without re-running the workflow.

## The rule

`docs/FLAT_BOOLEAN_RULE.md` is the canonical specification. It defines the
row template, the conjunction trigger token list, and the two integrity
gates the manifest must pass before the executor begins. Every other file
in this bundle references that doc by section. Do not restate the rule
elsewhere. Drift between restatements is the failure mode the bundle is
designed to eliminate.

## How to use

### From a planning session

1. Decompose the work into phased units.
2. For each unit, list the atomic facts the work produces (one file written,
   one grep result, one line in a log).
3. Run the `eval_criteria_create` skill against the plan. It emits a
   manifest under the working directory.
4. Lint the manifest with `tools/lint_no_stack.sh`. Fix any violation
   before handing the manifest to the executor.

### From an executor session

1. Read the manifest top to bottom.
2. As each fact becomes observable, fill the `EVIDENCE:` field on its row
   inline with a one-line fact (file path, grep output, log timestamp).
3. Tick `[ ]` to `[x]` only when EVIDENCE is non-empty and matches expected.
4. For rows that turn out not to apply, change `[ ]` to `[SKIP]` and fill
   the NOTE field with the reason.

### From an advisor-return session

1. Read the populated manifest.
2. For each row, validate EVIDENCE against the row's verification target.
   If the session has access to the artifacts, re-run the command and
   compare. If not, trust EVIDENCE and note the verdict is read-only.
3. Run the `eval_verdict_write` skill. It emits a verdict file with one
   line per row plus a top-level summary count.

## Layout

```
.
├── AGENTS.md                                      (this file)
├── README.md                                      (short orientation)
├── LICENSE                                        (Apache-2.0)
├── NOTICES.md                                     (attribution)
├── SESSION_LOG_2026-04-30.md                      (origin record)
├── docs/
│   ├── FLAT_BOOLEAN_RULE.md                       (CANONICAL)
│   ├── HOW_IT_WORKS.md                            (cycle diagram + prose)
│   └── WORKED_EXAMPLE.md                          (CLI publish walkthrough)
├── skills/
│   ├── eval_criteria_create/SKILL.md
│   └── eval_verdict_write/SKILL.md
├── templates/
│   ├── eval_manifest_template.md
│   └── verdict_template.md
├── tools/
│   └── lint_no_stack.sh
└── examples/
    ├── cli_publish_eval_manifest_v1.md            (worked example -- 80 rows)
    └── cli_publish_plan_v1.md                     (plan that produced it)
```

## License

Apache-2.0. See `LICENSE`.
