#!/usr/bin/env bash
# ============================================================
#  ANSWER SHEET — Exercise Set 02
#  Directory Structure & Operations
# ============================================================
#  Instructions:
#    1. Run setup first:   bash setup.sh
#    2. Fill in each ANS variable below.
#       - Questions asking for a COMMAND → write the command string.
#       - Questions asking for an OUTPUT → write the exact output.
#    3. Save this file, then run:  bash test.sh
# ============================================================
#
#  exercise-files/ structure:
#    ├── project/
#    │   ├── src/         ← main.sh  utils.sh  config.cfg
#    │   ├── docs/        ← api.md  readme.txt
#    │   └── tests/       ← test1.sh  test2.sh
#    ├── archive/         ← legacy.sh
#    └── tmp/
#
# ============================================================

# ------------------------------------------------------------------
# Q1 Which command?
#
# What is the command that prints the current working directory?
# ------------------------------------------------------------------
ANS1=""

# ------------------------------------------------------------------
# Q2 Create multiple files at once
#
# You are in exercise-files/
# Create THREE files — note1.txt, note2.txt, note3.txt — using
# a SINGLE touch command with brace expansion.
# CONSTRAINT: your command must contain '{' (brace expansion syntax).
#
# Expected side effect: all three files exist in exercise-files/
# ------------------------------------------------------------------
ANS2=""

# ------------------------------------------------------------------
# Q3 Create nested directories in one shot
#
# You are in exercise-files/
# Create the directory chain:  levels/l1/l2/l3
# using a SINGLE mkdir command.
#
# Expected side effect: exercise-files/levels/l1/l2/l3/ exists
# ------------------------------------------------------------------
ANS3=""

# ------------------------------------------------------------------
# Q4 List a directory's contents
#
# You are in exercise-files/
# List the contents of project/src/ using ls.
#
# Expected output:
#   config.cfg
#   main.sh
#   utils.sh
# ------------------------------------------------------------------
ANS4=""

# ------------------------------------------------------------------
# Q5 Navigate with relative paths
#
# You are INSIDE exercise-files/project/docs/
# List the contents of project/src/ using a RELATIVE path
#
# Expected output:
#   config.cfg
#   main.sh
#   utils.sh
# ------------------------------------------------------------------
ANS5=""

# ------------------------------------------------------------------
# Q6 Copy a directory recursively
#
# You are in exercise-files/
# Copy the ENTIRE project/docs/ directory into archive/. After this, archive/docs/ must exist inside exercise-files/archive/.
#
# Expected side effect:
#   archive/docs/api.md      exists
#   archive/docs/readme.txt  exists
#   archive/legacy.sh        still exists (untouched)
# ------------------------------------------------------------------
ANS6=""

# ------------------------------------------------------------------
# Q7 Move multiple files using a glob
#
# You are in exercise-files/
# Move BOTH test1.sh and test2.sh from project/tests/ into archive/ using a SINGLE mv command.
# CONSTRAINT: do NOT name the files individually. Command must be ≤ 40 characters long.
#
# Expected side effect:
#   archive/test1.sh   exists
#   archive/test2.sh   exists
#   project/tests/     contains no .sh files
# ------------------------------------------------------------------
ANS7=""

# ------------------------------------------------------------------
# Q8 Create and remove a directory chain in one line
#
# You are in exercise-files/
# In ONE command line, do BOTH of the following:
#   1. Create the nested directory:  tmp/x/y/z
#   2. Remove the entire chain:      tmp/x/y/z
# CONSTRAINT: command must use ';' or '&&' to chain them.
#
# Expected side effect: exercise-files/tmp/ exists but is EMPTY
#                       (the x/y/z chain was created then removed)
# ------------------------------------------------------------------
ANS8=""

# ------------------------------------------------------------------
# Q9 Navigate deep with relative paths, then list
#
# You are INSIDE exercise-files/project/tests/
# Navigate to exercise-files/archive/ using ONLY relative paths, then list its contents.
# CONSTRAINT: must NOT use an absolute path.
#
# Expected output (from ls inside archive/):
#   legacy.sh
# ------------------------------------------------------------------
ANS9=""

# ------------------------------------------------------------------
# Q10 Rename a directory, concisely
#
# You are in exercise-files/
# Rename the project/ directory to my-project/.
# CONSTRAINT: command must be ≤ 25 characters long.
#
# Expected side effect:
#   my-project/  exists (with all its original contents)
#   project/     no longer exists
# ------------------------------------------------------------------
ANS10=""

# ------------------------------------------------------------------
# Q11 Remove files by pattern without naming them
#
# You are in exercise-files/
# Remove ALL .sh files inside project/tests/ in ONE rm command.
# CONSTRAINT: must NOT contain the literal strings 'test1' or 'test2'.
#
# Expected side effect: no .sh files remain in project/tests/
# ------------------------------------------------------------------
ANS11=""

# ------------------------------------------------------------------
# Q12 Chain three operations into one release pipeline
#
# You are in exercise-files/
# Accomplish ALL of the following in a SINGLE command line:
#   1. Create a directory called backup/ in exercise-files/
#   2. Copy all files from project/src/ INTO backup/ (copy the FILES, not the directory itself)
#   3. Rename backup/ to project/release/
#
# Expected side effect:
#   project/release/config.cfg  exists
#   project/release/main.sh     exists
#   project/release/utils.sh    exists
#   backup/                     does NOT exist
# ------------------------------------------------------------------
ANS12=""