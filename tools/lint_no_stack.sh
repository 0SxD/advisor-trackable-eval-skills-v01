#!/usr/bin/env bash
# lint_no_stack.sh -- run integrity gates A and B from docs/FLAT_BOOLEAN_RULE.md
#
# Usage:
#   ./lint_no_stack.sh <target>
#
#   <target> may be a single .md file or a directory. If a directory, the
#   script lints every .md file under the directory recursively.
#
# Exit codes:
#   0  all gates green
#   1  Gate A failed (row shape mismatch)
#   2  Gate B failed (no-stacking violation)
#   3  invalid usage

set -u

TRIGGER_REGEX=' and | AND | & | plus | or | OR | either |, also '

usage() {
  echo "Usage: $0 <file.md | directory>" >&2
  exit 3
}

[ $# -eq 1 ] || usage

TARGET="$1"

if [ ! -e "$TARGET" ]; then
  echo "lint_no_stack: target does not exist: $TARGET" >&2
  exit 3
fi

# Build list of .md files to lint.
MD_FILES=()
if [ -d "$TARGET" ]; then
  while IFS= read -r -d '' f; do
    MD_FILES+=("$f")
  done < <(find "$TARGET" -type f -name '*.md' -print0)
elif [ -f "$TARGET" ]; then
  MD_FILES=("$TARGET")
else
  echo "lint_no_stack: target is neither file nor directory: $TARGET" >&2
  exit 3
fi

if [ ${#MD_FILES[@]} -eq 0 ]; then
  echo "lint_no_stack: no .md files under $TARGET"
  exit 0
fi

GATE_A_FAIL=0
GATE_B_FAIL=0

for f in "${MD_FILES[@]}"; do
  # Skip files with no `- [` rows at all -- prose-only docs cannot fail the
  # gates by design.
  ANY_ROW=$(grep -c '^- \[' "$f" 2>/dev/null; true)
  [ -z "$ANY_ROW" ] && ANY_ROW=0
  [ "$ANY_ROW" = "0" ] && continue

  # Skip files containing template/placeholder IDs (e.g. `C-NNN`, `C-PN-<TAG>`,
  # `C-P4-<R>-LIC`). These are documentation or templates, not real manifests.
  # A row whose ID contains `<` or whose ID is the literal `C-NNN` placeholder
  # marks the file as a doc/template; the lint exits without checking it.
  HAS_PLACEHOLDER=$(grep -cE '^- \[[ xSKIP]+\] C-[A-Z0-9-]*<|^- \[[ xSKIP]+\] C-NNN ' "$f" 2>/dev/null; true)
  [ -z "$HAS_PLACEHOLDER" ] && HAS_PLACEHOLDER=0
  if [ "$HAS_PLACEHOLDER" != "0" ]; then
    echo "lint_no_stack [$f]: skipped (template/doc; contains placeholder IDs)"
    continue
  fi

  # Count rows with valid canonical-shape IDs.
  SHAPED=$(grep -cE '^- \[[ x]\] C-[A-Z0-9-]+ \| ' "$f" 2>/dev/null; true)
  [ -z "$SHAPED" ] && SHAPED=0
  SKIPPED=$(grep -cE '^- \[SKIP\] C-[A-Z0-9-]+ \| ' "$f" 2>/dev/null; true)
  [ -z "$SKIPPED" ] && SKIPPED=0
  TOTAL_SHAPED=$((SHAPED + SKIPPED))

  # Gate A: every `- [` row in the file matches canonical pipe shape. If a
  # file has unscoped `- [` rows that don't match canonical AND don't contain
  # placeholder IDs, that's a real shape error.
  if [ "$ANY_ROW" != "$TOTAL_SHAPED" ]; then
    echo "GATE_A_FAIL [$f]: any_row=$ANY_ROW shaped=$TOTAL_SHAPED"
    GATE_A_FAIL=1
  fi

  # Gate B: no canonical-shape row body contains a conjunction trigger token,
  # except the C-FMT-NO-STACK row which is exempt by ID.
  VIOLATIONS=$(grep -nE '^- \[[ x]\] C-[A-Z0-9-]+ \| ' "$f" 2>/dev/null \
    | grep -v 'C-FMT-NO-STACK' \
    | grep -iE "$TRIGGER_REGEX" || true)
  if [ -n "$VIOLATIONS" ]; then
    echo "GATE_B_FAIL [$f]:"
    echo "$VIOLATIONS"
    GATE_B_FAIL=1
  fi
done

if [ "$GATE_A_FAIL" -ne 0 ]; then
  echo "lint_no_stack: GATE A failed"
  exit 1
fi
if [ "$GATE_B_FAIL" -ne 0 ]; then
  echo "lint_no_stack: GATE B failed"
  exit 2
fi

echo "lint_no_stack: all gates green over ${#MD_FILES[@]} .md file(s)"
exit 0
