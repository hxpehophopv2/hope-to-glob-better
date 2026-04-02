#!/usr/bin/env bash
# ============================================================
#  EXERCISE SET 04 — Advanced Pattern Matching & Shell Basics
#  Topics: grep (regex, anchors, options) | find (advanced) |
#          variables | arithmetic | command substitution |
#          parameter expansion
#  (INT132 Class 08 + Class 09 + Class 10)
# ============================================================
#  Run this script ONCE from inside set-04/ to set up:
#    bash setup.sh
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE="$SCRIPT_DIR/exercise-files"

echo "→ Creating exercise directory at $BASE ..."
mkdir -p "$BASE/logs" "$BASE/src" "$BASE/docs"

# logs/server.log — 12 lines, mixed case severity levels
cat > "$BASE/logs/server.log" <<'EOF'
2026-03-01 08:00 INFO Server started
2026-03-01 08:05 INFO Service ready
2026-03-01 08:10 WARNING High memory usage
2026-03-01 09:00 ERROR Connection failed
2026-03-01 09:15 Info Retry succeeded
2026-03-01 10:00 WARNING Disk at 80%
2026-03-01 10:30 error Auth failed
2026-03-01 11:00 INFO Backup started
2026-03-01 11:30 INFO Backup done
2026-03-01 12:00 ERROR Service crashed
2026-03-01 12:05 WARNING CPU spike detected
2026-03-01 13:00 INFO Maintenance mode
EOF

# logs/access.log — 8 lines with IPs, methods, paths, status codes
cat > "$BASE/logs/access.log" <<'EOF'
192.168.1.1 GET /api/users 200
10.0.0.1 POST /api/login 200
192.168.1.2 GET /api/data 404
172.16.0.1 GET /health 200
10.0.0.2 POST /api/login 401
192.168.1.1 GET /api/users 200
10.0.0.3 DELETE /api/data 403
192.168.1.3 GET /api/users 500
EOF

# src/ — 4 shell scripts + 1 config (scripts NOT executable by default)
printf '#!/usr/bin/env bash\necho "Running main"\n'   > "$BASE/src/main.sh"
printf '#!/usr/bin/env bash\necho "Running helper"\n'  > "$BASE/src/helper.sh"
printf '#!/usr/bin/env bash\necho "Testing main"\n'    > "$BASE/src/test_main.sh"
printf '#!/usr/bin/env bash\necho "Testing helper"\n'  > "$BASE/src/test_helper.sh"
printf 'app=myapp\nversion=2.1.0\nenv=production\n'   > "$BASE/src/config.cfg"

# docs/
cat > "$BASE/docs/README.md" <<'EOF'
# MyApp Documentation
Version 2.1.0
This app provides REST API endpoints.
See api.md for endpoint details.
EOF

cat > "$BASE/docs/api.md" <<'EOF'
# API Reference
GET /api/users - list all users
POST /api/login - authenticate
GET /api/data - fetch data
DELETE /api/data - remove data
EOF

echo ""
echo "✓ Setup complete! Directory structure:"
find "$BASE" -type f | sort
echo ""
echo "Now fill in your answers in answers.sh, then run:  bash test.sh"