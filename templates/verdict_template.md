# <TASK_NAME>_EVAL_VERDICT_v1.md

> Manifest: <path/to/MANIFEST.md>
> Mode: <verify | trust>
> Written: <YYYY-MM-DD by advisor session>
> Format rules: see `docs/FLAT_BOOLEAN_RULE.md §8`.

## Counts

- PASS_COUNT: <N>
- FAIL_COUNT: <N>
- SKIP_COUNT: <N>
- OPEN_COUNT: <N>
- OVERALL: <PASS | FAIL>

## Overall basis

<One paragraph stating the basis for OVERALL. If FAIL, name the first failing
row and the failing condition.>

## Per-row verdict

> One line per `C-NNN` row in the manifest, in row order. Format:
> `C-NNN: <PASS | FAIL | SKIP | OPEN> -- <one-line basis>`

C-NNN: PENDING -- <basis once advisor has read this row>

## End verdict
