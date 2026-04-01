#!/usr/bin/env bash
# ============================================================
#  ANSWER SHEET — Exercise Set 01
#  Basic Commands & File Viewing
# ============================================================
#  Instructions:
#    1. Run the setup first:  bash ex-01-basic-and-viewing.sh
#    2. Fill in each ANS variable below with your answer.
#       - If the question asks for a COMMAND, store the command
#         as a string, e.g.  ANS1="head -5 fruits.txt"
#       - If it asks for a STRING OUTPUT, store the exact output.
#    3. Save this file, then run:  bash test.sh
# ============================================================

# ------------------------------------------------------------------
# Q1 [Easy] — Command Type
#
# Run `type cd` in your terminal. What is the EXACT output string?
# (Copy-paste the output as the value of ANS1.)
#
# Expected output format:  cd is a ____________
# ------------------------------------------------------------------
ANS1="cd is a function with definition"

# ------------------------------------------------------------------
# Q2 [Easy] — cat with line numbers
# 
# You are in ~/ex01/
# Write a command to display fruits.txt WITH line numbers.
# CONSTRAINT: Your command must use 'cat' and the '-n' flag.
#
# Expected output (first 3 lines shown):
#      1	apple
#      2	banana
#      3	cherry
#      ...
# ------------------------------------------------------------------
ANS2=""

# ------------------------------------------------------------------
# Q3 [Easy] — head
# 
# You are in ~/ex01/
# Show ONLY the first 4 lines of fruits.txt.
#
# Expected output:
#   apple
#   banana
#   cherry
#   durian
# ------------------------------------------------------------------
ANS3=""

# ------------------------------------------------------------------
# Q4 [Easy] — tail
# 
# You are in ~/ex01/
# Show ONLY the last 4 lines of fruits.txt.
#
# Expected output:
#   grape
#   honeydew
#   kiwi
#   lemon
# ------------------------------------------------------------------
ANS4=""

# ------------------------------------------------------------------
# Q5 [Medium] — tac
# 
# You are in ~/ex01/
# Display fruits.txt in REVERSE line order (last line first).
#
# Expected output:
#   lemon
#   kiwi
#   honeydew
#   ...
#   apple
# ------------------------------------------------------------------
ANS5=""

# ------------------------------------------------------------------
# Q6 [Medium] — cd + tail (no path separator allowed)
# 
# Your command will be executed from INSIDE ~/ex01/logs/
# Show the LAST 5 lines of app.log.
# CONSTRAINT: Your answer must NOT contain any '/' character.
#             (You are already inside logs/ — no path needed!)
#
# Expected output (last 5 lines of app.log):
#   [2026-03-01 17:30] INFO: Running diagnostics
#   [2026-03-01 18:00] WARNING: Low disk space
#   [2026-03-01 19:00] INFO: Maintenance window started
#   [2026-03-01 20:00] INFO: Patches applied
#   [2026-03-01 21:00] INFO: System shutdown
# ------------------------------------------------------------------
ANS6=""

# ------------------------------------------------------------------
# Q7 [Medium] — pipe: head + tail
# 
# You are in ~/ex01/
# Show lines 4 through 7 of fruits.txt using a PIPE between
# exactly two commands (head and tail). No sed, awk, or grep.
# CONSTRAINT: Answer must contain '|' and be ≤ 40 characters long.
#
# Expected output:
#   durian
#   elderberry
#   fig
#   grape
# ------------------------------------------------------------------
ANS7=""

# ------------------------------------------------------------------
# Q8 [Hard] — stderr redirection
# 
# You are in ~/ex01/
# Run cat on fruits.txt AND a non-existent file called "nofile".
# Redirect ONLY the stderr (error message) to a file called errors.txt
# so that the fruit list still appears as normal output.
# CONSTRAINT: Your answer must contain '2>' to prove you're
#             redirecting stderr explicitly.
#
# Expected stdout (on screen):
#   apple
#   banana
#   ...
#   lemon
#
# Side effect: errors.txt is created in ~/ex01/ containing the error.
# ------------------------------------------------------------------
ANS8=""

# ------------------------------------------------------------------
# Q9 [Hard] — pipe: tac + head, with length constraint
# 
# You are in ~/ex01/
# Using tac and head in a pipe, show the LAST 3 fruits in
# fruits.txt (i.e., the 3 fruits that appear at the BOTTOM of
# the file), with the bottom-most fruit appearing FIRST.
# CONSTRAINT: Answer must be ≤ 30 characters long.
#
# Expected output:
#   lemon
#   kiwi
#   honeydew
# ------------------------------------------------------------------
ANS9=""
