#!/usr/bin/env bash
# ============================================================
#  TEST SCRIPT — Exercise Set 03
#  Links, Permissions & Pattern Matching
# ============================================================
#  Usage (from inside set-03/):  bash test.sh
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

# Fresh isolated copy for side-effect questions
fresh() { local T; T=$(mktemp -d); cp -r "$BASE/." "$T/"; echo "$T"; }

if [[ ! -d "$BASE" ]]; then
  echo -e "${RED}ERROR:${NC} exercise-files/ not found. Run setup first:  bash setup.sh"
  exit 1
fi

echo "=============================================="
echo "        Grading  —  Exercise Set 03"
echo ""

# ── Q1: ln -s data/ data-link ───────────────────────────────
Q="1 Create a symbolic link"
if [[ -z "$ANS1" ]]; then skip "$Q"
elif [[ "$ANS1" != *"ln"* ]]; then
  fail "$Q" "CONSTRAINT: must use 'ln'."
elif [[ "$ANS1" != *"-s"* ]]; then
  fail "$Q" "CONSTRAINT: must create a symbolic link."
else
  T=$(fresh)
  (cd "$T" && eval "$ANS1" 2>/dev/null)
  if [[ -L "$T/data-link" ]]; then
    pass "$Q"
  else
    fail "$Q" "data-link symlink not found in exercise-files/."
  fi
  rm -rf "$T"
fi

# ── Q2: chmod +x scripts/*.sh (glob required) ───────────────
Q="2 Make scripts executable with a glob"
if [[ -z "$ANS2" ]]; then skip "$Q"
elif [[ "$ANS2" != *"*"* ]]; then
  fail "$Q" "CONSTRAINT: must use '*' file globbing."
else
  T=$(fresh)
  (cd "$T" && eval "$ANS2" 2>/dev/null)
  ALL_X=true
  for f in scripts/build.sh scripts/deploy.sh scripts/run.sh; do
    [[ -x "$T/$f" ]] || ALL_X=false
  done
  if $ALL_X; then
    pass "$Q"
  else
    fail "$Q" "Not all .sh files in scripts/ are executable. Check your glob path."
  fi
  rm -rf "$T"
fi

# ── Q3: chmod 644 data/notes.txt (octal required) ───────────
Q="3 Set permission using octal notation"
if [[ -z "$ANS3" ]]; then skip "$Q"
elif [[ "$ANS3" != *"644"* ]]; then
  fail "$Q" "CONSTRAINT: answer must contain the 3-digit octal."
else
  T=$(fresh)
  (cd "$T" && eval "$ANS3" 2>/dev/null)
  PERM=$(stat -c "%a" "$T/data/notes.txt" 2>/dev/null || stat -f "%Lp" "$T/data/notes.txt" 2>/dev/null)
  if [[ "$PERM" == "644" ]]; then
    pass "$Q"
  else
    fail "$Q" "Permission is $PERM"
  fi
  rm -rf "$T"
fi

# ── Q4: find "*.sh" | sort — output check ───────────────────
Q="4 Find files by extension"
if [[ -z "$ANS4" ]]; then skip "$Q"
elif [[ "$ANS4" != *"find"* ]]; then
  fail "$Q" "CONSTRAINT: must use 'find'."
elif [[ "$ANS4" != *"*.sh"* ]]; then
  fail "$Q" "CONSTRAINT: pattern must be quoted: \"*.sh\"."
else
  EXPECTED="53cb4032ff356b0341c4b4b607aab4acd1cf4b8e5568fa8301193c54b3f2e0fc"
  OUT=$(cd "$BASE" && eval "$ANS4" 2>/dev/null)
  if [[ "$(_hash "$OUT")" == "$EXPECTED" ]]; then
    pass "$Q"
  else
    fail "$Q" "Output mismatch"
  fi
fi

# ── Q5: hard link (no -s allowed) ───────────────────────────
Q="5 Create a hard link"
if [[ -z "$ANS5" ]]; then skip "$Q"
elif [[ "$ANS5" == *"-s"* ]]; then
  fail "$Q" "CONSTRAINT: must be a hard link"
else
  T=$(fresh)
  (cd "$T" && eval "$ANS5" 2>/dev/null)
  if [[ ! -f "$T/scripts/run-copy.sh" ]]; then
    fail "$Q" "scripts/run-copy.sh not found."
  else
    INODE1=$(stat -c "%i" "$T/scripts/run.sh" 2>/dev/null || stat -f "%i" "$T/scripts/run.sh" 2>/dev/null)
    INODE2=$(stat -c "%i" "$T/scripts/run-copy.sh" 2>/dev/null || stat -f "%i" "$T/scripts/run-copy.sh" 2>/dev/null)
    LINKS=$(stat -c "%h" "$T/scripts/run.sh" 2>/dev/null || stat -f "%l" "$T/scripts/run.sh" 2>/dev/null)
    if [[ "$INODE1" == "$INODE2" && "$LINKS" -ge 2 ]]; then
      pass "$Q"
    else
      fail "$Q" "Is it really a hard link?"
    fi
  fi
  rm -rf "$T"
fi

# ── Q6: grep "admin" data/users.txt — output check ──────────
Q="6 Search file contents with grep"
if [[ -z "$ANS6" ]]; then skip "$Q"
else
  EXPECTED="cb1291c5e3057f02f0dd493bf8e49b93779a3acb5459cf605bdcbbba5ef2a242"
  OUT=$(cd "$BASE" && eval "$ANS6" 2>/dev/null)
  if [[ "$(_hash "$OUT")" == "$EXPECTED" ]]; then
    pass "$Q"
  else
    fail "$Q" "Output mismatch. Expected lines containing 'admin' from users.txt."
  fi
fi

# ── Q7: find data/ -type f | sort — output check ────────────
Q="7 Find only regular files in a directory"
if [[ -z "$ANS7" ]]; then skip "$Q"
elif [[ "$ANS7" != *"-type f"* && "$ANS7" != *"-type"*"f"* ]]; then
  fail "$Q" "CONSTRAINT: must use -type f."
else
  EXPECTED="41a6bc51593691330cdff0e09e88a731ee43a6f5d9ef455fcfe25e1a8dc988f0"
  OUT=$(cd "$BASE" && eval "$ANS7" 2>/dev/null)
  if [[ "$(_hash "$OUT")" == "$EXPECTED" ]]; then
    pass "$Q"
  else
    fail "$Q" "Output mismatch. Expected sorted list of files inside data/."
  fi
fi

# ── Q8: grep -c "[ERROR]" data/logs.txt — output check ──────
Q="8 Count matching lines"
if [[ -z "$ANS8" ]]; then skip "$Q"
elif [[ "$ANS8" != *"grep"* ]]; then
  fail "$Q" "CONSTRAINT: must use 'grep'."
elif [[ "$ANS8" != *"-c"* ]]; then
  fail "$Q" "CONSTRAINT: must use -c flag (count mode)."
else
  EXPECTED="1121cfccd5913f0a63fec40a6ffd44ea64f9dc135c66634ba001d10bcf4302a2"
  OUT=$(cd "$BASE" && eval "$ANS8" 2>/dev/null)
  OUT_TRIM=$(echo "$OUT" | tr -d ' ')
  if [[ "$(_hash "$OUT_TRIM")" == "$EXPECTED" ]]; then
    pass "$Q"
  else
    fail "$Q" "Output mismatch. Expected: 3"
  fi
fi

# ── Q9: chmod go-r (symbolic, no octal) ─────────────────────
Q="9 Remove read from group and other — symbolic notation"
if [[ -z "$ANS9" ]]; then skip "$Q"
elif [[ "$ANS9" == *"chmod"* ]] && [[ "$ANS9" =~ chmod[[:space:]]+[0-9]{3} ]]; then
  fail "$Q" "CONSTRAINT: must use symbolic notation, not a 3-digit octal."
else
  T=$(fresh)
  chmod 644 "$T/configs/app.cfg"   # ensure known starting point
  (cd "$T" && eval "$ANS9" 2>/dev/null)
  PERM_OCT=$(stat -c "%a" "$T/configs/app.cfg" 2>/dev/null || stat -f "%Lp" "$T/configs/app.cfg" 2>/dev/null)
  PERM_DEC=$(printf "%d" "0$PERM_OCT")
  GROUP_R=$(( PERM_DEC & 040 ))
  OTHER_R=$(( PERM_DEC & 004 ))
  if [[ "$GROUP_R" -eq 0 && "$OTHER_R" -eq 0 ]]; then
    pass "$Q"
  else
    fail "$Q" "Group-read or other-read still set (perm=$PERM_OCT)"
  fi
  rm -rf "$T"
fi

# ── Q10: symlink with relative path from inside configs/ ────
Q="10 Symbolic link with a relative path"
if [[ -z "$ANS10" ]]; then skip "$Q"
elif [[ "$ANS10" != *"cd configs"* ]]; then
  fail "$Q" "CONSTRAINT: command must include 'cd'."
elif [[ "$ANS10" != *"-s"* ]]; then
  fail "$Q" "CONSTRAINT: must be a symbolic link"
elif [[ "$ANS10" =~ " /"[a-zA-Z] || "$ANS10" == *" ~"* ]]; then
  fail "$Q" "CONSTRAINT: must NOT use an absolute path."
else
  T=$(fresh)
  (cd "$T" && eval "$ANS10" 2>/dev/null)
  if [[ ! -L "$T/configs/data-link" ]]; then
    fail "$Q" "configs/data-link symlink not found."
  else
    TARGET=$(readlink "$T/configs/data-link")
    if [[ "$TARGET" == "../data" ]]; then
      pass "$Q"
    else
      fail "$Q" "Symlink target is '$TARGET'"
    fi
  fi
  rm -rf "$T"
fi

# ── Q11: count non-INFO lines (≤40 chars) ───────────────────
Q="11 Count non-matching lines with a pipe"
if [[ -z "$ANS11" ]]; then skip "$Q"
elif [[ "$ANS11" != *"grep"* ]]; then
  fail "$Q" "CONSTRAINT: must use 'grep'."
elif [[ "${#ANS11}" -gt 40 ]]; then
  fail "$Q" "CONSTRAINT: ${#ANS11} chars, must be ≤ 40."
else
  EXPECTED="06e9d52c1720fca412803e3b07c4b228ff113e303f4c7ab94665319d832bbfb7"
  OUT=$(cd "$BASE" && eval "$ANS11" 2>/dev/null)
  OUT_TRIM=$(echo "$OUT" | tr -d ' ')
  if [[ "$(_hash "$OUT_TRIM")" == "$EXPECTED" ]]; then
    pass "$Q"
  else
    fail "$Q" "Output mismatch. Expected: 6 (6 non-INFO lines in logs.txt)."
  fi
fi

# ── Q12: find + grep -l + wc -l from inside scripts/ ───────
Q="12 find + grep + wc pipeline"
if [[ -z "$ANS12" ]]; then skip "$Q"
elif [[ "$ANS12" != *"find"* ]]; then
  fail "$Q" "CONSTRAINT: must use 'find'."
elif [[ "$ANS12" != *"grep"* ]]; then
  fail "$Q" "CONSTRAINT: must use 'grep'."
elif [[ "$ANS12" != *"|"* ]]; then
  fail "$Q" "CONSTRAINT: must use a pipe '|'."
else
  EXPECTED="1121cfccd5913f0a63fec40a6ffd44ea64f9dc135c66634ba001d10bcf4302a2"
  OUT=$(cd "$BASE/scripts" && eval "$ANS12" 2>/dev/null)
  OUT_TRIM=$(echo "$OUT" | tr -d ' ')
  if [[ "$(_hash "$OUT_TRIM")" == "$EXPECTED" ]]; then
    pass "$Q"
  else
    fail "$Q" "Output mismatch. Expected: 3 (all 3 .sh files contain 'echo')."
  fi
fi

# ── Summary ─────────────────────────────────────────────────
TOTAL=$((PASS + FAIL + SKIP))
echo ""
printf "  Score: ${GREEN}%d PASS${NC} | ${RED}%d FAIL${NC} | ${GRAY}%d SKIP${NC}  (out of %d)\n" \
  $PASS $FAIL $SKIP $TOTAL
echo "=============================================="