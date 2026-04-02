#!/usr/bin/env bash
# ============================================================
#  TEST SCRIPT — Exercise Set 02
#  Directory Structure & Operations
# ============================================================
#  Usage (from inside set-02/):  bash test.sh
# ============================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/answers.sh"

BASE="$SCRIPT_DIR/exercise-files"
PASS=0
FAIL=0
SKIP=0

GREEN='\033[0;32m'
RED='\033[0;31m'
GRAY='\033[0;90m'
NC='\033[0m'

_hash() {
  printf '%s\n' "$1" | (sha256sum 2>/dev/null || shasum -a 256 2>/dev/null) | awk '{print $1}'
}

pass() { echo -e "${GREEN}[PASS]${NC} Q$1"; PASS=$((PASS+1)); }
fail() { echo -e "${RED}[FAIL]${NC} Q$1 ${GRAY}$2${NC}"; FAIL=$((FAIL+1)); }
skip() { echo -e "${GRAY}[SKIP]${NC} Q$1"; SKIP=$((SKIP+1)); }

# Each side-effect question runs on an isolated copy of exercise-files
# so questions cannot affect each other's state.
fresh() {
  local T
  T=$(mktemp -d)
  cp -r "$BASE/." "$T/"
  echo "$T"
}

if [[ ! -d "$BASE" ]]; then
  echo -e "${RED}ERROR:${NC} exercise-files/ not found. Run setup first:  bash setup.sh"
  exit 1
fi

echo "=============================================="
echo "        Grading  —  Exercise Set 02"
echo ""

# ── Q1: which command prints the working directory? ─────────
Q="1 Which command?"
if [[ -z "$ANS1" ]]; then skip "$Q"
else
  EXPECTED="b1119ecaf54feb68aa5ca8387277e0a929c71cd99fc70f1985b1de1b3b8724b6"
  [[ "$(_hash "$ANS1")" == "$EXPECTED" ]] \
    && pass "$Q" \
    || fail "$Q" "Wrong command"
fi

# ── Q2: touch three files with brace expansion ──────────────
Q="2 Create multiple files at once"
if [[ -z "$ANS2" ]]; then skip "$Q"
elif [[ "$ANS2" != *"{"* ]]; then
  fail "$Q" "CONSTRAINT: command must use brace expansion '{...}'."
else
  T=$(fresh)
  (cd "$T" && eval "$ANS2" 2>/dev/null)
  if [[ -f "$T/note1.txt" && -f "$T/note2.txt" && -f "$T/note3.txt" ]]; then
    pass "$Q"
  else
    fail "$Q" "Expected note1.txt, note2.txt, note3.txt to exist in exercise-files/."
  fi
  rm -rf "$T"
fi

# ── Q3: mkdir -p nested chain ───────────────────────────────
Q="3 Create nested directories in one shot"
if [[ -z "$ANS3" ]]; then skip "$Q"
elif [[ "$ANS3" != *"-p"* ]]; then
  fail "$Q" "CONSTRAINT: command must use the -p flag."
else
  T=$(fresh)
  (cd "$T" && eval "$ANS3" 2>/dev/null)
  if [[ -d "$T/levels/l1/l2/l3" ]]; then
    pass "$Q"
  else
    fail "$Q" "Directory levels/l1/l2/l3 not found in exercise-files/."
  fi
  rm -rf "$T"
fi

# ── Q4: ls project/src/ ─────────────────────────────────────
Q="4 List a directory's contents"
if [[ -z "$ANS4" ]]; then skip "$Q"
else
  EXPECTED="9438cd3aff809523131daf1807a56203be149d3fcbd6e79b31dd4568f305d8ad"
  OUT=$(cd "$BASE" && eval "$ANS4" 2>/dev/null)
  [[ "$(_hash "$OUT")" == "$EXPECTED" ]] \
    && pass "$Q" \
    || fail "$Q" "Output mismatch"
fi

# ── Q5: ls ../src from inside project/docs/ ─────────────────
Q="5 Navigate with relative paths"
if [[ -z "$ANS5" ]]; then skip "$Q"
elif [[ "$ANS5" != *".."* ]]; then
  fail "$Q" "CONSTRAINT: command must use '..' for relative navigation."
elif [[ "$ANS5" == /* ]]; then
  fail "$Q" "CONSTRAINT: must NOT use an absolute path (starts with '/')."
else
  EXPECTED="9438cd3aff809523131daf1807a56203be149d3fcbd6e79b31dd4568f305d8ad"
  OUT=$(cd "$BASE/project/docs" && eval "$ANS5" 2>/dev/null)
  [[ "$(_hash "$OUT")" == "$EXPECTED" ]] \
    && pass "$Q" \
    || fail "$Q" "Output mismatch"
fi

# ── Q6: cp -r project/docs archive/ ────────────────────────
Q="6 Copy a directory recursively"
if [[ -z "$ANS6" ]]; then skip "$Q"
elif [[ "$ANS6" != *"-r"* && "$ANS6" != *"-R"* ]]; then
  fail "$Q" "CONSTRAINT: must use -r or -R"
else
  T=$(fresh)
  (cd "$T" && eval "$ANS6" 2>/dev/null)
  if [[ -f "$T/archive/docs/api.md" && \
        -f "$T/archive/docs/readme.txt" && \
        -f "$T/archive/legacy.sh" ]]; then
    pass "$Q"
  else
    fail "$Q" "archive/docs/ not found or incomplete"
  fi
  rm -rf "$T"
fi

# ── Q7: mv *.sh from tests/ to archive/ (≤40 chars) ────────
Q="7 Move multiple files using a glob"
if [[ -z "$ANS7" ]]; then skip "$Q"
elif [[ "$ANS7" != *"*"* ]]; then
  fail "$Q" "CONSTRAINT: must use file globbing and not individual filenames."
elif [[ "${#ANS7}" -gt 40 ]]; then
  fail "$Q" "CONSTRAINT: ${#ANS7} chars, must be ≤ 35."
else
  T=$(fresh)
  (cd "$T" && eval "$ANS7" 2>/dev/null)
  SH_IN_TESTS=$(find "$T/project/tests" -maxdepth 1 -name "*.sh" 2>/dev/null | wc -l)
  if [[ -f "$T/archive/test1.sh" && \
        -f "$T/archive/test2.sh" && \
        "$SH_IN_TESTS" -eq 0 ]]; then
    pass "$Q"
  else
    fail "$Q" "test1.sh/test2.sh not in archive/, or .sh files still in project/tests/."
  fi
  rm -rf "$T"
fi

# ── Q8: mkdir -p then rmdir -p in one line ──────────────────
Q="8 Create and remove a directory chain in one line"
if [[ -z "$ANS8" ]]; then skip "$Q"
elif [[ "$ANS8" != *"mkdir"* ]]; then
  fail "$Q" "CONSTRAINT: command must contain 'mkdir'."
elif [[ "$ANS8" != *"rmdir"* ]]; then
  fail "$Q" "CONSTRAINT: command must contain 'rmdir'."
elif [[ "$ANS8" != *";"* && "$ANS8" != *"&&"* ]]; then
  fail "$Q" "CONSTRAINT: chain the two commands with ';' or '&&'."
else
  T=$(fresh)
  # Verify mkdir runs: tmp/x must exist mid-execution; we check by running mkdir only
  (cd "$T" && eval "$ANS8" 2>/dev/null)
  # rmdir -p propagates upward and may remove tmp/ itself if it ends up empty — that's fine.
  # The key check: the x/y/z chain must be gone.
  if [[ ! -d "$T/tmp/x" ]]; then
    pass "$Q"
  else
    fail "$Q" "tmp/x still exists"
  fi
  rm -rf "$T"
fi

# ── Q9: navigate from tests/ to archive/ with relative path ─
Q="9 Navigate deep with relative paths, then list"
if [[ -z "$ANS9" ]]; then skip "$Q"
elif [[ "$ANS9" != *".."* ]]; then
  fail "$Q" "CONSTRAINT: must use '..' for relative navigation."
elif [[ "$ANS9" == /* || "$ANS9" == *" /"* || "$ANS9" == *"~"* ]]; then
  fail "$Q" "CONSTRAINT: must NOT use absolute paths or '~'."
else
  EXPECTED="5c4ce718c9d4c3c10d2f84f7d0fc01bb6a3a237766297bc024e82dbbb252aa46"
  OUT=$(cd "$BASE/project/tests" && eval "$ANS9" 2>/dev/null)
  [[ "$(_hash "$OUT")" == "$EXPECTED" ]] \
    && pass "$Q" \
    || fail "$Q" "Output mismatch. Expected: legacy.sh"
fi

# ── Q10: rename project/ to my-project/ (≤25 chars) ────────
Q="10 Rename a directory, concisely"
if [[ -z "$ANS10" ]]; then skip "$Q"
elif [[ "${#ANS10}" -gt 25 ]]; then
  fail "$Q" "CONSTRAINT: ${#ANS10} chars — must be ≤ 25."
else
  T=$(fresh)
  (cd "$T" && eval "$ANS10" 2>/dev/null)
  if [[ -d "$T/my-project" && ! -d "$T/project" ]]; then
    pass "$Q"
  elif [[ -d "$T/project" ]]; then
    fail "$Q" "project/ was not renamed"
  else
    fail "$Q" "my-project/ not found"
  fi
  rm -rf "$T"
fi

# ── Q11: rm *.sh from tests/ without naming files ───────────
Q="11 Remove files by pattern without naming them"
if [[ -z "$ANS11" ]]; then skip "$Q"
elif [[ "$ANS11" != *"*"* ]]; then
  fail "$Q" "CONSTRAINT: must use '*' wildcard."
elif [[ "$ANS11" == *"test1"* || "$ANS11" == *"test2"* ]]; then
  fail "$Q" "CONSTRAINT: must NOT name files individually (no 'test1' or 'test2')."
else
  T=$(fresh)
  (cd "$T" && eval "$ANS11" 2>/dev/null)
  SH_LEFT=$(find "$T/project/tests" -maxdepth 1 -name "*.sh" 2>/dev/null | wc -l)
  if [[ "$SH_LEFT" -eq 0 ]]; then
    pass "$Q"
  else
    fail "$Q" ".sh files still remain in project/tests/ ($SH_LEFT file(s) found)."
  fi
  rm -rf "$T"
fi

# ── Q12: mkdir + cp files + mv rename (three operations) ────
Q="12 Chain three operations into one release pipeline"
if [[ -z "$ANS12" ]]; then skip "$Q"
elif [[ "$ANS12" != *"mkdir"* ]]; then
  fail "$Q" "CONSTRAINT: command must contain 'mkdir'."
elif [[ "$ANS12" != *"cp"* ]]; then
  fail "$Q" "CONSTRAINT: command must contain 'cp'."
elif [[ "$ANS12" != *"mv"* ]]; then
  fail "$Q" "CONSTRAINT: command must contain 'mv'."
else
  T=$(fresh)
  (cd "$T" && eval "$ANS12" 2>/dev/null)
  if [[ -f "$T/project/release/config.cfg" && \
        -f "$T/project/release/main.sh" && \
        -f "$T/project/release/utils.sh" && \
        ! -d "$T/backup" ]]; then
    pass "$Q"
  else
    ISSUES=""
    [[ ! -f "$T/project/release/config.cfg" ]] && ISSUES+=" missing:config.cfg"
    [[ ! -f "$T/project/release/main.sh"    ]] && ISSUES+=" missing:main.sh"
    [[ ! -f "$T/project/release/utils.sh"   ]] && ISSUES+=" missing:utils.sh"
    [[ -d "$T/backup" ]]                        && ISSUES+=" backup/still-exists"
    fail "$Q" "Side effects incorrect.$ISSUES"
  fi
  rm -rf "$T"
fi

# ── Summary ─────────────────────────────────────────────────
TOTAL=$((PASS + FAIL + SKIP))
echo ""
printf " Score: ${GREEN}%d PASS${NC} | ${RED}%d FAIL${NC} | ${GRAY}%d SKIP${NC}  (out of %d)\n" \
  $PASS $FAIL $SKIP $TOTAL
echo "=============================================="