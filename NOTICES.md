# NOTICES

advisor-trackable-eval-skills

Copyright 2026 Sage (0SxD)

Licensed under the Apache License, Version 2.0 (the "License"). See `LICENSE`
in this directory for the full text.

## Origin

This bundle was extracted on 2026-04-30 from a Cowork-Opus session that
planned a 0SxD GitHub publication workflow and needed an advisor-trackable
verification surface for the executor's return. The pattern that emerged --
one row per fact, no stacking, executor records EVIDENCE inline, advisor
writes a verdict file -- generalizes beyond that workflow.

The session that produced the bundle is recorded in `SESSION_LOG_2026-04-30.md`.

## Attribution

The flat-boolean criterion pattern was iterated against advisor review during
the originating session. The advisor caught two bugs the executor missed:

1. The `C-FMT-NO-AND` integrity-gate row stacked the conjunction trigger
   into its own row body, self-triggering the gate. Renamed and reworded as
   `C-FMT-NO-STACK` with self-exemption by ID.
2. A closing-phase row used "OR" to permit either of two observables.
   Caught only because the gate trigger list was extended to include
   disjunction tokens. Split into two flat rows.

The `docs/FLAT_BOOLEAN_RULE.md` trigger token list and the lint script
encode both lessons.

## Dependencies

This bundle has no runtime dependencies. The lint script is plain bash
plus `grep`, `find`, and `wc`. Both skills are markdown specs that name
the dispatch contract; the dispatch itself happens in the host agent.
