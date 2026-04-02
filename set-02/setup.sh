#!/usr/bin/env bash
# ============================================================
#  EXERCISE SET 02 — Directory Structure & Operations
#  Topics: pwd | cd | ls | touch | mkdir | rmdir | cp | mv | rm
#  (INT132 Class 05)
# ============================================================
#  Run this script ONCE from inside set-02/ to set up:
#    bash setup.sh
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE="$SCRIPT_DIR/exercise-files"

echo "→ Creating exercise directory at $BASE ..."
mkdir -p \
  "$BASE/project/src" \
  "$BASE/project/docs" \
  "$BASE/project/tests" \
  "$BASE/archive" \
  "$BASE/tmp"

# project/src/
cat > "$BASE/project/src/main.sh" <<'EOF'
#!/bin/bash
echo "Main application"
EOF

cat > "$BASE/project/src/utils.sh" <<'EOF'
#!/bin/bash
echo "Utility functions"
EOF

cat > "$BASE/project/src/config.cfg" <<'EOF'
host=localhost
port=8080
debug=false
EOF

# project/docs/
cat > "$BASE/project/docs/api.md" <<'EOF'
# API Documentation
Version 1.0
Endpoints: /health /users /data
EOF

cat > "$BASE/project/docs/readme.txt" <<'EOF'
Project README
See docs/ for more information.
EOF

# project/tests/
cat > "$BASE/project/tests/test1.sh" <<'EOF'
#!/bin/bash
echo "Test 1 passed"
EOF

cat > "$BASE/project/tests/test2.sh" <<'EOF'
#!/bin/bash
echo "Test 2 passed"
EOF

# archive/
cat > "$BASE/archive/legacy.sh" <<'EOF'
#!/bin/bash
echo "Legacy application"
EOF

echo ""
echo "✓ Setup complete! Directory structure:"
find "$BASE" -type f | sort
echo ""
echo "Now fill in your answers in answers.sh, then run:  bash test.sh"