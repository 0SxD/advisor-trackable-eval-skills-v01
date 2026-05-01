# CLI Eval Criteria v1 -- flat-boolean advisor-trackable manifest

> Created: 2026-04-30 by ce-plan deliverable
> Plan: SandBoxSetup/docs/plans/2026-04-30-001-feat-cli-publish-resume-eval-plan.md
> Format rule: one row = one fact = one verifiable observation.
> No row may contain " AND " or " and " inside any field.
> Every row template:
>
>   `- [ ] C-NNN | <phase> | <subject> | <verification: file path or command> | <expected> | EVIDENCE: <one-line fact recorded by executor> | NOTE: <optional>`
>
> States: `[ ]` open, `[x]` passed, `[SKIP]` not applicable (NOTE field required).
> Advisor on return ticks each row PASS / FAIL / SKIP and writes CLI_EVAL_VERDICT_v1.md.

---

## Phase 0 -- Pre-flight + bookkeeping (already complete in prior session; cite log lines)

- [ ] C-P0-LOG-EXISTS | 0 | progress log present | G:\My Drive\repo_staging\CLI_PROGRESS_LOG.md | file exists | EVIDENCE: | NOTE:
- [ ] C-P0-BOOT-EXISTS | 0 | boot handoff present | G:\My Drive\repo_staging\CLI_BOOT_HANDOFF.md | file exists | EVIDENCE: | NOTE:
- [ ] C-P0-QFILE-EXISTS | 0 | questions file present | G:\My Drive\repo_staging\CLI_QUESTIONS_FOR_SAGE.md | file exists | EVIDENCE: | NOTE:
- [ ] C-P0-URLMAN-EXISTS | 0 | url manifest header present | G:\My Drive\repo_staging\REPO_URL_MANIFEST.md | file exists | EVIDENCE: | NOTE:
- [ ] C-P0-DNP-DIR-EXISTS | 0 | DO_NOT_PUBLISH directory present | G:\My Drive\repo_staging\DO_NOT_PUBLISH\ | dir exists | EVIDENCE: | NOTE:
- [ ] C-P0-PREFLIGHT-GH | 0 | gh CLI status recorded | log line containing `preflight_check | gh CLI` | one line present | EVIDENCE: | NOTE:
- [ ] C-P0-PREFLIGHT-LEAKS | 0 | gitleaks status recorded | log line containing `preflight_check | gitleaks` | one line present | EVIDENCE: | NOTE:
- [ ] C-P0-PREFLIGHT-GIT | 0 | git version recorded | log line containing `preflight_check | git: version` | one line present | EVIDENCE: | NOTE:

## Phase 1 -- Read-only inventory pass (already complete)

- [ ] C-P1-INV-EXISTS | 1 | inventory file present | G:\My Drive\repo_staging\REPO_INVENTORY_v1.md | file exists | EVIDENCE: | NOTE:
- [ ] C-P1-INV-WAVE1 | 1 | wave-1 section present | grep `^## Wave-1 recommendation` REPO_INVENTORY_v1.md | match count >= 1 | EVIDENCE: | NOTE:
- [ ] C-P1-INV-QUARANTINE | 1 | quarantine section present | grep `^## Quarantine confirmed` REPO_INVENTORY_v1.md | match count >= 1 | EVIDENCE: | NOTE:
- [ ] C-P1-GREP-TRADING | 1 | trading-IP grep recorded | log line containing `bulk_grep | trading-IP heuristic` | one line present | EVIDENCE: | NOTE:
- [ ] C-P1-GREP-FXD | 1 | FxD/xD/FATExDAO grep recorded | log line containing `bulk_grep | FxD/xD/FATExDAO` | one line present | EVIDENCE: | NOTE:
- [ ] C-P1-GREP-IDPII | 1 | identity PII grep recorded | log line containing `bulk_grep | Identity PII` | one line present | EVIDENCE: | NOTE:
- [ ] C-P1-GREP-EMPLOYER | 1 | employer-name grep recorded | log line containing `bulk_grep | Mercor/Pavilion/Emporium/micro1` | one line present | EVIDENCE: | NOTE:
- [ ] C-P1-GREP-CONTACT | 1 | contact-info grep recorded | log line containing `bulk_grep | Phone` | one line present | EVIDENCE: | NOTE:

## Phase 2 -- Trading-IP quarantine (subset already confirmed via inventory; expansion optional)

- [ ] C-P2-QUAR-NAUTILUS | 2 | nautilus-trader quarantined | REPO_INVENTORY_v1.md row for `nautilus-trader` in Quarantine confirmed | row present | EVIDENCE: | NOTE:
- [ ] C-P2-QUAR-SJM | 2 | sjm-sandbox quarantined | REPO_INVENTORY_v1.md row for `sjm-sandbox` in Quarantine confirmed | row present | EVIDENCE: | NOTE:
- [ ] C-P2-QUAR-XDENOM | 2 | xdenominator quarantined | REPO_INVENTORY_v1.md row for `xdenominator` in Quarantine confirmed | row present | EVIDENCE: | NOTE:
- [ ] C-P2-QUAR-STAGE01 | 2 | STAGE_LOCAL_ONLY/01 quarantined | REPO_INVENTORY_v1.md row for `01_fatexdao_local_fxd_materials` | row present | EVIDENCE: | NOTE:
- [ ] C-P2-QUAR-STAGE02 | 2 | STAGE_LOCAL_ONLY/02 quarantined | REPO_INVENTORY_v1.md row for `02_post_fatexdex_trading_through_feb_2026` | row present | EVIDENCE: | NOTE:
- [ ] C-P2-QUAR-STAGE03 | 2 | STAGE_LOCAL_ONLY/03 quarantined | REPO_INVENTORY_v1.md row for `03_xD_makerdao_fork_archive` | row present | EVIDENCE: | NOTE:
- [ ] C-P2-QUAR-STAGE05 | 2 | STAGE_LOCAL_ONLY/05 quarantined | REPO_INVENTORY_v1.md row for `05_PRIVATE_post_feb_2026_arb_bot_DESKTOP_AUDIT_ONLY` | row present | EVIDENCE: | NOTE:
- [ ] C-P2-QUAR-COUNT | 2 | quarantine count under stop limit | quarantine row count in REPO_INVENTORY_v1.md | <= 50 | EVIDENCE: | NOTE:

## Phase 3 -- Sage gate resolution (one row per question; ANSWER or DEFAULT_ACCEPTED)

- [ ] C-P3-Q001 | 3 | Q-001 resolved | grep regex `^(ANSWER\|DEFAULT_ACCEPTED):` after the Q-001 block in CLI_QUESTIONS_FOR_SAGE.md | one matching line | EVIDENCE: | NOTE:
- [ ] C-P3-Q002 | 3 | Q-002 resolved | grep `^Q-002` then next resolution line | one such line | EVIDENCE: | NOTE:
- [ ] C-P3-Q003 | 3 | Q-003 resolved | grep `^Q-003` then next resolution line | one such line | EVIDENCE: | NOTE:
- [ ] C-P3-Q004 | 3 | Q-004 resolved | grep `^Q-004` then next resolution line | one such line | EVIDENCE: | NOTE:
- [ ] C-P3-Q005 | 3 | Q-005 resolved | grep `^Q-005` then next resolution line | one such line | EVIDENCE: | NOTE:
- [ ] C-P3-Q006 | 3 | Q-006 resolved | grep `^Q-006` then next resolution line | one such line | EVIDENCE: | NOTE:
- [ ] C-P3-Q007 | 3 | Q-007 resolved | grep `^Q-007` then next resolution line | one such line | EVIDENCE: | NOTE:
- [ ] C-P3-Q008 | 3 | Q-008 resolved | grep `^Q-008` then next resolution line | one such line | EVIDENCE: | NOTE:
- [ ] C-P3-Q009 | 3 | Q-009 resolved | grep `^Q-009` then next resolution line | one such line | EVIDENCE: | NOTE:
- [ ] C-P3-Q010 | 3 | Q-010 resolved | grep `^Q-010` then next resolution line | one such line | EVIDENCE: | NOTE:
- [ ] C-P3-Q011 | 3 | Q-011 resolved | grep `^Q-011` then next resolution line | one such line | EVIDENCE: | NOTE:
- [ ] C-P3-Q012 | 3 | Q-012 resolved | grep `^Q-012` then next resolution line | one such line | EVIDENCE: | NOTE:
- [ ] C-P3-Q013 | 3 | Q-013 resolved | grep `^Q-013` then next resolution line | one such line | EVIDENCE: | NOTE:
- [ ] C-P3-Q014 | 3 | Q-014 resolved | grep `^Q-014` then next resolution line | one such line | EVIDENCE: | NOTE:
- [ ] C-P3-Q015-WAVE1 | 3 | Q-015 wave-1 confirmed | CLI_QUESTIONS_FOR_SAGE.md ANSWER line for Q-015 | non-empty | EVIDENCE: | NOTE:
- [ ] C-P3-WAVE1-COUNT | 3 | wave-1 has at least one repo | parse Q-015 ANSWER repo names | count >= 1 | EVIDENCE: | NOTE:

## Phase 4 -- Per-repo staging (TEMPLATE; expand once Q-015 resolves)

> Executor instruction: for each repo R named in Q-015 ANSWER, copy the 7-row block
> below (de-indenting the leading 4 spaces) and replace `<R>` with the repo
> identifier. Then delete this template block. Templates are indented so the
> Format-level integrity gate skips them until expansion.

```
    - [ ] C-P4-<R>-LIC      | 4 | <R> LICENSE present | G:\My Drive\repo_staging\<R>\LICENSE | file exists | EVIDENCE: | NOTE:
    - [ ] C-P4-<R>-RBAN     | 4 | <R> README banner present | first 30 lines of <R>\README.md | banner block per Sage | EVIDENCE: | NOTE:
    - [ ] C-P4-<R>-EM       | 4 | <R> em-dash count zero | grep `—` over <R>\**\*.md | 0 matches | EVIDENCE: | NOTE:
    - [ ] C-P4-<R>-PII-T1   | 4 | <R> tier-1 PII clean | union grep of ip_scrub tier-1 patterns over <R>\ | 0 matches | EVIDENCE: | NOTE:
    - [ ] C-P4-<R>-SEC      | 4 | <R> secret pattern clean | grep `sk-ant\|sk-or\|ghp_\|gho_\|xoxb\|AKIA\|BEGIN PRIVATE KEY` over <R>\ | 0 matches | EVIDENCE: | NOTE:
    - [ ] C-P4-<R>-GI       | 4 | <R> gitignore present | G:\My Drive\repo_staging\<R>\.gitignore | file exists | EVIDENCE: | NOTE:
    - [ ] C-P4-<R>-RPT      | 4 | <R> report written | G:\My Drive\repo_staging\REPORT_<R>_v1.md | file exists | EVIDENCE: | NOTE:
```

## Phase 5 -- Runner generation + shape (executor produces the runner; rows verify shape)

- [ ] C-P5-RUNNER-EXISTS | 5 | runner file present | G:\My Drive\repo_staging\00_RUN_THIS_TO_PUBLISH.ps1 | file exists | EVIDENCE: | NOTE:
- [ ] C-P5-RUNNER-AUTH | 5 | runner pre-flight calls gh auth | grep `gh auth status` 00_RUN_THIS_TO_PUBLISH.ps1 | match count >= 1 | EVIDENCE: | NOTE:
- [ ] C-P5-RUNNER-LEAKS-VER | 5 | runner pre-flight calls gitleaks version | grep `gitleaks version` 00_RUN_THIS_TO_PUBLISH.ps1 | match count >= 1 | EVIDENCE: | NOTE:
- [ ] C-P5-RUNNER-INIT | 5 | runner per-repo git init step | grep `git init` 00_RUN_THIS_TO_PUBLISH.ps1 | match count >= 1 | EVIDENCE: | NOTE:
- [ ] C-P5-RUNNER-COMMIT | 5 | runner per-repo commit step | grep `git commit` 00_RUN_THIS_TO_PUBLISH.ps1 | match count >= 1 | EVIDENCE: | NOTE:
- [ ] C-P5-RUNNER-LEAKS-DETECT | 5 | runner per-repo gitleaks detect | grep `gitleaks detect` 00_RUN_THIS_TO_PUBLISH.ps1 | match count >= 1 | EVIDENCE: | NOTE:
- [ ] C-P5-RUNNER-CREATE | 5 | runner gh repo create step | grep `gh repo create 0SxD/` 00_RUN_THIS_TO_PUBLISH.ps1 | match count >= 1 | EVIDENCE: | NOTE:
- [ ] C-P5-RUNNER-PUSH | 5 | runner git push step | grep `git push -u origin main` 00_RUN_THIS_TO_PUBLISH.ps1 | match count >= 1 | EVIDENCE: | NOTE:
- [ ] C-P5-RUNNER-FLIP | 5 | runner gh repo edit visibility step | grep `gh repo edit 0SxD/.* --visibility public` 00_RUN_THIS_TO_PUBLISH.ps1 | match count >= 1 | EVIDENCE: | NOTE:
- [ ] C-P5-RUNNER-VIEW | 5 | runner verifies visibility post-flip | grep `gh repo view --json visibility` 00_RUN_THIS_TO_PUBLISH.ps1 | match count >= 1 | EVIDENCE: | NOTE:
- [ ] C-P5-RUNNER-BATCH | 5 | runner has batch-confirm prompt | grep `flip batch` 00_RUN_THIS_TO_PUBLISH.ps1 | match count >= 1 | EVIDENCE: | NOTE:
- [ ] C-P5-URLMAN-WAVE1 | 5 | url manifest preamble lists wave-1 | parse REPO_URL_MANIFEST.md preamble | row count == wave-1 size | EVIDENCE: | NOTE:

## Phase 5 post-execution -- per-repo (TEMPLATE; expand once Phase 4 finalizes wave-1)

> Executor instruction: for each repo R that passed all 7 Phase 4 rows, expand the
> 3-row block below (de-indenting the leading 4 spaces) and replace `<R>`. Then
> delete this template block.

```
    - [ ] C-P5X-<R>-PUSHED      | 5 | <R> pushed | REPO_URL_MANIFEST.md row for <R> | URL recorded | EVIDENCE: | NOTE:
    - [ ] C-P5X-<R>-LEAKS-CLEAN | 5 | <R> defensive gitleaks clean | runner log section for <R> | `0 leaks` reported | EVIDENCE: | NOTE:
    - [ ] C-P5X-<R>-PUBLIC      | 5 | <R> visibility public | gh repo view 0SxD/<R> --json visibility | `public` | EVIDENCE: | NOTE:
```

## Phase 6 -- OPEN_Q + LinkedIn + LLC sub-agent probes

- [ ] C-P6-OPENQ-EXISTS | 6 | open-Q answers file present | G:\My Drive\repo_staging\OPEN_Q_FOUND_ANSWERS_v1.md | file exists | EVIDENCE: | NOTE:
- [ ] C-P6-OPENQ-NONEMPTY | 6 | open-Q file non-empty | wc -l OPEN_Q_FOUND_ANSWERS_v1.md | line count >= 5 | EVIDENCE: | NOTE:
- [ ] C-P6-LINKEDIN-EXISTS | 6 | LinkedIn drafts file present | G:\My Drive\repo_staging\LINKEDIN_DRAFTS_FOUND_v1.md | file exists | EVIDENCE: | NOTE:
- [ ] C-P6-LINKEDIN-NONEMPTY | 6 | LinkedIn file non-empty | wc -l LINKEDIN_DRAFTS_FOUND_v1.md | line count >= 5 | EVIDENCE: | NOTE:
- [ ] C-P6-LLC-EXISTS | 6 | LLC status file present | G:\My Drive\repo_staging\LLC_STATUS_FOUND_v1.md | file exists | EVIDENCE: | NOTE:
- [ ] C-P6-LLC-NONEMPTY | 6 | LLC file non-empty | wc -l LLC_STATUS_FOUND_v1.md | line count >= 5 | EVIDENCE: | NOTE:

## Phase 7 -- C: drive secondary scan

- [ ] C-P7-CDRIVE-EXISTS | 7 | C: drive candidates file present | G:\My Drive\repo_staging\C_DRIVE_CANDIDATES_v1.md | file exists | EVIDENCE: | NOTE:
- [ ] C-P7-CDRIVE-NONEMPTY | 7 | C: drive file non-empty | wc -l C_DRIVE_CANDIDATES_v1.md | line count >= 3 | EVIDENCE: | NOTE:
- [ ] C-P7-CDRIVE-NO-QUAR | 7 | C: drive list excludes quarantine identifiers | grep `FxD\|xD_\|FATExD\|post-feb arb` C_DRIVE_CANDIDATES_v1.md | 0 matches | EVIDENCE: | NOTE:

## Phase 8 -- Closing report + manifest finalization

- [ ] C-P8-SUMMARY-EXISTS | 8 | run summary file present | G:\My Drive\repo_staging\CLI_RUN_SUMMARY_v1.md | file exists | EVIDENCE: | NOTE:
- [ ] C-P8-SUMMARY-NONEMPTY | 8 | run summary non-empty | wc -l CLI_RUN_SUMMARY_v1.md | line count >= 10 | EVIDENCE: | NOTE:
- [ ] C-P8-LOG-CLOSED | 8 | progress log session close line present | grep `phase | 8 | session_close` CLI_PROGRESS_LOG.md | match count == 1 | EVIDENCE: | NOTE:
- [ ] C-P8-ZERO-OPEN | 8 | manifest has zero unchecked rows | `grep -c '^- \[ \] C-' CLI_EVAL_CRITERIA_v1.md` | 0 | EVIDENCE: | NOTE:
- [ ] C-P8-SKIPS-NOTED | 8 | every SKIP row has non-empty NOTE | parse `\[SKIP\]` rows for NOTE field | every such row passes | EVIDENCE: | NOTE: enforced by C-FMT-NOTE-ON-SKIP at format layer; this row records the closing assertion
- [ ] C-P8-MIRROR-DECISION | 8 | mirror decision recorded | summary file declares advisor-G:-access status | one declarative line | EVIDENCE: | NOTE:
- [ ] C-P8-ADVISOR-INVOKED | 8 | advisor session ran against this manifest | G:\My Drive\repo_staging\CLI_EVAL_VERDICT_v1.md (or mirror path) | file exists | EVIDENCE: | NOTE: verdict file is the advisor-was-invoked proof

## Stop conditions -- inverse criteria (advisor confirms NONE triggered)

- [ ] C-STOP-Q1 | stop | quarantine count under 50 in any folder | wc -l of any one DO_NOT_PUBLISH subdir manifest | <= 50 | EVIDENCE: | NOTE:
- [ ] C-STOP-Q2 | stop | no single repo over 100 MB | du -sh per repo | every repo size < 100M | EVIDENCE: | NOTE:
- [ ] C-STOP-Q3 | stop | no push auth failure recorded | grep `auth failure\|authentication failed` CLI_PROGRESS_LOG.md | 0 matches | EVIDENCE: | NOTE:
- [ ] C-STOP-Q4 | stop | gh CLI authenticated before runner | runner pre-flight log line | exit code 0 recorded | EVIDENCE: | NOTE:
- [ ] C-STOP-Q5 | stop | no network failure recorded | grep `network failure\|timed out\|could not resolve` CLI_PROGRESS_LOG.md | 0 matches | EVIDENCE: | NOTE:
- [ ] C-STOP-Q6 | stop | gitleaks completed every staged repo | per repo `gitleaks` result line in runner log | one per published repo | EVIDENCE: | NOTE:
- [ ] C-STOP-Q7 | stop | sonnet zero-context audit ran | sub-agent return artifact | one artifact path | EVIDENCE: | NOTE:
- [ ] C-STOP-Q8 | stop | token budget under 80% at session close | session-close log line | budget figure < 80 | EVIDENCE: | NOTE:

## Format-level integrity (advisor checks these even if everything else passes)

- [ ] C-FMT-NO-STACK | fmt | active rows do not stack two facts via conjunction | scan active rows excluding C-FMT-NO-STACK for the conjunctive trigger tokens defined in plan §C-FMT-NO-STACK | 0 hits | EVIDENCE: | NOTE: gate excludes its own row by ID
- [ ] C-FMT-ROW-SHAPE | fmt | every row matches the canonical pipe shape | grep `^- \[[ x]\] C-[A-Z0-9-]+ \| ` | match count == total `^- \[` count | EVIDENCE: | NOTE:
- [ ] C-FMT-EVIDENCE-ON-CHECKED | fmt | every checked row has non-empty EVIDENCE | parse `^- \[x\]` rows | every such row has EVIDENCE field non-empty | EVIDENCE: | NOTE:
- [ ] C-FMT-NOTE-ON-SKIP | fmt | every SKIP row has non-empty NOTE | parse `\[SKIP\]` rows | every such row has NOTE field non-empty | EVIDENCE: | NOTE:

---

## End manifest -- expansion log

> Executor instruction: append a one-liner each time the manifest is materially
> updated (e.g. Phase 4 template expanded, wave-1 confirmed).

- 2026-04-30T<fill> | created | initial template by ce-plan deliverable
