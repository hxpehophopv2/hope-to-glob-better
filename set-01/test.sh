#!/usr/bin/env bash
# ============================================================
#  TEST SCRIPT — Exercise Set 01
#  Basic Commands & File Viewing
# ============================================================
#  Usage (from inside set-01/):  bash test.sh
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

if [[ ! -d "$BASE" ]]; then
  echo -e "${RED}ERROR:${NC} exercise-files/ not found. Run setup first:  bash setup.sh"
  exit 1
fi

echo "=============================================="
echo "         Grading  —  Exercise Set 01"
echo ""

# ── Q1: type cd ────────────────────────────────────────────
Q="1 Command Type"
if [[ -z "$ANS1" ]]; then skip "$Q"
else
  EXPECTED="33f7b870d0a378891f0d64e282016fbed81d72a6b51d7413a1febc6825c404d9"
  [[ "$(_hash "$ANS1")" == "$EXPECTED" ]] && pass "$Q" || fail "$Q" "Wrong output for 'type cd'"
fi

# ── Q2: cat -n ─────────────────────────────────────────────
Q="2 Display a file with line numbers"
if [[ -z "$ANS2" ]]; then skip "$Q"
elif [[ "$ANS2" != *"cat"* ]]; then
  fail "$Q" "CONSTRAINT: command must use 'cat'."
elif [[ "$ANS2" != *"-n"* ]]; then
  fail "$Q" "CONSTRAINT: command must use the '-n' flag."
else
  EXPECTED="b62f2773f042319a61d25f8b18873d245ce3b59bb0b1dceb4ce62219e33330f8"
  OUT=$(cd "$BASE" && eval "$ANS2" 2>/dev/null)
  [[ "$(_hash "$OUT")" == "$EXPECTED" ]] && pass "$Q" || fail "$Q" "Output mismatch"
fi

# ── Q3: head -4 ────────────────────────────────────────────
Q="3 First lines in a file"
if [[ -z "$ANS3" ]]; then skip "$Q"
else
  EXPECTED="1e891211c4304d0c305ef01ad9b29d29b423dd3236fdd8c9bdcf0b10dbc931e0"
  OUT=$(cd "$BASE" && eval "$ANS3" 2>/dev/null)
  [[ "$(_hash "$OUT")" == "$EXPECTED" ]] && pass "$Q" || fail "$Q" "Output mismatch"
fi

# ── Q4: tail -4 ────────────────────────────────────────────
Q="4 Last lines in a file"
if [[ -z "$ANS4" ]]; then skip "$Q"
else
  EXPECTED="97f3f90ee44f6ab2971135ab2114e0c8b976cd8c739bf67c97c51aea0ccf0354"
  OUT=$(cd "$BASE" && eval "$ANS4" 2>/dev/null)
  [[ "$(_hash "$OUT")" == "$EXPECTED" ]] && pass "$Q" || fail "$Q" "Output mismatch"
fi

# ── Q5: tac ────────────────────────────────────────────────
Q="5 Display a file in reverse"
if [[ -z "$ANS5" ]]; then skip "$Q"
else
  EXPECTED="0d42cdcb85d9cca7f11a5ef6ea100af580308af455592269d6f9a31d90b9a2d6"
  OUT=$(cd "$BASE" && eval "$ANS5" 2>/dev/null)
  [[ "$(_hash "$OUT")" == "$EXPECTED" ]] && pass "$Q" || fail "$Q" "Output mismatch"
fi

# ── Q6: cd logs → tail (no '/' allowed, command run from BASE) ──
Q="6 Multiple commands"
if [[ -z "$ANS6" ]]; then skip "$Q"
elif [[ "$ANS6" == *"/"* ]]; then
  fail "$Q" "CONSTRAINT: command must not contain '/' — use cd to enter logs/ first."
else
  EXPECTED="98c81eb84bb1062ed49de8cb711fc507b1968d03fac0c52b1f10cc516e200f49"
  OUT=$(cd "$BASE" && eval "$ANS6" 2>/dev/null)
  [[ "$(_hash "$OUT")" == "$EXPECTED" ]] && pass "$Q" || fail "$Q" "Output mismatch"
fi

# ── Q7: head | tail pipe (≤40 chars) ───────────────────────
Q="7 Show lines in between"
if [[ -z "$ANS7" ]]; then skip "$Q"
elif [[ "$ANS7" != *"|"* ]]; then
  fail "$Q" "CONSTRAINT: must use a pipe '|'."
elif [[ "${#ANS7}" -gt 40 ]]; then
  fail "$Q" "CONSTRAINT: ${#ANS7} chars — must be ≤ 40."
else
  EXPECTED="808f9a07169d5c788d979048b76dc17f06325ac2ebdbb4426e6bf103611fafa0"
  OUT=$(cd "$BASE" && eval "$ANS7" 2>/dev/null)
  [[ "$(_hash "$OUT")" == "$EXPECTED" ]] && pass "$Q" || fail "$Q" "Output mismatch"
fi

# ── Q8: stderr → errors.txt (must contain '2>') ────────────
Q="8 stderr redirection"
if [[ -z "$ANS8" ]]; then skip "$Q"
elif [[ "$ANS8" != *"2>"* ]]; then
  fail "$Q" "CONSTRAINT: must explicitly redirect stderr with '2>'."
else
  EXPECTED="9649a366ca3a160959c0554708c2f481dc1bd997a5b5ca609392339e8700b778"
  rm -f "$BASE/errors.txt"
  OUT=$(cd "$BASE" && eval "$ANS8" 2>/dev/null)
  STDOUT_OK=false; ERRFILE_OK=false
  [[ "$(_hash "$OUT")" == "$EXPECTED" ]] && STDOUT_OK=true
  [[ -f "$BASE/errors.txt" && -s "$BASE/errors.txt" ]] && ERRFILE_OK=true
  if $STDOUT_OK && $ERRFILE_OK; then pass "$Q"
  elif ! $STDOUT_OK; then fail "$Q" "Stdout mismatch"
  else fail "$Q" "errors.txt not found or empty in exercise-files/."
  fi
fi

# ── Q9: tac | head (≤30 chars) ─────────────────────────────
Q="9 Reverse the last lines of a file"
if [[ -z "$ANS9" ]]; then skip "$Q"
elif [[ "${#ANS9}" -gt 30 ]]; then
  fail "$Q" "CONSTRAINT: ${#ANS9} chars — must be ≤ 30."
else
  EXPECTED="95fe63df7caa817b98d99acf22cfe0af6e6527d4494d32efbaf82e4160b31228"
  OUT=$(cd "$BASE" && eval "$ANS9" 2>/dev/null)
  [[ "$(_hash "$OUT")" == "$EXPECTED" ]] && pass "$Q" || fail "$Q" "Output mismatch"
fi

# ── Summary ────────────────────────────────────────────────
TOTAL=$((PASS + FAIL + SKIP))
echo ""
printf "  Score: ${GREEN}%d PASS${NC} | ${RED}%d FAIL${NC} | ${GRAY}%d SKIP${NC}  (out of %d)\n" \
  $PASS $FAIL $SKIP $TOTAL
echo "=============================================="