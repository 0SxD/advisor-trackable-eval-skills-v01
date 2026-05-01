---
title: "feat: Resume CLI publish workflow with flat-boolean advisor-trackable eval"
type: feat
status: active
date: 2026-04-30
origin: G:\My Drive\repo_staging\CLI_BOOT_HANDOFF.md (chat-source: cli_deep_dive_and_publish_prompt v1.0)
related_plans:
  - docs/plans/2026-04-29-001-feat-github-publication-sprint-plan.md
  - docs/plans/2026-04-29-002-feat-orchestrated-github-publication-extension-plan.md
artifacts:
  primary_eval_manifest: G:\My Drive\repo_staging\CLI_EVAL_CRITERIA_v1.md
  pointer_in_repo: docs/eval/cli_eval_pointer_2026-04-30.md
---

# Resume CLI Publish Workflow with Flat-Boolean Advisor-Trackable Eval

## Overview

Cowork-Opus session 2026-04-30 ran phases 0-1 of `cli_deep_dive_and_publish_prompt v1.0`,
hit `Phase 3 GATE` awaiting Sage's wave-1 confirmation, and deferred all `gh` /
`gitleaks` work to a generated PowerShell runner. This plan resumes from the open gate
through to a public 0SxD wave-1 and a closing run report. It pairs the work with an
external evaluation manifest where every checkpoint is one flat boolean — no compound
"X AND Y" rows — so the Opus advisor can read the manifest plus the on-disk artifacts
on return and tick each criterion independently.

The plan describes the work. The manifest is the verification surface. They are
intentionally decoupled per advisor guidance.

## Problem Frame

- The publish run is paused at the Phase 3 gate. CLI_QUESTIONS_FOR_SAGE.md holds 15
  open questions (Q-001 through Q-015), 14 with proposed defaults and one (Q-015)
  asking Sage to confirm or modify wave-1.
- The 2026-04-29 sprint master plan describes the publish goal at a strategic level.
  The CLI prompt v1.0 specifies the operational sequence. Neither produces a
  mechanical checklist that an advisor session can validate after the executor exits.
- Past sessions have ended with claims of completion that did not survive a zero-
  context audit. Sage's standing rule (`feedback_adversarial_review_before_done.md`)
  is to spawn a zero-context reviewer before declaring a non-trivial task done.
- The format itself must prevent stacking. A row that says "Phase 4 done for repo R"
  hides a dozen sub-facts. Splitting each into its own row makes lying impossible
  without lying about a specific file or grep result.

## Requirements Trace

- R1. Resume execution from the Phase 3 gate without re-running phases already logged
  as complete in `CLI_PROGRESS_LOG.md`.
- R2. Honor every Sage authority recorded in `CLI_BOOT_HANDOFF.md` "Authority recorded
  this turn" (items 1-9), particularly the trading-IP scrub rule and the batch-confirm
  visibility-flip workaround.
- R3. Produce one verification row per atomic fact. No row may combine two
  independent facts. (Format-level enforcement, not just intent.)
- R4. Each row in the eval manifest must be checkable by either reading a named file
  at a named line, or running a named command and matching expected output.
- R5. The executor populates the EVIDENCE field of each row inline with concrete
  output (path, line, grep result) so the advisor on return is read-only safe.
- R6. The advisor on return can declare PASS/FAIL/SKIP per row and write a verdict
  file without needing to re-run the workflow.
- R7. Stop-conditions from `cli_deep_dive_and_publish_prompt v1.0` Section 2 are
  represented as flat criteria so the advisor can confirm none triggered.
- R8. Sage's IP exclusion list (canonical at
  `G:\My Drive\repo_staging\anthropic-app-os-v1\anthropic_app_OS_v1\skills\ip_scrub_pre_publish.md`)
  governs Phase 4 PII/IP scrub criteria.

## Scope Boundaries

- This plan does not change the published prompt v1.0 sequence. It instruments it.
- This plan does not author the `00_RUN_THIS_TO_PUBLISH.ps1` runner content here —
  Unit 5 specifies what the runner must do; the runner script itself is produced
  during execution.
- This plan does not pre-decide Q-005 through Q-015. Each unanswered question is its
  own flat criterion that the executor records once Sage answers (or once the default
  is taken explicitly).
- This plan does not perform the actual `gh repo create` or visibility flip. Those
  remain Sage's PowerShell session per the deferral in CLI_BOOT_HANDOFF.md.

### Deferred to Separate Tasks

- Wave-2 publishing (compounding-learning-os, github-curator-v01, etc.): out of
  scope for this plan; will be a follow-up plan once wave-1 is publicly verified.
- C: drive secondary scan candidates (Phase 7 output) that turn out to be publish-
  worthy: out of scope for publication here; the inventory file is the deliverable.

## Context & Research

### Primary sources (read this session)

- `G:\My Drive\repo_staging\CLI_BOOT_HANDOFF.md` (authority + phase plan + deviations)
- `G:\My Drive\repo_staging\CLI_PROGRESS_LOG.md` (current state through Phase 3 gate)
- `G:\My Drive\repo_staging\CLI_QUESTIONS_FOR_SAGE.md` (Q-001 through Q-015)
- `G:\My Drive\repo_staging\REPO_INVENTORY_v1.md` (canonical wave-1 candidates +
  quarantine + empty stubs + 10 surfaced questions)
- `G:\My Drive\repo_staging\anthropic-app-os-v1\anthropic_app_OS_v1\skills\ip_scrub_pre_publish.md`
  (tier-1 / tier-2 / tier-3 IP exclusion list — canonical)

### Carry-forward from memory (already in context)

- Adversarial review before done is a standing rule (`feedback_adversarial_review_before_done.md`).
- Source re-verification after compaction is required (`feedback_source_reverification_after_compaction.md`)
  — the executor must re-read the prompt + ip_scrub skill at the start of each
  resumed session, not work from paraphrase.
- Opus orchestrator role (`feedback_opus_orchestrator_role.md`) — the executor in
  this plan is a Sonnet sub-agent or Sage himself running PowerShell; Opus reads,
  advises, and reviews on return.

### Institutional learnings (not re-fetched; already-known)

- Cowork sandbox cannot run `gh` or `gitleaks` and cannot see the G:\ tree from
  bash; only Windows-side Read/Glob/Edit/Write reach G:\. Plan units that grep over
  G:\ must be wired through the Windows-side toolchain or a real CLI session.
- The "no em-dash" canary applies to all published artifacts (CLAUDE.md canary tag).

### External research

Skipped per advisor guidance. The four primary-source files above plus the ip_scrub
skill cover every decision needed for this plan. External best-practice research
would not change the structure.

## Key Technical Decisions

- **Eval manifest is a separate file**, not a section of this plan. Path:
  `G:\My Drive\repo_staging\CLI_EVAL_CRITERIA_v1.md`. A pointer stub at
  `docs/eval/cli_eval_pointer_2026-04-30.md` mirrors the path so the SandBoxSetup
  side is greppable. Rationale: the advisor on return reads a flat checklist, not
  narrative; decoupling protects the manifest from plan-prose edits.
- **Row format is single-fact-per-row, with grep-friendly ID prefix.** Format:
  `- [ ] C-NNN | <phase> | <subject> | <verification: file path or command> | <expected> | EVIDENCE: <executor-recorded one-line fact> | NOTE: <optional>`
  Each pipe segment is a single field. No conjunctions allowed inside any field.
- **Executor records evidence inline**; advisor is read-only safe. If the advisor
  session has G:\ access it may spot-check by re-running a command, but it must not
  be required.
- **Phase 4 criteria are template-expanded once Q-015 confirms wave-1.** The
  manifest contains the per-repo template plus a placeholder block for each wave-1
  candidate; the executor expands `<R>` to actual repo names as Phase 4 begins.
- **Stop conditions are inverse criteria.** Each Section 2 stop condition becomes a
  "did NOT trigger" row, so the advisor confirms a clean run rather than scanning
  for the absence of an alarm.
- **G:\ visibility precondition.** The plan declares that the advisor session must
  be launched from a context with G:\My Drive read access. If that is not
  available, the manifest is mirrored under `docs/eval/cli_eval_mirror/` before
  return, and the advisor reads the mirror. Unit 9 enforces this.

## Open Questions

### Resolved during planning

- "Should the eval manifest live in the plan or separately?" → Separate file at
  G:\repo_staging\, per advisor.
- "Should each criterion be checkable by command or by recorded evidence?" → Both
  fields exist on every row; executor populates EVIDENCE; advisor may run the
  command if it has tools, otherwise reads EVIDENCE.
- "Are wave-1 picks fixed?" → No. Phase 3 gate is open. Q-015 must resolve before
  Phase 4 begins. Manifest contains a template, not pre-baked rows for wave-1.
- "Does the plan re-do work already in CLI_PROGRESS_LOG?" → No. Phases 0, 1, and
  the Phase 2 confirmed-quarantine subset are already recorded as complete; the
  manifest's Phase 0/1/2 rows reference the existing log lines as evidence rather
  than re-running.

### Deferred to implementation

- Exact runner content (`00_RUN_THIS_TO_PUBLISH.ps1`) — Unit 5 sets requirements;
  the script body is produced at execution time.
- Whether Q-007/Q-008 (WizAi, cloud-infrastructure placeholders) get a
  README+LICENSE seed or stay private. Default if no Sage answer: stay private and
  add no rows to wave-1.
- Whether the Sage-supplied `ce-review` 14-reviewer pass is added as Gate 4 (per
  Q-003). Default: sonnet zero-context audit replaces it.
- Banner copy itself. The exact banner string for `README.md` is TBD by Sage; the
  manifest checks for "first 30 lines contain a banner block" as a structural fact,
  not specific phrasing.

## High-Level Technical Design

> *This illustrates the intended verification surface and is directional guidance for
> review, not implementation specification.*

```
                       cli_deep_dive_and_publish_prompt v1.0
                                       │
                       ┌───────────────┼────────────────┐
                       ▼               ▼                ▼
                CLI_BOOT_HANDOFF  CLI_PROGRESS_LOG  CLI_QUESTIONS_FOR_SAGE
                   (authority)      (state)          (open Qs Q-001..Q-015)
                       │               │                │
                       └────────────┬──┴────────────────┘
                                    ▼
                   ┌───────────────────────────────────┐
                   │   CLI_EVAL_CRITERIA_v1.md         │
                   │   (flat-boolean checklist)        │
                   │                                   │
                   │   Phase 3  : Sage gate Q-rows     │
                   │   Phase 4  : per-repo template    │
                   │             (expanded × N repos)  │
                   │   Phase 5  : runner shape rows    │
                   │             post-exec rows        │
                   │   Phase 6  : sub-agent probes     │
                   │   Phase 7  : C: drive scan        │
                   │   Phase 8  : closing rows         │
                   │   Stops    : inverse criteria     │
                   └────────────────┬──────────────────┘
                                    │ executor populates EVIDENCE
                                    ▼
                   ┌───────────────────────────────────┐
                   │   advisor() on return             │
                   │   reads manifest + artifacts      │
                   │   ticks each row PASS/FAIL/SKIP   │
                   │   writes CLI_EVAL_VERDICT_v1.md   │
                   └───────────────────────────────────┘
```

Row template (reproduced from Key Technical Decisions for clarity):

```
- [ ] C-NNN | <phase> | <subject> | <verification: file path or command> | <expected> | EVIDENCE: <one-line fact> | NOTE: <optional>
```

Stacking traps and how the format prevents them (worked examples):

| Tempting compound row | Why it stacks | Flat replacement |
|---|---|---|
| "All wave-1 repos have LICENSE" | one tick hides N facts | one row per repo |
| "Phase 4 staging complete for R" | bundles LICENSE + banner + em-dash + PII + secrets + .gitignore + report | 7 rows per repo |
| "No secrets anywhere" | bundles N patterns × M repos | one row per repo, expected output is the joint regex's empty match |
| "Sage approved gate" | bundles 15 questions | one row per Q-NNN |

## Implementation Units

- [ ] **Unit 1: Bootstrap eval manifest at G:\repo_staging\CLI_EVAL_CRITERIA_v1.md**

**Goal:** Create the flat-boolean checklist file with all Phase 0/1/2/3/5/6/7/8 rows
populated and the Phase 4 per-repo template ready for expansion. Mirror a one-line
pointer in SandBoxSetup at `docs/eval/cli_eval_pointer_2026-04-30.md`.

**Requirements:** R3, R4, R5, R7

**Dependencies:** none (this plan is the source spec)

**Files:**
- Create: `G:\My Drive\repo_staging\CLI_EVAL_CRITERIA_v1.md`
- Create: `docs/eval/cli_eval_pointer_2026-04-30.md`

**Approach:**
- Write manifest with sections per phase, one criterion per row, format strictly
  matches the row template.
- Each row's `<verification>` field names a path or command, not a description.
- EVIDENCE field starts empty; executor fills as work progresses.
- Pointer stub gives the absolute G:\ path and a one-line "this is the active eval
  manifest for the 2026-04-30 CLI publish run" caption.

**Patterns to follow:**
- Format style of CLI_PROGRESS_LOG.md (append-only, ISO timestamps when evidence
  references log lines).
- ip_scrub_pre_publish.md tier-1 patterns for the PII / secret rows.

**Test scenarios:**
- Happy path: manifest exists at the named path; first row is `C-001`; final row
  before stops section is the highest-numbered Phase 8 row.
- Edge case: no row contains the substring " AND " or " and " inside any field
  (a flat-format gate; one grep proves no stacking).
- Edge case: every row matches the regex `^- \[ \] C-[A-Z0-9-]+ \| ` (one structural
  grep proves uniformity).
- Integration: pointer stub at SandBoxSetup side resolves to the G:\ path that
  exists.

**Verification:**
- `wc -l CLI_EVAL_CRITERIA_v1.md` returns at least one row per known criterion in
  this plan, plus headers.
- `grep -c '^- \[ \] C-' CLI_EVAL_CRITERIA_v1.md` matches expected row count.
- `grep -ic ' AND \| and ' CLI_EVAL_CRITERIA_v1.md` returns 0 hits inside any row
  body (header text is permitted).

---

- [ ] **Unit 2: Resolve Phase 3 gate — record answers to Q-001 through Q-015**

**Goal:** For every question in CLI_QUESTIONS_FOR_SAGE.md, append `ANSWER:` line
with Sage's reply or an explicit `DEFAULT_ACCEPTED:` line citing the Q's stated
default. Update the corresponding C-NNN rows in the eval manifest with EVIDENCE
pointing to the answered Q.

**Requirements:** R1, R2, R3, R5

**Dependencies:** Unit 1

**Files:**
- Modify: `G:\My Drive\repo_staging\CLI_QUESTIONS_FOR_SAGE.md`
- Modify: `G:\My Drive\repo_staging\CLI_EVAL_CRITERIA_v1.md` (fill EVIDENCE for
  Phase 3 rows)
- Append: `G:\My Drive\repo_staging\CLI_PROGRESS_LOG.md` (one line per resolution)

**Approach:**
- For each Q-NNN, surface the question to Sage. If Sage answers, append
  `ANSWER: <verbatim text>` under the question.
- If Sage signals "use default" (or remains silent past the gate window), append
  `DEFAULT_ACCEPTED: <verbatim default text from the Q body>`.
- Q-015 (wave-1 list) is the highest-leverage answer because it determines how Unit
  3's per-repo template expands.
- Q-005 (canonical SageX plugin name) determines whether `agent-skills-plugin-v01`
  or `agent-plugin-skills-v01` enters wave-1.

**Patterns to follow:**
- CLI_QUESTIONS_FOR_SAGE.md existing question block format (`## Q-NNN | <phase> |
  <date> | <one-line>`).

**Test scenarios:**
- Happy path: every Q-NNN block has either `ANSWER:` or `DEFAULT_ACCEPTED:` as a
  later line. Grep `^Q-` and grep `^ANSWER:\|^DEFAULT_ACCEPTED:` counts match.
- Edge case (Sage modifies wave-1): Q-015 ANSWER lists 5 repo names; those names
  are the ones expanded in Unit 3, others ignored.
- Error path: Sage answers a Q with "needs more info" — that Q's row stays
  unchecked and the executor stops Phase 4 for any unit that depended on it.
- Integration: every C-NNN row in the manifest's Phase 3 section has EVIDENCE
  populated before Unit 3 starts.

**Verification:**
- `grep -c '^Q-' CLI_QUESTIONS_FOR_SAGE.md` equals `grep -c '^ANSWER:\|^DEFAULT_ACCEPTED:' CLI_QUESTIONS_FOR_SAGE.md`.
- Manifest Phase 3 rows all have non-empty EVIDENCE field.
- Q-015 ANSWER (or default) names exactly 5 repo identifiers.

---

- [ ] **Unit 3: Expand Phase 4 per-repo criteria for confirmed wave-1**

**Goal:** Once Q-015 is resolved, replace the `<R>` template block in the manifest
with an expanded copy for each confirmed wave-1 repo. Each repo gets the same 7
flat criteria (LICENSE, banner, em-dash, tier-1 PII, secrets, .gitignore, report).

**Requirements:** R3, R4, R8

**Dependencies:** Unit 2 (specifically Q-015 resolved)

**Files:**
- Modify: `G:\My Drive\repo_staging\CLI_EVAL_CRITERIA_v1.md`

**Approach:**
- Read confirmed wave-1 from the Q-015 ANSWER line.
- For each repo R, copy the template block and string-substitute `<R>` with the
  repo name. ID each criterion `C-PHASE4-<R>-<TAG>` where TAG ∈
  {LIC, RBAN, EM, PII, SEC, GI, RPT}.
- EVIDENCE field stays empty; Unit 4 fills it.
- Quarantine list expansion is implicit: any repo named in REPO_INVENTORY_v1.md
  "Quarantine confirmed" section becomes a `C-QUAR-<R>` row asserting that the
  folder is moved under `DO_NOT_PUBLISH/` (one row per quarantined folder).

**Patterns to follow:**
- ip_scrub_pre_publish.md tier-1 list — the PII row's command must use the union
  regex of every tier-1 personal-identity and trading-strategy pattern.

**Test scenarios:**
- Happy path: 5 wave-1 repos × 7 criteria = 35 expanded rows. Grep proves count.
- Edge case (wave-1 has 4 or 6 repos): row count adjusts; no orphan template `<R>`
  string remains in the manifest.
- Edge case (quarantine count): 7 quarantine `C-QUAR-` rows per REPO_INVENTORY's 7
  confirmed quarantine entries.
- Integration: every expanded row's `<verification>` references a real path that
  will exist after Unit 4 runs (no row asserts a path the executor would not
  create).

**Verification:**
- Manifest has zero remaining `<R>` placeholder tokens.
- Phase 4 row count equals (wave-1 size × 7) + quarantine count.
- Every Phase 4 row's EVIDENCE field is empty (Unit 3 only expands; Unit 4 fills).

---

- [ ] **Unit 4: Per-repo Phase 4 staging (one wave-1 repo at a time)**

**Goal:** For each wave-1 repo, perform LICENSE add (if missing), README banner
prepend, em-dash sweep, tier-1 PII scrub, secret-pattern grep, `.gitignore` write,
and per-repo report write. Fill EVIDENCE for each row as the work completes.

**Requirements:** R1, R2, R3, R5, R8

**Dependencies:** Unit 3

**Files:**
- Per repo R: modify `G:\My Drive\repo_staging\<R>\LICENSE` (create if missing),
  `<R>\README.md`, any `.md` files containing em-dashes or tier-1 patterns,
  `<R>\.gitignore`. Create `G:\My Drive\repo_staging\REPORT_<R>_v1.md`.
- Modify: `G:\My Drive\repo_staging\CLI_EVAL_CRITERIA_v1.md` (EVIDENCE per row)
- Append: `G:\My Drive\repo_staging\CLI_PROGRESS_LOG.md`

**Approach:**
- One repo per pass. Do not parallelize across repos in this unit (avoids cross-
  contamination of evidence and lets the executor stop cleanly mid-wave on a hit).
- LICENSE: copy the license type recorded in REPO_INVENTORY_v1.md; if UNKNOWN, use
  Sage's default (MIT for skills, Apache-2.0 for tooling) per Q-014/Q-007 style
  defaults — cite the source in EVIDENCE.
- Banner: prepend a generic capability-claim block per Sage authority item 2
  (no strategy / indicator / performance details). Banner content is plan-deferred;
  this unit only asserts structural presence.
- Em-dash sweep: grep `—` over `<R>/**/*.md` and replace with " -- " (per the
  no-em-dash canary). Final EVIDENCE: `grep -rn '—' <R>` returns 0 lines.
- Tier-1 PII scrub: grep the union of ip_scrub_pre_publish.md tier-1 patterns over
  `<R>/`. Any HIT is a HARD BLOCK for that repo — leave its row unchecked and
  surface to Sage. EVIDENCE on PASS: empty grep output captured verbatim.
- Secret-pattern grep: separate row from PII per advisor (different pattern set).
- `.gitignore`: write a default block (`.claude/`, `.env`, `*.log`, `node_modules/`,
  `__pycache__/`, `mlruns/`, `*.pyc`).
- Per-repo report: write `REPORT_<R>_v1.md` with a per-criterion table mirroring
  this repo's manifest rows.

**Execution note:** Run the tier-1 PII grep BEFORE making any modifications to a
repo. A HARD BLOCK at this stage means the repo is removed from wave-1 and
re-quarantined; the manifest row stays unchecked with EVIDENCE pointing to the
hit.

**Patterns to follow:**
- ip_scrub_pre_publish.md tier-1, tier-2, tier-3 ordering.
- Existing `LICENSE` and `README.md` shape from `143-protocol/` (cleanest wave-1
  candidate per inventory).

**Test scenarios:**
- Happy path per repo: all 7 criteria pass; report file exists; manifest rows for
  this repo all have non-empty EVIDENCE and `[x]`.
- Edge case (LICENSE already present with correct type): EVIDENCE records "already
  present, type matches inventory"; row passes without rewrite.
- Error path (tier-1 PII hit): row stays `[ ]`; report records the hit; repo
  removed from runner manifest in Unit 5.
- Error path (em-dash residue after sweep): grep returns >0; row stays `[ ]`;
  executor surfaces the unmodifiable file (e.g. binary or PDF) to Sage.
- Integration: after this unit, wave-1's row count in manifest with `[x]` checked
  equals (passing-repos × 7); no row is `[x]` while another row for the same repo
  is `[ ]`.

**Verification:**
- Per repo, `grep -c "^- \[x\] C-PHASE4-<R>-" CLI_EVAL_CRITERIA_v1.md` equals 7
  for any repo that survived staging.
- Each `REPORT_<R>_v1.md` exists and contains a row for every criterion.

---

- [ ] **Unit 5: Generate `00_RUN_THIS_TO_PUBLISH.ps1` runner**

**Goal:** Produce the PowerShell runner that performs the deferred bash-side work
(`git init`, commit, gitleaks, `gh repo create`, push, defensive gitleaks, `gh
repo edit --visibility public`, `gh repo view --json visibility`). The runner reads
its repo list from a preamble in `REPO_URL_MANIFEST.md` and processes one batch at
a time with a `[Y/n]` confirm prompt between batches.

**Requirements:** R1, R2, R3, R7

**Dependencies:** Unit 4 (only repos with all 7 criteria checked enter the runner
manifest)

**Files:**
- Create: `G:\My Drive\repo_staging\00_RUN_THIS_TO_PUBLISH.ps1`
- Modify: `G:\My Drive\repo_staging\REPO_URL_MANIFEST.md` (preamble lists wave-1)
- Modify: `G:\My Drive\repo_staging\CLI_EVAL_CRITERIA_v1.md` (Phase 5 runner-shape
  rows filled)

**Approach:**
- Pre-flight section in the runner: `gh auth status`, `gitleaks version`, git
  config check. Exit non-zero on any miss.
- Per-repo loop steps as enumerated in CLI_QUESTIONS_FOR_SAGE.md Q-001 body
  (canonical sequence).
- Batch confirm: 5 repos per batch (default; modifiable via Q-004 ANSWER), prompts
  `[Y/n] flip batch N to public?` between batches.
- Runner emits its own log lines into CLI_PROGRESS_LOG.md format so the manifest's
  Phase 5 EVIDENCE rows can cite log timestamps.

**Execution note:** Runner is generated but NOT executed in this unit. Sage runs
it from his real PowerShell session. Unit 6 records post-execution evidence.

**Patterns to follow:**
- Q-001 body in CLI_QUESTIONS_FOR_SAGE.md — verbatim sequence of `gh` and
  `gitleaks` calls.
- Sage authority item 8 — batch-confirm gate replaces auto-flip.

**Test scenarios:**
- Happy path: runner exists; `Get-Content` shows pre-flight, per-repo loop, and
  batch-confirm prompt. Each runner-shape manifest row passes.
- Edge case (gh not authenticated): runner pre-flight exits 1; manifest row
  C-PHASE5-RUNNER-AUTH-CHECK records the exit-on-fail behavior.
- Error path (gitleaks finds secret in defensive scan): runner halts before flip;
  Sage triages.
- Integration: REPO_URL_MANIFEST.md preamble lists exactly the wave-1 repos that
  passed all 7 Phase 4 criteria; no failing-repo names appear.

**Verification:**
- Runner file exists and is non-empty.
- Manifest rows C-PHASE5-RUNNER-* all have EVIDENCE pointing to specific line
  numbers in the runner script.
- REPO_URL_MANIFEST.md preamble row count matches wave-1 size.

---

- [ ] **Unit 6: Sage runs the runner; record post-execution evidence**

**Goal:** After Sage executes the runner from PowerShell, capture per-repo
publication state and gitleaks results into the manifest.

**Requirements:** R1, R2, R5, R7

**Dependencies:** Unit 5

**Files:**
- Modify: `G:\My Drive\repo_staging\REPO_URL_MANIFEST.md` (URL + visibility per
  repo)
- Modify: `G:\My Drive\repo_staging\CLI_EVAL_CRITERIA_v1.md` (Phase 5 post-exec
  rows filled)
- Append: `G:\My Drive\repo_staging\CLI_PROGRESS_LOG.md`

**Approach:**
- Per repo R, three flat rows: pushed (URL recorded), gitleaks-clean (defensive
  scan output captured), public (visibility flipped). Each row's EVIDENCE is the
  exact line in REPO_URL_MANIFEST.md or runner log.
- If runner halts mid-batch (auth fail, network, gitleaks hit), the rows for
  unprocessed repos stay `[ ]`. Halts are themselves stop-condition criteria.

**Execution note:** This unit is mostly recording, not running. The doing happened
in Sage's PowerShell session; the unit's job is to make the result legible to the
advisor.

**Patterns to follow:**
- REPO_URL_MANIFEST.md preamble format (already drafted by Cowork-Opus, header-
  only state).

**Test scenarios:**
- Happy path: every wave-1 repo has 3 rows checked (pushed / clean / public).
- Edge case (one repo fails gitleaks at defensive scan): that repo's `public` row
  stays `[ ]`; `pushed` is `[x]`; `gitleaks-clean` row is `[ ]` with EVIDENCE
  showing the leaked pattern hash.
- Error path (network timeout mid-batch): the affected repos' rows stay `[ ]`;
  STOP-NETFAIL inverse criterion in the Stops section flips to `[ ]` (signaling
  the stop did fire).
- Integration: total `[x]` count for Phase 5 post-exec rows equals (cleanly-
  published-repos × 3).

**Verification:**
- For every repo that flipped public, the manifest has 3 checked rows and
  REPO_URL_MANIFEST.md has its line.
- For every repo that did not flip, EVIDENCE explicitly cites why.

---

- [ ] **Unit 7: Phase 6 sub-agent probes (OPEN_Q, LinkedIn, LLC)**

**Goal:** Run the three sub-agent probes from prompt v1.0 Section 1.6 and record
artifact paths into the manifest.

**Requirements:** R1, R3, R5

**Dependencies:** Unit 1 (manifest exists)

**Files:**
- Create: `G:\My Drive\repo_staging\OPEN_Q_FOUND_ANSWERS_v1.md`
- Create: `G:\My Drive\repo_staging\LINKEDIN_DRAFTS_FOUND_v1.md`
- Create: `G:\My Drive\repo_staging\LLC_STATUS_FOUND_v1.md`
- Modify: `G:\My Drive\repo_staging\CLI_EVAL_CRITERIA_v1.md` (Phase 6 rows)

**Approach:**
- Three parallel Sonnet Explore sub-agents per CLI_BOOT_HANDOFF.md phase plan.
- Each sub-agent's deliverable is one file. The manifest row asserts the file
  exists and is non-empty.
- These probes run independently of the publish flow; they can begin any time
  after Unit 1 and complete in parallel with Units 5/6.

**Patterns to follow:**
- Existing Explore sub-agent dispatch pattern in this repo's prior phases.

**Test scenarios:**
- Happy path: three files exist, each with at least one substantive section.
- Edge case (a sub-agent finds nothing): file still exists with explicit "no
  candidates found" line; row passes (the deliverable is the file, not the
  finding).
- Integration: file-exists-and-nonempty check matches across all three rows.

**Verification:**
- All three files present at G:\repo_staging\.
- Each file's `wc -l` returns >= 5 (header + at least minimal body).

---

- [ ] **Unit 8: Phase 7 C: drive secondary scan**

**Goal:** Sub-agent walks C:\ outside SandBoxSetup for any publish-worthy
material missed in the G:\ inventory; deliverable is a candidates file.

**Requirements:** R1, R3, R5

**Dependencies:** Unit 1

**Files:**
- Create: `G:\My Drive\repo_staging\C_DRIVE_CANDIDATES_v1.md`
- Modify: `G:\My Drive\repo_staging\CLI_EVAL_CRITERIA_v1.md` (Phase 7 rows)

**Approach:**
- Sonnet Explore sub-agent with read-only access; no PII exfiltration to chat,
  only path lists.
- Scope honors `01_project_scope.md` — no modification of files outside
  SandBoxSetup; this is an inventory pass only.

**Test scenarios:**
- Happy path: candidates file exists with a path list and one-line rationale per
  candidate.
- Edge case (zero candidates): file exists with "no additional candidates found".
- Integration: no entry in candidates file points to a quarantined folder
  identifier (FxD, xD, FATExD, post-Feb arb).

**Verification:**
- File exists at the named path.
- Manifest row C-PHASE7-CDRIVE-EXISTS is `[x]` with EVIDENCE = path + line count.

---

- [ ] **Unit 9: Closing report + manifest finalization**

**Goal:** Write `CLI_RUN_SUMMARY_v1.md`, append session_close to
CLI_PROGRESS_LOG.md, ensure every manifest row has either `[x]`, an explicit
`[SKIP]` annotation, or a documented blocker. Mirror manifest into SandBoxSetup if
the advisor session may not have G:\ access.

**Requirements:** R1, R3, R5, R6

**Dependencies:** Units 4, 6, 7, 8 (all execution work complete or explicitly
halted)

**Files:**
- Create: `G:\My Drive\repo_staging\CLI_RUN_SUMMARY_v1.md`
- Modify: `G:\My Drive\repo_staging\CLI_EVAL_CRITERIA_v1.md`
- Append: `G:\My Drive\repo_staging\CLI_PROGRESS_LOG.md`
- Conditionally create: `docs/eval/cli_eval_mirror/CLI_EVAL_CRITERIA_v1.md`

**Approach:**
- Summary file recaps per-repo outcomes and any halted criteria.
- Every manifest row must be in a final state. `[SKIP]` requires a NOTE field
  citing the reason (e.g. "Sage answered Q-007 = stays private; no rows expanded").
- If executor signals advisor will not have G:\ access on return, copy the
  manifest into the SandBoxSetup mirror path before close.

**Test scenarios:**
- Happy path: summary exists; log final line is `phase | 8 | session_close`;
  manifest has zero `[ ]` rows.
- Edge case (some rows blocked): rows have NOTE field with blocker description;
  summary lists each blocked row.
- Integration: row state distribution (`[x]`, `[ ]`, `[SKIP]`) reconciles with
  summary counts.

**Verification:**
- `grep -c '^- \[ \] C-' CLI_EVAL_CRITERIA_v1.md` returns 0 (every row is in a
  final state) OR every remaining `[ ]` row has a NOTE field citing a blocker.
- Summary file exists and references the manifest by path.

---

- [ ] **Unit 10: Advisor return — read manifest, write verdict**

**Goal:** Opus advisor session reads the eval manifest plus the named artifacts
and writes `CLI_EVAL_VERDICT_v1.md` declaring per-row PASS/FAIL/SKIP with a
top-level summary count.

**Requirements:** R3, R4, R5, R6

**Dependencies:** Unit 9

**Files:**
- Create: `G:\My Drive\repo_staging\CLI_EVAL_VERDICT_v1.md`
  (or `docs/eval/cli_eval_mirror/CLI_EVAL_VERDICT_v1.md` if mirror path used)

**Approach:**
- Advisor reads each row, validates EVIDENCE against the row's `<verification>`
  target (re-running command if tools available; otherwise trusting recorded
  evidence and noting that the verdict is read-only).
- Verdict file format: one line per row with `C-NNN: PASS|FAIL|SKIP — <one-line
  basis>`. Top of file: counts and overall verdict (PASS if zero FAIL, else FAIL).
- Discrepancies between EVIDENCE and re-run output (where re-run is possible) are
  FAIL with the diff captured.

**Execution note:** This unit runs in a separate session. It is not part of the
executor's work; it is the work the advisor does on return. The plan declares it
so the executor knows what the advisor expects.

**Patterns to follow:**
- `feedback_adversarial_review_before_done.md` standing pattern.

**Test scenarios:**
- Happy path: verdict file lists every C-NNN with PASS; top summary is
  PASS_COUNT=N, FAIL_COUNT=0, SKIP_COUNT=0, OVERALL=PASS.
- Edge case (advisor lacks G:\ access): mirror at SandBoxSetup is used; verdict
  file written under `docs/eval/cli_eval_mirror/`; verdict notes "read-only mode,
  trusted EVIDENCE field".
- Error path (any FAIL): overall verdict is FAIL; first FAIL row's basis cites
  the specific EVIDENCE/expected mismatch.
- Integration: verdict line count = manifest C-NNN row count.

**Verification:**
- `grep -c '^C-' CLI_EVAL_VERDICT_v1.md` equals manifest C-NNN row count.
- Top-summary counts sum to total row count.

## System-Wide Impact

- **Interaction graph:** This plan touches G:\repo_staging\ (publish workspace),
  CLI session log/manifest in G:\, and a one-line pointer in
  SandBoxSetup/docs/eval/. It does NOT modify any other SandBoxSetup file.
- **Error propagation:** Phase 4 hits a tier-1 IP scrub HARD BLOCK → repo dropped
  from wave-1 → Unit 5 runner manifest excludes it → Unit 6 never logs a URL for it
  → Unit 9 summary lists it as blocked → Unit 10 verdict flags any related rows as
  FAIL or SKIP.
- **State lifecycle risks:** Partial Phase 4 staging on a repo (e.g. LICENSE
  written but PII grep then fails) leaves the repo with mixed-state edits. Unit 4's
  per-repo execution note mitigates by running PII grep first.
- **API surface parity:** None — this is a process plan, not a code change.
- **Integration coverage:** Unit 1 grep proves no row contains "AND". Unit 9 grep
  proves no row remains `[ ]` without a documented reason. Unit 10 grep proves
  verdict line count matches manifest row count. Three independent integration
  checks across the verification surface.
- **Unchanged invariants:** Project-scope rule — all work happens in SandBoxSetup
  OR in the active publish workspace at G:\repo_staging\. No other project folder
  is modified. The plan asserts this and the C: drive scan in Unit 8 enforces it
  as inventory-only.

## Risks & Dependencies

| Risk | Mitigation |
|---|---|
| Sage doesn't answer Q-001 through Q-015 promptly; Phase 3 gate stays open | Each Q has a stated default; Unit 2 records `DEFAULT_ACCEPTED:` after a stated wait window with Sage's prior blanket "do what is needed efficiently" authority covering it |
| Tier-1 PII slips past the scrub regex (e.g. paraphrased reference) | Two layers: ip_scrub regex set in Unit 4, plus runner's defensive `gitleaks` in Unit 5; if both miss, Sage can flip the repo back to private post-publish (gh repo edit --visibility private) |
| Runner halts mid-batch and operator marks rows as `[x]` without re-checking | Format-level: `[x]` requires non-empty EVIDENCE pointing to a real artifact line; advisor in Unit 10 spot-checks; mismatch → FAIL |
| Advisor session lacks G:\ access | Unit 9 mirror path; Unit 10 explicit handling |
| Stacking creeps in via "comma" or other conjunction | C-FMT-NO-STACK gate (defined in §C-FMT-NO-STACK below) extended to reject rows where `<expected>` field has more than one observable |
| Two near-identical SageX plugin repos cause double-publish | Q-005 must resolve before Unit 3 expansion; the unresolved Q-005 row blocks expansion of either plugin into wave-1 |

## Documentation / Operational Notes

- Once wave-1 is publicly verified (Unit 10 OVERALL=PASS), the 2026-04-29 sprint
  master plan can mark its Units 3-9 complete by referencing this plan's verdict
  file as evidence.
- `feedback_adversarial_review_before_done.md` is satisfied by Unit 10 (advisor as
  zero-context reviewer reading only the manifest + artifacts).
- The eval manifest at `G:\repo_staging\CLI_EVAL_CRITERIA_v1.md` is the canonical
  artifact for any future publish-resume session — it carries forward what was
  done, what was skipped with reason, and what remained `[ ]` for follow-up.

## §C-FMT-NO-STACK -- conjunction trigger tokens

The C-FMT-NO-STACK gate in the eval manifest scans every active row body
(`^- \[[ x]\] C-`) excluding the C-FMT-NO-STACK row itself for any of the
following trigger tokens. Any hit means the row stacks two facts and must be
split.

| Token (literal substring) | Why it stacks |
|---|---|
| ` and ` (space-conjunction-space, lowercase) | Combines two clauses |
| ` AND ` (space-conjunction-space, uppercase) | Combines two clauses |
| ` & ` (space-ampersand-space) | Combines two clauses |
| ` plus ` (space-plus-space, prose form) | Combines two clauses |
| ` or ` (space-disjunction-space, lowercase) | Lets the executor pass on either branch -- bypasses fact-pinning |
| ` OR ` (space-disjunction-space, uppercase) | Same |
| ` either ` | Implicit disjunction |
| `, also ` | Combines two clauses |
| `; ` followed by another verb in same field | Combines two clauses |

Regex-form alternation in a `<verification>` field (e.g. `^(ANSWER\|DEFAULT_ACCEPTED):`)
is allowed -- it describes ONE observable (a line matching either capture). English
prose disjunction ("X or Y") is not -- it lets the executor pick which fact to
record. Express the observable as one regex; do not split it across English.

The advisor on return runs the equivalent of:

```
grep -nE '^- \[[ x]\] C-' CLI_EVAL_CRITERIA_v1.md \
  | grep -v 'C-FMT-NO-STACK' \
  | grep -iE ' and | AND | & | plus | or | OR | either |, also '
```

Expected output: empty. Any line returned is a stacking violation; the row must
be split before the advisor verdict can pass.

## Sources & References

- **Origin (chat-source):** `cli_deep_dive_and_publish_prompt v1.0` (Sage chat,
  2026-04-30). Authority excerpt verbatim in
  `G:\My Drive\repo_staging\CLI_BOOT_HANDOFF.md` Authority section.
- **Boot handoff:** `G:\My Drive\repo_staging\CLI_BOOT_HANDOFF.md`
- **Progress log:** `G:\My Drive\repo_staging\CLI_PROGRESS_LOG.md`
- **Open questions:** `G:\My Drive\repo_staging\CLI_QUESTIONS_FOR_SAGE.md`
- **Inventory:** `G:\My Drive\repo_staging\REPO_INVENTORY_v1.md`
- **IP scrub canonical:**
  `G:\My Drive\repo_staging\anthropic-app-os-v1\anthropic_app_OS_v1\skills\ip_scrub_pre_publish.md`
- **Strategic master plan:**
  `docs/plans/2026-04-29-001-feat-github-publication-sprint-plan.md`
- **Standing rules:** `feedback_adversarial_review_before_done.md`,
  `feedback_source_reverification_after_compaction.md`,
  `feedback_opus_orchestrator_role.md`
