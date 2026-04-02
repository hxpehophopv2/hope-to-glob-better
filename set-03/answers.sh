#!/usr/bin/env bash
# ============================================================
#  ANSWER SHEET — Exercise Set 03
#  Links, Permissions & Pattern Matching
# ============================================================
#  Instructions:
#    1. Run setup first:   bash setup.sh
#    2. Fill in each ANS variable below.
#    3. Save this file, then run:  bash test.sh
# ============================================================
#
#  exercise-files/ structure:
#    ├── scripts/     ← run.sh  build.sh  deploy.sh  (NOT executable by default)
#    ├── data/        ← users.txt  logs.txt  notes.txt
#    ├── configs/     ← app.cfg
#    └── web/         ← index.html  style.css
#
#  data/logs.txt has 12 lines: 6 [INFO], 3 [WARNING], 3 [ERROR]
#  data/users.txt has 6 users: 3 admins, 2 developers, 1 tester
#
# ============================================================

# ------------------------------------------------------------------
# Q1 Create a symbolic link
#
# You are in exercise-files/
# Create a symbolic link named data-link that points to data/
#
# Expected side effect:
#   data-link  is a symlink pointing to data/
# ------------------------------------------------------------------
ANS1=""

# ------------------------------------------------------------------
# Q2 Make scripts executable with a glob
#
# You are in exercise-files/
# Make ALL .sh files in scripts/ executable (for all users) using a SINGLE chmod command.
# CONSTRAINT: you must NOT name files individually.
#
# Expected side effect:
#   scripts/run.sh    is executable
#   scripts/build.sh  is executable
#   scripts/deploy.sh is executable
# ------------------------------------------------------------------
ANS2=""

# ------------------------------------------------------------------
# Q3 Set permission using octal notation
#
# You are in exercise-files/
# Set data/notes.txt to permission rw-r--r-- using octal number.
# CONSTRAINT: answer must use the 3-digit octal number
#
# Expected side effect:
#   data/notes.txt will have a new permission rw-r--r--
# ------------------------------------------------------------------
ANS3=""

# ------------------------------------------------------------------
# Q4 Find files by extension
#
# You are in exercise-files/
# Find all .sh files anywhere under your current directory, sorted alphabetically.
# CONSTRAINT: must use find and "*.sh" (quoted).
#
# Expected output:
#   ./scripts/build.sh
#   ./scripts/deploy.sh
#   ./scripts/run.sh
# ------------------------------------------------------------------
ANS4=""

# ------------------------------------------------------------------
# Q5 Create a hard link
#
# You are in exercise-files/
# Create a hard link named scripts/run-copy.sh pointing to scripts/run.sh.
#
# Expected side effect:
#   scripts/run.sh and scripts/run-copy.sh share the SAME inode
#   (hard link count of run.sh becomes 2)
# ------------------------------------------------------------------
ANS5=""

# ------------------------------------------------------------------
# Q6 Search file contents with grep
#
# You are in exercise-files/
# Print all lines in data/users.txt that contain the word "admin".
#
# Expected output:
#   alice admin
#   charlie admin
#   frank admin
# ------------------------------------------------------------------
ANS6=""

# ------------------------------------------------------------------
# Q7 Find only regular files in a directory
#
# You are in exercise-files/
# Find all regular files (not directories) inside data/, sorted.
#
# Expected output:
#   data/logs.txt
#   data/notes.txt
#   data/users.txt
# ------------------------------------------------------------------
ANS7=""

# ------------------------------------------------------------------
# Q8 Count matching lines
#
# You are in exercise-files/
# Count how many lines in data/logs.txt contain "[ERROR]".
# CONSTRAINT: must use grep, and must not use the \ escape character
#
# Expected output:
#   3
# ------------------------------------------------------------------
ANS8=""

# ------------------------------------------------------------------
# Q9 Symbolic notation
#
# You are in exercise-files/
# Remove read permission from BOTH group and other on configs/app.cfg using a SINGLE chmod command with SYMBOLIC notation (octal number is not allowed).
# CONSTRAINT: must use chmod, must NOT contain a 3-digit octal number.
#
# Expected side effect:
#   configs/app.cfg has no group-read bit  (i.e. ----r---- bits = 0)
#   configs/app.cfg has no other-read bit  (i.e. -------r-- bits = 0)
# ------------------------------------------------------------------
ANS9=""

# ------------------------------------------------------------------
# Q10 Symbolic link with a relative path
#
# You are in exercise-files/
# Navigate into 'configs/', then create a symbolic link named 'data-link' that points to '../data' (relative path).
# Write the FULL command line (including the cd).
# CONSTRAINT: must NOT contain an absolute path.
#
# Expected side effect:
#   configs/data-link is a symlink whose target is ../data
# ------------------------------------------------------------------
ANS10=""

# ------------------------------------------------------------------
# Q11 Count non-matching lines with a pipe
#
# You are in exercise-files/
# Count how many lines in data/logs.txt do NOT contain "[INFO]".
# CONSTRAINT: must contain 'grep' and produce a plain number. Command must be ≤ 40 characters long. You must use the invert flag in the command.
#
# Expected output:
#   6
# ------------------------------------------------------------------
ANS11=""

# ------------------------------------------------------------------
# Q12 find + grep + wc pipeline
#
# You are in exercise-files/scripts/
# Find all .sh files in the current directory (and below), then for each file use grep to check if it contains "echo", then count how many FILES matched. Write the command as a single pipeline.
# CONSTRAINT: must contain find, grep, and '|'.
#
# Expected output:
#   3
#
# Hint: find <...> -exec grep -l <...> lists FILENAMES that match,
#       then pipe to wc -l to count them.
# ------------------------------------------------------------------
ANS12=""