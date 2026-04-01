#!/usr/bin/env bash
# ============================================================
#  TEST SCRIPT — Exercise Set 01
#  Basic Commands & File Viewing
# ============================================================
#  Usage:  bash test.sh
# ============================================================

# ---- Load answers ----
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/answer.sh"

BASE=~/ex01
PASS=0
FAIL=0
SKIP=0

# ---- Colors ----
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# ---- Hash function (Linux sha256sum / macOS shasum) ----
_hash() {
  printf '%s\n' "$1" | (sha256sum 2>/dev/null || shasum -a 256 2>/dev/null) | awk '{print $1}'
}

# ---- Result helpers ----
pass() { echo -e "${GREEN}[PASS]${NC} Q$1: $2"; ((PASS++)); }
fail() { echo -e "${RED}[FAIL]${NC} Q$1: $2"; ((FAIL++)); }
skip() { echo -e "${YELLOW}[SKIP]${NC} Q$1: $2"; ((SKIP++)); }

# ---- Sanity check ----
if [[ ! -d "$BASE" ]]; then
  echo -e "${RED}ERROR:${NC} Exercise directory ~/ex01 not found."
  echo "       Run setup first:  bash ex-01-basic-and-viewing.sh"
  exit 1
fi

echo "=============================================="
echo " Grading Exercise Set 01"
echo "=============================================="
echo ""

# ==============================================================
# Q1 — type cd (string answer, no eval)
# ==============================================================
Q=1
if [[ -z "$ANS1" ]]; then
  skip $Q "No answer provided."
else
  EXPECTED_HASH="33f7b870d0a378891f0d64e282016fbed81d72a6b51d7413a1febc6825c404d9"
  GOT_HASH=$(_hash "$ANS1")
  if [[ "$GOT_HASH" == "$EXPECTED_HASH" ]]; then
    pass $Q "Correct! 'cd' is indeed a shell builtin."
  else
    fail $Q "Wrong output. Run 'type cd' and paste the EXACT output."
  fi
fi

# ==============================================================
# Q2 — cat -n fruits.txt (constraint: must use cat and -n)
# ==============================================================
Q=2
if [[ -z "$ANS2" ]]; then
  skip $Q "No answer provided."
else
  # Constraint check
  if [[ "$ANS2" != *"cat"* ]]; then
    fail $Q "CONSTRAINT VIOLATION: command must use 'cat'."
  elif [[ "$ANS2" != *"-n"* ]]; then
    fail $Q "CONSTRAINT VIOLATION: command must use the '-n' flag."
  else
    EXPECTED_HASH="b62f2773f042319a61d25f8b18873d245ce3b59bb0b1dceb4ce62219e33330f8"
    GOT_OUT=$(cd "$BASE" && eval "$ANS2" 2>/dev/null)
    GOT_HASH=$(_hash "$GOT_OUT")
    if [[ "$GOT_HASH" == "$EXPECTED_HASH" ]]; then
      pass $Q "Correct! cat -n shows numbered lines."
    else
      fail $Q "Output does not match expected. Check you're viewing fruits.txt with line numbers."
    fi
  fi
fi

# ==============================================================
# Q3 — head: first 4 lines
# ==============================================================
Q=3
if [[ -z "$ANS3" ]]; then
  skip $Q "No answer provided."
else
  EXPECTED_HASH="1e891211c4304d0c305ef01ad9b29d29b423dd3236fdd8c9bdcf0b10dbc931e0"
  GOT_OUT=$(cd "$BASE" && eval "$ANS3" 2>/dev/null)
  GOT_HASH=$(_hash "$GOT_OUT")
  if [[ "$GOT_HASH" == "$EXPECTED_HASH" ]]; then
    pass $Q "Correct! First 4 fruits: apple banana cherry durian."
  else
    fail $Q "Output mismatch. Expected the first 4 lines of fruits.txt."
  fi
fi

# ==============================================================
# Q4 — tail: last 4 lines
# ==============================================================
Q=4
if [[ -z "$ANS4" ]]; then
  skip $Q "No answer provided."
else
  EXPECTED_HASH="97f3f90ee44f6ab2971135ab2114e0c8b976cd8c739bf67c97c51aea0ccf0354"
  GOT_OUT=$(cd "$BASE" && eval "$ANS4" 2>/dev/null)
  GOT_HASH=$(_hash "$GOT_OUT")
  if [[ "$GOT_HASH" == "$EXPECTED_HASH" ]]; then
    pass $Q "Correct! Last 4 fruits: grape honeydew kiwi lemon."
  else
    fail $Q "Output mismatch. Expected the last 4 lines of fruits.txt."
  fi
fi

# ==============================================================
# Q5 — tac: reverse order
# ==============================================================
Q=5
if [[ -z "$ANS5" ]]; then
  skip $Q "No answer provided."
else
  EXPECTED_HASH="0d42cdcb85d9cca7f11a5ef6ea100af580308af455592269d6f9a31d90b9a2d6"
  GOT_OUT=$(cd "$BASE" && eval "$ANS5" 2>/dev/null)
  GOT_HASH=$(_hash "$GOT_OUT")
  if [[ "$GOT_HASH" == "$EXPECTED_HASH" ]]; then
    pass $Q "Correct! tac reverses line order (lemon...apple)."
  else
    fail $Q "Output mismatch. Expected fruits.txt in reverse order."
  fi
fi

# ==============================================================
# Q6 — tail from inside logs/ (no '/' in command)
# ==============================================================
Q=6
if [[ -z "$ANS6" ]]; then
  skip $Q "No answer provided."
else
  # Constraint: no '/' in command
  if [[ "$ANS6" == *"/"* ]]; then
    fail $Q "CONSTRAINT VIOLATION: command must not contain '/' — you should already be inside logs/."
  else
    EXPECTED_HASH="98c81eb84bb1062ed49de8cb711fc507b1968d03fac0c52b1f10cc516e200f49"
    GOT_OUT=$(cd "$BASE/logs" && eval "$ANS6" 2>/dev/null)
    GOT_HASH=$(_hash "$GOT_OUT")
    if [[ "$GOT_HASH" == "$EXPECTED_HASH" ]]; then
      pass $Q "Correct! cd into logs/, then tail -5 app.log shows the last 5 entries."
    else
      fail $Q "Output mismatch. Make sure you're targeting app.log and showing the last 5 lines."
    fi
  fi
fi

# ==============================================================
# Q7 — pipe: lines 4-7 (constraint: must contain '|', ≤40 chars)
# ==============================================================
Q=7
if [[ -z "$ANS7" ]]; then
  skip $Q "No answer provided."
else
  # Constraint: must contain pipe
  if [[ "$ANS7" != *"|"* ]]; then
    fail $Q "CONSTRAINT VIOLATION: command must use a pipe '|'."
  # Constraint: ≤40 chars
  elif [[ "${#ANS7}" -gt 40 ]]; then
    fail $Q "CONSTRAINT VIOLATION: command is ${#ANS7} chars — must be ≤ 40 characters."
  else
    EXPECTED_HASH="808f9a07169d5c788d979048b76dc17f06325ac2ebdbb4426e6bf103611fafa0"
    GOT_OUT=$(cd "$BASE" && eval "$ANS7" 2>/dev/null)
    GOT_HASH=$(_hash "$GOT_OUT")
    if [[ "$GOT_HASH" == "$EXPECTED_HASH" ]]; then
      pass $Q "Correct! head | tail pipeline extracts lines 4-7 (${#ANS7} chars)."
    else
      fail $Q "Output mismatch. Expected: durian / elderberry / fig / grape."
    fi
  fi
fi

# ==============================================================
# Q8 — stderr redirect to errors.txt (constraint: must contain '2>')
# ==============================================================
Q=8
if [[ -z "$ANS8" ]]; then
  skip $Q "No answer provided."
else
  # Constraint: must use explicit stderr redirect
  if [[ "$ANS8" != *"2>"* ]]; then
    fail $Q "CONSTRAINT VIOLATION: command must explicitly redirect stderr with '2>'."
  else
    EXPECTED_HASH="9649a366ca3a160959c0554708c2f481dc1bd997a5b5ca609392339e8700b778"
    # Clean up any previous errors.txt
    rm -f "$BASE/errors.txt"
    # Run command: capture stdout, stderr goes to errors.txt (via the command itself)
    GOT_OUT=$(cd "$BASE" && eval "$ANS8" 2>/dev/null)
    GOT_HASH=$(_hash "$GOT_OUT")

    STDOUT_OK=false
    ERRFILE_OK=false

    [[ "$GOT_HASH" == "$EXPECTED_HASH" ]] && STDOUT_OK=true
    [[ -f "$BASE/errors.txt" && -s "$BASE/errors.txt" ]] && ERRFILE_OK=true

    if $STDOUT_OK && $ERRFILE_OK; then
      pass $Q "Correct! Fruits appeared on stdout; error was redirected to errors.txt."
    elif ! $STDOUT_OK; then
      fail $Q "Stdout mismatch. Expected the 10 fruits from fruits.txt."
    else
      fail $Q "errors.txt not found or empty in ~/ex01/. Check your redirect target filename."
    fi
  fi
fi

# ==============================================================
# Q9 — tac + head pipe, ≤30 chars
# ==============================================================
Q=9
if [[ -z "$ANS9" ]]; then
  skip $Q "No answer provided."
else
  # Constraint: ≤30 chars
  if [[ "${#ANS9}" -gt 30 ]]; then
    fail $Q "CONSTRAINT VIOLATION: command is ${#ANS9} chars — must be ≤ 30 characters."
  else
    EXPECTED_HASH="95fe63df7caa817b98d99acf22cfe0af6e6527d4494d32efbaf82e4160b31228"
    GOT_OUT=$(cd "$BASE" && eval "$ANS9" 2>/dev/null)
    GOT_HASH=$(_hash "$GOT_OUT")
    if [[ "$GOT_HASH" == "$EXPECTED_HASH" ]]; then
      pass $Q "Correct! (${#ANS9} chars) tac reverses, head cuts — shows lemon kiwi honeydew."
    else
      fail $Q "Output mismatch. Expected: lemon / kiwi / honeydew (last 3 fruits, bottom-first)."
    fi
  fi
fi

# ==============================================================
# Summary
# ==============================================================
TOTAL=$((PASS + FAIL + SKIP))
echo ""
echo "=============================================="
printf " Score: ${GREEN}%d PASS${NC} | ${RED}%d FAIL${NC} | ${YELLOW}%d SKIP${NC} (out of %d)\n" $PASS $FAIL $SKIP $TOTAL
echo "=============================================="
