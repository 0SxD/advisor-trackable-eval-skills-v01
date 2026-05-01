# HOW_IT_WORKS.md

The bundle implements a three-session pattern: planner, executor, advisor.
Each session has a clean handoff to the next via two artifacts -- the
manifest and the verdict.

## The cycle

```
                       Phased Plan
                            │
                            ▼
       ┌──────────────── eval_criteria_create ─────────────────┐
       │  reads plan; writes one row per atomic fact            │
       └────────────────────────┬───────────────────────────────┘
                                ▼
                       MANIFEST (all rows [ ])
                                │
                                ▼  tools/lint_no_stack.sh
                          Gates A + B green
                                │
                                ▼
       ┌──────────────────── EXECUTOR ──────────────────────────┐
       │  reads manifest; performs each unit of work; fills      │
       │  EVIDENCE inline; flips [ ] to [x] or [SKIP]+NOTE       │
       └────────────────────────┬───────────────────────────────┘
                                ▼
                  MANIFEST (every row in final state)
                                │
                                ▼
       ┌──────────────── eval_verdict_write ────────────────────┐
       │  reads populated manifest plus referenced artifacts;    │
       │  ticks each row PASS / FAIL / SKIP; writes verdict      │
       └────────────────────────┬───────────────────────────────┘
                                ▼
                          VERDICT FILE
                  (PASS_COUNT, FAIL_COUNT, SKIP_COUNT,
                   OVERALL, one line per row)
```

## Why each session is its own actor

| Session | Sees | Cannot see | Why the boundary matters |
|---|---|---|---|
| Planner | The work to be done | Execution outcomes | Forces the planner to decompose into atomic facts before knowing how they will resolve |
| Executor | The manifest, the artifacts being produced | The plan rationale | Forces the executor to verify each fact against a path or command, not against intent |
| Advisor | The populated manifest, the artifacts on disk | The plan rationale, the executor's reasoning | Forces the advisor to read evidence as a stranger -- the same property that makes zero-context audit work |

Each boundary protects against a different failure mode. The planner-executor
boundary prevents the planner from quietly waving execution-time questions
into the manifest. The executor-advisor boundary prevents the executor from
substituting "I think this passed" for "the path exists at line N."

## What the executor records

EVIDENCE is a one-line fact, not a sentence. Examples:

| Bad EVIDENCE | Good EVIDENCE |
|---|---|
| `LICENSE was added` | `LICENSE size 11357 bytes, sha256 a8f...` |
| `em-dash sweep ran` | `grep -c '—' README.md = 0` |
| `Sage approved` | `CLI_QUESTIONS_FOR_SAGE.md line 207: ANSWER: confirmed wave-1 [143-protocol, ...]` |
| `runner has gh auth` | `00_RUN_THIS_TO_PUBLISH.ps1:42: gh auth status` |

The shape "path:line" or "command output" or "regex match" is mechanical.
The advisor on return can validate each by re-running, or trust it without
re-running, but in either case the fact is pinned to a verifiable artifact.

## What the advisor produces

The verdict file is a flat list of PASS / FAIL / SKIP per row plus a top-
level summary. It is not a narrative. The advisor's narrative belongs
elsewhere (a session summary, a chat reply). The verdict file's job is to
be the closing artifact that downstream consumers grep.

A verdict file with `OVERALL=PASS` and `FAIL_COUNT=0` is the trigger for
follow-on work to start. A verdict file with any FAIL is a stop signal that
specifies which row failed and why.

## When to use this bundle

When the work satisfies all three:

1. The plan decomposes into observable facts (file paths, grep results,
   command outputs).
2. The executor and advisor are different sessions, possibly different
   models, possibly different humans.
3. The advisor's review is the gate before downstream work proceeds.

Workflows that do not satisfy these (real-time pair work, work whose output
is one large artifact like a doc draft, work where the advisor sees the
session in flight) do not need this pattern. The cost of writing the
manifest is overhead they would not recoup.

## When the pattern fails

The pattern fails when the manifest is built but the executor does not
actually populate EVIDENCE. The advisor on return then ticks rows from
narrative ("the executor said this was done") which collapses the gate
back to compound trust. `tools/lint_no_stack.sh` does not catch this --
it only checks structure.

Mitigation: the verdict-write skill should refuse to declare OVERALL=PASS
when EVIDENCE fields are empty. The advisor catches it; the lint does not.
