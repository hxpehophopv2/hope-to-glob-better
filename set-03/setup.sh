#!/usr/bin/env bash
# ============================================================
#  EXERCISE SET 03 — Links, Permissions & Pattern Matching
#  Topics: ln | chmod | find | grep | globbing
#  (INT132 Class 06 + Class 08)
# ============================================================
#  Run this script ONCE from inside set-03/ to set up:
#    bash setup.sh
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE="$SCRIPT_DIR/exercise-files"

echo "→ Creating exercise directory at $BASE ..."
mkdir -p \
  "$BASE/scripts" \
  "$BASE/data" \
  "$BASE/configs" \
  "$BASE/web"

# scripts/  — three shell scripts (not executable by default)
printf '#!/bin/bash\necho "Running"\n'   > "$BASE/scripts/run.sh"
printf '#!/bin/bash\necho "Building"\n'  > "$BASE/scripts/build.sh"
printf '#!/bin/bash\necho "Deploying"\n' > "$BASE/scripts/deploy.sh"

# data/users.txt — users with roles
cat > "$BASE/data/users.txt" <<'EOF'
alice admin
bob developer
charlie admin
dave tester
eve developer
frank admin
EOF

# data/logs.txt — 12 log entries: 6 INFO, 3 WARNING, 3 ERROR
cat > "$BASE/data/logs.txt" <<'EOF'
[INFO] System started
[INFO] Service ready
[WARNING] High memory
[ERROR] Connection failed
[INFO] Retry succeeded
[WARNING] Disk at 80%
[ERROR] Auth failed
[INFO] Backup started
[INFO] Backup done
[WARNING] CPU spike
[ERROR] Service crashed
[INFO] Maintenance mode
EOF

# data/notes.txt
cat > "$BASE/data/notes.txt" <<'EOF'
Meeting notes for March 2026
Agenda: review, planning, deployment
Action items: update configs, test scripts
Follow up next week
EOF

# configs/app.cfg
printf 'host=localhost\nport=8080\ndebug=false\nlog_level=info\n' \
  > "$BASE/configs/app.cfg"

# web/
printf '<html><body><h1>Hello</h1></body></html>\n' > "$BASE/web/index.html"
printf 'body { margin: 0; }\n'                      > "$BASE/web/style.css"

echo ""
echo "✓ Setup complete! Directory structure:"
find "$BASE" -type f | sort
echo ""
echo "Now fill in your answers in answers.sh, then run:  bash test.sh"