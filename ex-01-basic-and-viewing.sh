#!/usr/bin/env bash
# ============================================================
#  EXERCISE SET 01 — Basic Commands & File Viewing
#  Topics: type | cat | tac | head | tail | redirection | pipe
#  (INT132 Class 03 + Class 04)
# ============================================================
#  Run this script ONCE to set up the exercise environment:
#    bash ex-01-basic-and-viewing.sh
# ============================================================

set -e

BASE=~/ex01
echo "→ Creating exercise directory at $BASE ..."
mkdir -p "$BASE/logs" "$BASE/docs"

# fruits.txt — 10 lines
cat > "$BASE/fruits.txt" <<'EOF'
apple
banana
cherry
durian
elderberry
fig
grape
honeydew
kiwi
lemon
EOF

# numbers.txt — numbers 1-20
seq 1 20 > "$BASE/numbers.txt"

# logs/app.log — 20 log entries
cat > "$BASE/logs/app.log" <<'EOF'
[2026-03-01 08:00] INFO: System started
[2026-03-01 08:05] INFO: Service A online
[2026-03-01 08:10] WARNING: High memory usage
[2026-03-01 09:00] ERROR: Connection timeout
[2026-03-01 09:15] INFO: Retry successful
[2026-03-01 10:00] INFO: Backup started
[2026-03-01 10:30] INFO: Backup complete
[2026-03-01 11:00] WARNING: Disk at 80%
[2026-03-01 12:00] ERROR: Service B crashed
[2026-03-01 12:05] INFO: Service B restarted
[2026-03-01 13:00] INFO: Scheduled job ran
[2026-03-01 14:00] INFO: Config reloaded
[2026-03-01 15:00] WARNING: CPU spike detected
[2026-03-01 16:00] ERROR: Authentication failed
[2026-03-01 17:00] INFO: End of business day
[2026-03-01 17:30] INFO: Running diagnostics
[2026-03-01 18:00] WARNING: Low disk space
[2026-03-01 19:00] INFO: Maintenance window started
[2026-03-01 20:00] INFO: Patches applied
[2026-03-01 21:00] INFO: System shutdown
EOF

# docs/readme.txt — 6 lines
cat > "$BASE/docs/readme.txt" <<'EOF'
This is the exercise directory.
It contains sample files for practice.
Read each question carefully.
Use the correct command and options.
Remember: Linux is case-sensitive.
Good luck!
EOF

echo ""
echo "✓ Setup complete! Directory structure:"
find "$BASE" -type f | sort
echo ""
echo "Now fill in your answers in answer.sh, then run:  bash test.sh"
