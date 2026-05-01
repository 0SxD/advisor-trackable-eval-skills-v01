# <TASK_NAME>_EVAL_CRITERIA_v1.md

> Plan: <path/to/plan.md>
> Format rules: see `docs/FLAT_BOOLEAN_RULE.md` (canonical).
> Row template:
>
>   `- [ ] C-NNN | <phase> | <subject> | <verification: file path or command> | <expected> | EVIDENCE: <one-line fact recorded by executor> | NOTE: <optional>`
>
> States: `[ ]` open, `[x]` passed, `[SKIP]` not applicable (NOTE field required).
> Two integrity gates must pass before the executor begins. See §5 and §6 of
> the canonical rule. The lint script is `tools/lint_no_stack.sh`.

---

## Phase <N> -- <phase title>

- [ ] C-PN-<SUBJECT>-<TAG> | <N> | <subject> | <file path or command> | <expected> | EVIDENCE: | NOTE:

## Phase <N+1> -- <phase title>

- [ ] C-PN1-<SUBJECT>-<TAG> | <N+1> | <subject> | <file path or command> | <expected> | EVIDENCE: | NOTE:

## Stop conditions -- inverse criteria

- [ ] C-STOP-<TAG> | stop | <stop condition did not trigger> | <verification target> | <expected> | EVIDENCE: | NOTE:

## Format-level integrity (advisor checks these even if everything else passes)

- [ ] C-FMT-NO-STACK | fmt | active rows do not stack two facts via conjunction | scan active rows excluding C-FMT-NO-STACK for the conjunctive trigger tokens defined in `docs/FLAT_BOOLEAN_RULE.md §3` | 0 hits | EVIDENCE: | NOTE: gate excludes its own row by ID
- [ ] C-FMT-ROW-SHAPE | fmt | every row matches the canonical pipe shape | grep `^- \[[ x]\] C-[A-Z0-9-]+ \| ` | match count equals total `^- \[` count | EVIDENCE: | NOTE:
- [ ] C-FMT-EVIDENCE-ON-CHECKED | fmt | every checked row has non-empty EVIDENCE | parse `^- \[x\]` rows | every such row has EVIDENCE field non-empty | EVIDENCE: | NOTE:
- [ ] C-FMT-NOTE-ON-SKIP | fmt | every SKIP row has non-empty NOTE | parse `\[SKIP\]` rows | every such row has NOTE field non-empty | EVIDENCE: | NOTE:

---

## End manifest -- expansion log

> Executor instruction: append a one-liner each time the manifest is materially
> updated (e.g. template expanded, new phase added).

- <YYYY-MM-DDTHH:MM> | created | initial template
