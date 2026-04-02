#!/usr/bin/env bash
# ============================================================
#  TEST SCRIPT — Exercise Set 04
#  Advanced Pattern Matching & Shell Basics
# ============================================================
#  Usage (from inside set-04/):  bash test.sh
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
fail() { echo -e "${RED}[FAIL]${NC} Q$1 — $2"; FAIL=$((FAIL+1)); }
skip() { echo -e "${GRAY}[SKIP]${NC} Q$1"; SKIP=$((SKIP+1)); }

fresh() { local T; T=$(mktemp -d); cp -r "$BASE/." "$T/"; echo "$T"; }

if [[ ! -d "$BASE" ]]; then
  echo -e "${RED}ERROR:${NC} exercise-files/ not found. Run setup first:  bash setup.sh"
  exit 1
fi

echo "=============================================="
echo "        Grading  —  Exercise Set 04"
echo ""

# ── Q1: grep -n "ERROR" ─────────────────────────────────────
Q="1 grep with line numbers"
if [[ -z "$ANS1" ]]; then skip "$Q"
elif [[ "$ANS1" != *"grep"* ]]; then
  fail "$Q" "CONSTRAINT: must use 'grep'."
elif [[ "$ANS1" != *"-n"* ]]; then
  fail "$Q" "CONSTRAINT: must use the -n flag."
else
  EXPECTED="4c669f3e8128e0ce595bf5c3264c873f66ce595bd585ddecc379fc97664c8e59"
  OUT=$(cd "$BASE" && eval "$ANS1" 2>/dev/null)
  [[ "$(_hash "$OUT")" == "$EXPECTED" ]] \
    && pass "$Q" \
    || fail "$Q" "Output mismatch. Expected 2 lines with line numbers 4 and 10."
fi

# ── Q2: grep -ic "error" ────────────────────────────────────
Q="2 Case-insensitive count"
if [[ -z "$ANS2" ]]; then skip "$Q"
elif ! [[ "$ANS2" =~ grep[[:space:]]*-[a-zA-Z]*i ]]; then
  fail "$Q" "CONSTRAINT: must use grep with the -i flag (case-insensitive)."
elif ! [[ "$ANS2" =~ grep[[:space:]]*-[a-zA-Z]*c ]]; then
  fail "$Q" "CONSTRAINT: must use grep with the -c flag (count). Do not pipe to wc -l."
elif [[ "$ANS2" == *"wc"* ]]; then
  fail "$Q" "CONSTRAINT: use grep -c directly, do not pipe to wc."
else
  EXPECTED="1121cfccd5913f0a63fec40a6ffd44ea64f9dc135c66634ba001d10bcf4302a2"
  OUT=$(cd "$BASE" && eval "$ANS2" 2>/dev/null)
  OUT_T=$(echo "$OUT" | tr -d ' ')
  [[ "$(_hash "$OUT_T")" == "$EXPECTED" ]] \
    && pass "$Q" \
    || fail "$Q" "Output mismatch. Expected: 3."
fi

# ── Q3: echo $((2 ** 8)) — string answer ────────────────────
Q="3 Arithmetic expansion"
if [[ -z "$ANS3" ]]; then skip "$Q"
else
  EXPECTED="f16c302d5d30e1d3fbe955cf4f637f58a871adeba597922e3baad0aeeb13f656"
  [[ "$(_hash "$ANS3")" == "$EXPECTED" ]] \
    && pass "$Q" \
    || fail "$Q" "'im disappointed tbh' - hope"
fi

# ── Q4: grep -w "GET" ───────────────────────────────────────
Q="4 grep whole-word match"
if [[ -z "$ANS4" ]]; then skip "$Q"
elif [[ "$ANS4" != *"-w"* ]]; then
  fail "$Q" "CONSTRAINT: must use the -w flag (whole-word match)."
else
  EXPECTED="019f18ec5715931c7df27ca71bf18534d80a1f1c79c03f2da1771d534f72d413"
  OUT=$(cd "$BASE" && eval "$ANS4" 2>/dev/null)
  [[ "$(_hash "$OUT")" == "$EXPECTED" ]] \
    && pass "$Q" \
    || fail "$Q" "Output mismatch. Expected 5 lines."
fi

# ── Q5: grep -E "ERROR|WARNING" ─────────────────────────────
Q="5 Extended regex"
if [[ -z "$ANS5" ]]; then skip "$Q"
elif [[ "$ANS5" != *"-E"* ]]; then
  fail "$Q" "CONSTRAINT: must use -E (extended regexp)."
elif [[ "$ANS5" != *"ERROR|WARNING"* && "$ANS5" != *"WARNING|ERROR"* ]]; then
  fail "$Q" "CONSTRAINT: pattern must contain 'ERROR|WARNING' alternation."
else
  EXPECTED="d7ad114bbf1bf9d0af8f05724cbc6ddc462021cd0065368dedef7b152076fd65"
  OUT=$(cd "$BASE" && eval "$ANS5" 2>/dev/null)
  [[ "$(_hash "$OUT")" == "$EXPECTED" ]] \
    && pass "$Q" \
    || fail "$Q" "Output mismatch. Expected 5 lines"
fi

# ── Q6: grep "^2026" | wc -l ────────────────────────────────
Q="6 Anchor at start-of-line + count"
if [[ -z "$ANS6" ]]; then skip "$Q"
elif [[ "$ANS6" != *"^"* ]]; then
  fail "$Q" "CONSTRAINT: pattern must contain '^' (start-of-line anchor)."
elif [[ "$ANS6" != *"|"* ]]; then
  fail "$Q" "CONSTRAINT: must pipe to wc -l."
else
  EXPECTED="a1fb50e6c86fae1679ef3351296fd6713411a08cf8dd1790a4fd05fae8688164"
  OUT=$(cd "$BASE" && eval "$ANS6" 2>/dev/null)
  OUT_T=$(echo "$OUT" | tr -d ' ')
  [[ "$(_hash "$OUT_T")" == "$EXPECTED" ]] \
    && pass "$Q" \
    || fail "$Q" "Output mismatch, expected: 12."
fi

# ── Q7: find -type d | sort ─────────────────────────────────
Q="7 find directories only"
if [[ -z "$ANS7" ]]; then skip "$Q"
elif [[ "$ANS7" != *"-type d"* && "$ANS7" != *"-type"*" d"* ]]; then
  fail "$Q" "CONSTRAINT: must use -type d."
else
  EXPECTED="2c830707a33333807680ba07ce3e2503ab61801791e19dbb18d7bf3a09f28ceb"
  OUT=$(cd "$BASE" && eval "$ANS7" 2>/dev/null)
  [[ "$(_hash "$OUT")" == "$EXPECTED" ]] \
    && pass "$Q" \
    || fail "$Q" "Output mismatch. Expected: . / ./docs / ./logs / ./src"
fi

# ── Q8: grep -n "failed$" ───────────────────────────────────
Q="8 grep with end-of-line anchor + line numbers"
if [[ -z "$ANS8" ]]; then skip "$Q"
elif [[ "$ANS8" != *"-n"* ]]; then
  fail "$Q" "CONSTRAINT: must use -n (line numbers)."
elif [[ "$ANS8" != *'$'* ]]; then
  fail "$Q" "CONSTRAINT: pattern must contain '$' (end-of-line anchor)."
else
  EXPECTED="f25e2d8d3021b06f3b2bbd632aa6152aecbbb04b4f615071cc9b9d28fedb9c86"
  OUT=$(cd "$BASE" && eval "$ANS8" 2>/dev/null)
  [[ "$(_hash "$OUT")" == "$EXPECTED" ]] \
    && pass "$Q" \
    || fail "$Q" "Output mismatch. Expected lines 4 and 7"
fi

# ── Q9: grep -rl "ERROR" logs/ (≤40 chars) ──────────────────
Q="9 grep, recursive, filenames only"
if [[ -z "$ANS9" ]]; then skip "$Q"
elif [[ "$ANS9" != *"-r"* && "$ANS9" != *"-R"* ]]; then
  fail "$Q" "CONSTRAINT: must use recursive."
elif ! [[ "$ANS9" =~ -[a-zA-Z]*l ]]; then
  fail "$Q" "CONSTRAINT: must use -l (filenames only)"
elif [[ "${#ANS9}" -gt 40 ]]; then
  fail "$Q" "CONSTRAINT: ${#ANS9} chars, must be ≤ 40."
else
  EXPECTED="ed3060397e1cff4aa88202a4e6a98f9471010cea6dbb70fb0b9a315446e697c2"
  OUT=$(cd "$BASE" && eval "$ANS9" 2>/dev/null)
  [[ "$(_hash "$OUT")" == "$EXPECTED" ]] \
    && pass "$Q" \
    || fail "$Q" "Output mismatch. Expected: logs/server.log"
fi

# ── Q10: grep -v "INFO" | grep -c "ERROR" ───────────────────
Q="10 Chained grep pipeline"
if [[ -z "$ANS10" ]]; then skip "$Q"
elif [[ "$ANS10" != *"-v"* ]]; then
  fail "$Q" "CONSTRAINT: first grep must use -v (invert match)."
elif [[ "$ANS10" != *"-c"* ]]; then
  fail "$Q" "CONSTRAINT: second grep must use -c (count)."
elif [[ "$ANS10" != *"|"* ]]; then
  fail "$Q" "CONSTRAINT: must use a pipe '|' between the two greps."
else
  EXPECTED="53c234e5e8472b6ac51c1ae1cab3fe06fad053beb8ebfd8977b010655bfdd3c3"
  OUT=$(cd "$BASE" && eval "$ANS10" 2>/dev/null)
  OUT_T=$(echo "$OUT" | tr -d ' ')
  [[ "$(_hash "$OUT_T")" == "$EXPECTED" ]] \
    && pass "$Q" \
    || fail "$Q" "Output mismatch. Expected: 2"
fi

# ── Q11: find -name "test_*.sh" | sort ──────────────────────
Q="11 find with glob pattern"
if [[ -z "$ANS11" ]]; then skip "$Q"
elif [[ "$ANS11" != *"find"* ]]; then
  fail "$Q" "CONSTRAINT: must use 'find'."
elif [[ "$ANS11" != *'"test_'* && "$ANS11" != *"'test_"* ]]; then
  fail "$Q" "CONSTRAINT: -name pattern must be quoted: \"test_*.sh\"."
else
  EXPECTED="a26938986c033fa9654dc5e0faa9c9c186d19b5fa164be54ccce40f56b9457d0"
  OUT=$(cd "$BASE" && eval "$ANS11" 2>/dev/null)
  [[ "$(_hash "$OUT")" == "$EXPECTED" ]] \
    && pass "$Q" \
    || fail "$Q" "Output mismatch. Expected: ./src/test_helper.sh and ./src/test_main.sh"
fi

# ── Q12: ${VAR^^} — string answer ───────────────────────────
Q="12 Parameter expansion"
if [[ -z "$ANS12" ]]; then skip "$Q"
else
  EXPECTED="22e193662ba517aa54dcda3859e6349662fc2009a90881c6092e1d96a705858e"
  [[ "$(_hash "$ANS12")" == "$EXPECTED" ]] \
    && pass "$Q" \
    || fail "$Q" "Bruh are you serious?"
fi

# ── Q13: echo "Files: $(find src/ ...)" ─────────────────────
Q="13 Command substitution in an echo"
if [[ -z "$ANS13" ]]; then skip "$Q"
elif [[ "$ANS13" != *'$('* ]]; then
  fail "$Q" "CONSTRAINT: must use command substitution \$(...) syntax."
elif echo "$ANS13" | grep -qE '"?Files: [0-9]"?'; then
  fail "$Q" "CONSTRAINT: the number must NOT be hardcoded."
else
  EXPECTED="429fbecfca0c385820b9611aff18aa254d708a0ee216a51a5e3aa6518fff6af7"
  OUT=$(cd "$BASE" && eval "$ANS13" 2>/dev/null)
  [[ "$(_hash "$OUT")" == "$EXPECTED" ]] \
    && pass "$Q" \
    || fail "$Q" "Output mismatch. Expected: 'Files: 4'"
fi

# ── Q14: find -type f -name "*.log" -exec grep -l ───────────
Q="14 find -exec with grep"
if [[ -z "$ANS14" ]]; then skip "$Q"
elif [[ "$ANS14" != *"find"* ]]; then
  fail "$Q" "CONSTRAINT: must use 'find'."
elif [[ "$ANS14" != *"-exec"* ]]; then
  fail "$Q" "CONSTRAINT: must use -exec."
elif [[ "$ANS14" != *"grep"* ]]; then
  fail "$Q" "CONSTRAINT: must use 'grep' inside -exec."
elif [[ "$ANS14" != *"-l"* ]]; then
  fail "$Q" "CONSTRAINT: grep must use -l (list filenames only)."
else
  EXPECTED="084e415b2e897fed250a3f98fa5a5d3e5dde971668101f444735738f1156b6b0"
  OUT=$(cd "$BASE" && eval "$ANS14" 2>/dev/null)
  [[ "$(_hash "$OUT")" == "$EXPECTED" ]] \
    && pass "$Q" \
    || fail "$Q" "Output mismatch. Expected: ./logs/server.log"
fi

# ── Q15: grep -cE "^IP (GET|POST)" ──────────────────────────
Q="15 Extended regex with anchors"
if [[ -z "$ANS15" ]]; then skip "$Q"
elif [[ "$ANS15" != *"-cE"* && "$ANS15" != *"-Ec"* && ( "$ANS15" != *"-c"* || "$ANS15" != *"-E"* ) ]]; then
  fail "$Q" "CONSTRAINT: must use both -c and -E flags."
elif [[ "$ANS15" != *"^"* ]]; then
  fail "$Q" "CONSTRAINT: regex must anchor at '^' (start of line)."
elif [[ "$ANS15" != *"GET|POST"* && "$ANS15" != *"POST|GET"* ]]; then
  fail "$Q" "CONSTRAINT: must use (GET|POST) alternation."
else
  EXPECTED="10159baf262b43a92d95db59dae1f72c645127301661e0a3ce4e38b295a97c58"
  OUT=$(cd "$BASE" && eval "$ANS15" 2>/dev/null)
  OUT_T=$(echo "$OUT" | tr -d ' ')
  [[ "$(_hash "$OUT_T")" == "$EXPECTED" ]] \
    && pass "$Q" \
    || fail "$Q" "Output mismatch. Expected: 7"
fi

# ── Summary ─────────────────────────────────────────────────
TOTAL=$((PASS + FAIL + SKIP))
echo ""
printf "  Score: ${GREEN}%d PASS${NC} | ${RED}%d FAIL${NC} | ${GRAY}%d SKIP${NC}  (out of %d)\n" \
  $PASS $FAIL $SKIP $TOTAL
echo "=============================================="