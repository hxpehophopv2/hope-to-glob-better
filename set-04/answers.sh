#!/usr/bin/env bash
# ============================================================
#  ANSWER SHEET — Exercise Set 04
#  Advanced Pattern Matching & Shell Basics
# ============================================================
#  Instructions:
#    1. Run setup first:   bash setup.sh
#    2. Fill in each ANS variable below.
#       - COMMAND questions  → write the command string (it will be eval'd).
#       - OUTPUT questions   → write the exact output as a string.
#    3. Save this file, then run:  bash test.sh
# ============================================================
#
#  exercise-files/ structure:
#    ├── logs/
#    │   ├── server.log
#    │   └── access.log
#    ├── src/
#    │   ├── main.sh  helper.sh  test_main.sh  test_helper.sh  config.cfg
#    └── docs/
#        └── README.md  api.md
# ============================================================

# ------------------------------------------------------------------
# Q1 grep with line numbers
#
# You are in exercise-files/
# Print all lines in logs/server.log that contain "ERROR" (case sensitive), WITH each line's line number prefixed.
# CONSTRAINT: must use grep and the -n flag.
#
# Expected output:
#   4:2026-03-01 09:00 ERROR Connection failed
#   10:2026-03-01 12:00 ERROR Service crashed
# ------------------------------------------------------------------
ANS1=""

# ------------------------------------------------------------------
# Q2 Case-insensitive count
#
# You are in exercise-files/
# Count ALL lines in logs/server.log that contain "error" in ANY case.
# CONSTRAINT: must use grep
#
# Expected output:
#   3
# ------------------------------------------------------------------
ANS2=""

# ------------------------------------------------------------------
# Q3 Arithmetic expansion
#
# What is the exact output of the following command?
#   echo $((2 ** 8))
#
# Write the output as a plain number (no spaces or newline).
# ------------------------------------------------------------------
ANS3=""

# ------------------------------------------------------------------
# Q4 grep whole-word match
#
# You are in exercise-files/
# Print all lines in logs/access.log that contain "GET" as a whole word.
# CONSTRAINT: must use grep and the -w flag.
#
# Expected output (5 lines):
#   192.168.1.1 GET /api/users 200
#   192.168.1.2 GET /api/data 404
#   172.16.0.1 GET /health 200
#   192.168.1.1 GET /api/users 200
#   192.168.1.3 GET /api/users 500
# ------------------------------------------------------------------
ANS4=""

# ------------------------------------------------------------------
# Q5 Extended regex
#
# You are in exercise-files/
# Print all lines in logs/server.log that contain EITHER "ERROR" or "WARNING".
# CONSTRAINT: must use grep -E and "|"
#
# Expected output (5 lines):
#   2026-03-01 08:10 WARNING High memory usage
#   2026-03-01 09:00 ERROR Connection failed
#   2026-03-01 10:00 WARNING Disk at 80%
#   2026-03-01 12:00 ERROR Service crashed
#   2026-03-01 12:05 WARNING CPU spike detected
# ------------------------------------------------------------------
ANS5=""

# ------------------------------------------------------------------
# Q6 Anchor at start-of-line + count
#
# You are in exercise-files/
# Count how many lines in logs/server.log START WITH "2026".
#
# Expected output:
#   12
# ------------------------------------------------------------------
ANS6=""

# ------------------------------------------------------------------
# Q7 find directories only
#
# You are in exercise-files/
# List ALL directories under the current directory (including .), sorted alphabetically.
# CONSTRAINT: must use find
#
# Expected output:
#   .
#   ./docs
#   ./logs
#   ./src
# ------------------------------------------------------------------
ANS7=""

# ------------------------------------------------------------------
# Q8 grep with end-of-line anchor + line numbers
#
# You are in exercise-files/
# Print lines in logs/server.log that END WITH the word "failed" (case sensitive), along with their line numbers.
# CONSTRAINT: must use grep
#
# Expected output:
#   4:2026-03-01 09:00 ERROR Connection failed
#   7:2026-03-01 10:30 error Auth failed
# ------------------------------------------------------------------
ANS8=""

# ------------------------------------------------------------------
# Q9 grep, recursive, filenames only
#
# You are in exercise-files/
# Search recursively inside logs/ for any file that CONTAINS "ERROR".
# Print only the FILENAMES (not the matching lines).
# CONSTRAINT: must use grep. Command must be ≤ 40 characters long.
#
# Expected output:
#   logs/server.log
# ------------------------------------------------------------------
ANS9=""

# ------------------------------------------------------------------
# Q10 Chained grep pipeline
#
# You are in exercise-files/
# From logs/server.log, first EXCLUDE all lines containing "INFO", then from the remaining lines COUNT how many contain "ERROR" (case sensitive).
# CONSTRAINT: must use two joined grep commands
#
# Expected output:
#   2
#
# Hint: lowercase "error" is excluded by the first filter since it doesn't match "INFO", but it also doesn't match "ERROR". Only the 2 ERROR lines survive both filters.
# ------------------------------------------------------------------
ANS10=""

# ------------------------------------------------------------------
# Q11 find with glob pattern
#
# You are in exercise-files/
# Find all files whose NAME starts with "test_" (anywhere under .).
# CONSTRAINT: must use find. Sort the output.
#
# Expected output:
#   ./src/test_helper.sh
#   ./src/test_main.sh
# ------------------------------------------------------------------
ANS11=""

# ------------------------------------------------------------------
# Q12 Parameter expansion
#
# VAR="int132"
# What is the exact output of:   echo "${VAR^^}"
# ------------------------------------------------------------------
ANS12=""

# ------------------------------------------------------------------
# Q13 Command substitution in an echo
#
# You are in exercise-files/
# Write a SINGLE echo command that prints:
#   Files: 4
# where the number 4 comes from counting .sh files in src/ using command substitution $(find ...).
# CONSTRAINT: must contain command substitution syntax. The number must NOT be hardcoded.
#
# Expected output:
#   Files: 4
# ------------------------------------------------------------------
ANS13=""

# ------------------------------------------------------------------
# Q14 find -exec with grep
#
# You are in exercise-files/
# Find all regular .log files anywhere under . and for each one check if it contains "ERROR". Print the path of matching files.
# CONSTRAINT: must use find, -exec, and grep -l. Sort the output.
#
# Expected output:
#   ./logs/server.log
# ------------------------------------------------------------------
ANS14=""

# ------------------------------------------------------------------
# Q15 Extended regex with anchors
#
# You are in exercise-files/
# Count lines in logs/access.log where the line STARTS WITH an IP address pattern AND the method is either GET or POST.
# CONSTRAINT: must use grep -cE with regex
#
# Expected output:
#   7
#
# Hint: there are 8 lines total; 1 is DELETE. GET and POST = 7.
# ------------------------------------------------------------------
ANS15=""