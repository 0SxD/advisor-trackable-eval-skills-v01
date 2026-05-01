# FLAT_BOOLEAN_RULE.md (canonical)

> This file is the single source of truth for the no-stacking rule, the row
> template, the conjunction trigger token list, and the two integrity gates.
> Every other file in this bundle references this doc by section. Do not
> restate the rule elsewhere.

## §1. The rule

One row equals one fact equals one verifiable observation. No row may combine
two clauses via a conjunction (English or symbolic). The executor records
EVIDENCE inline as a one-line fact. The advisor on return ticks each row
against the EVIDENCE plus, where possible, a re-run of the verification
target.

The rule's purpose is to prevent the most common compound-eval failure mode:
a row that says "all X have Y" lets the executor tick the box without doing
the work for every X. A flat row ("X[1] has Y at path Z") forces a specific
file or grep result before the box can be ticked.

## §2. Row template

```
- [ ] C-NNN | <phase> | <subject> | <verification: file path or command> | <expected> | EVIDENCE: <one-line fact recorded by executor> | NOTE: <optional>
```

| Field | Purpose | Filled by |
|---|---|---|
| `- [ ]` | Open state. Becomes `- [x]` on pass, `- [SKIP]` on not-applicable. | Executor |
| `C-NNN` | Unique row ID. Conventionally `C-<PHASE>-<SUBJECT>-<TAG>`. Must match `[A-Z0-9-]+`. | Author |
| `<phase>` | Workflow phase number or name. | Author |
| `<subject>` | What the row is about. One noun phrase, no verbs. | Author |
| `<verification>` | A file path OR a command. NOT a description. | Author |
| `<expected>` | One observable outcome. NOT a list of outcomes. | Author |
| `EVIDENCE:` | A one-line fact captured at execution time. Empty until then. | Executor |
| `NOTE:` | Optional. Required for `[SKIP]`. | Executor |

## §3. Conjunction trigger tokens

The C-FMT-NO-STACK gate scans every active row body for any of these literal
substrings. A hit means the row stacks two facts and must be split before
the executor begins.

| Token (literal substring) | Why it stacks |
|---|---|
| ` and ` (space-conjunction-space, lowercase) | Combines two clauses |
| ` AND ` (space-conjunction-space, uppercase) | Combines two clauses |
| ` & ` (space-ampersand-space) | Combines two clauses |
| ` plus ` (space-plus-space, prose form) | Combines two clauses |
| ` or ` (space-disjunction-space, lowercase) | Lets the executor pass on either branch |
| ` OR ` (space-disjunction-space, uppercase) | Same |
| ` either ` | Implicit disjunction |
| `, also ` | Combines two clauses |
| `; ` followed by another verb in same field | Combines two clauses |

## §4. Regex alternation is allowed

A `<verification>` field may contain regex alternation describing one
observable. For example:

```
| grep regex `^(ANSWER|DEFAULT_ACCEPTED):` after Q-001 block | one matching line |
```

This is one observable (a line matching either capture). It is not stacking.

English prose disjunction ("X or Y") is NOT allowed. It permits the executor
to record either fact, which is the failure mode the rule prevents. Express
the observable as one regex; do not split it across English.

## §5. Integrity gate A -- row shape

Every active row matches the canonical pipe shape. Definition:

```
^- \[[ x]\] C-[A-Z0-9-]+ \| 
```

The gate command:

```
TOTAL=$(grep -c '^- \[' MANIFEST.md)
SHAPED=$(grep -cE '^- \[[ x]\] C-[A-Z0-9-]+ \| ' MANIFEST.md)
[ "$TOTAL" = "$SHAPED" ] || echo "GATE_A_FAIL"
```

Templates inside code fences are exempt because they should not match the
line anchor. Indent template rows by 4 spaces inside fenced blocks. Executors
de-indent them when expanding the template.

`[SKIP]` rows match a separate shape:

```
^- \[SKIP\] C-[A-Z0-9-]+ \| 
```

Both shapes pass the gate when both shape regexes are summed.

## §6. Integrity gate B -- no stacking

No active row body contains any conjunction trigger token from §3, except
the `C-FMT-NO-STACK` row itself which is exempt by ID.

The gate command:

```
grep -nE '^- \[[ x]\] C-' MANIFEST.md \
  | grep -v 'C-FMT-NO-STACK' \
  | grep -iE ' and | AND | & | plus | or | OR | either |, also '
```

Expected output: empty. Any line returned is a stacking violation.

The script `tools/lint_no_stack.sh` runs both gates A and B over a target
file or every `.md` file in a target directory.

## §7. Closing-state semantics

At workflow close, every row must be in one of three states:

| State | Visual | Meaning | Required field |
|---|---|---|---|
| Pass | `- [x]` | The verification was performed and matched expected. | EVIDENCE |
| Skip | `- [SKIP]` | The row turned out not to apply. | NOTE |
| Open | `- [ ]` | Allowed only when accompanied by an explicit blocker NOTE. | NOTE |

A workflow with any `- [ ]` row lacking a NOTE field is incomplete. The
verdict-write step refuses to declare OVERALL=PASS until every row reaches
a final state.

## §8. Verdict file shape

The verdict file written by the advisor on return contains:

- A top header naming the manifest it judges.
- Counts: `PASS_COUNT`, `FAIL_COUNT`, `SKIP_COUNT`, `OVERALL`.
- One line per `C-NNN` row in the manifest, in the form:
  `C-NNN: PASS | FAIL | SKIP -- <one-line basis>`.

`OVERALL` is `PASS` only if `FAIL_COUNT == 0` and there are no open rows
without NOTE.

## §9. Self-exemption rule

The C-FMT-NO-STACK row in any manifest describes the trigger token list and
will therefore contain trigger tokens. The gate excludes its own row by ID
(`grep -v 'C-FMT-NO-STACK'`). Do not attempt to reword the row to avoid the
trigger -- that path leads to drift between the manifest's gate row and the
canonical rule. Self-exemption by ID is the robust pattern.
