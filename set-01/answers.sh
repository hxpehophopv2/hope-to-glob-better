#!/usr/bin/env bash
# ============================================================
#  ANSWER SHEET — Exercise Set 01
#  Basic Commands & File Viewing
# ============================================================
#  Instructions:
#    1. Run the setup first:  bash setup.sh
#    2. Fill in each ANS variable below with your answer.
#       - If the question asks for a COMMAND, store the command
#         as a string, e.g.  ANS1="head -5 fruits.txt"
#       - If it asks for a STRING OUTPUT, store the exact output.
#    3. Save this file, then run:  bash test.sh
# ============================================================

# ------------------------------------------------------------------
# Q1 Command Type
#
# Run `type cd` in your terminal. What is the EXACT output string?
# ------------------------------------------------------------------
ANS1=""

# ------------------------------------------------------------------
# Q2 Display a file with line numbers
# 
# You are in ./exercise-files/
# Write a command to display fruits.txt WITH line numbers.
# CONSTRAINT: Your command must use 'cat'.
#
# Expected output (first 3 lines shown):
#      1	apple
#      2	banana
#      3	cherry
#      ...
# ------------------------------------------------------------------
ANS2=""

# ------------------------------------------------------------------
# Q3 First lines in a file
# 
# You are in ./exercise-files/
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
# Q4 Last lines in a file
# 
# You are in ./exercise-files/
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
# Q5 Display a file in reverse
# 
# You are in ./exercise-files/
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
# Q6 Multiple commands
# 
# You are at ./exercise-files/ but your command will be executed from INSIDE ./exercise-files/logs/
# Show the LAST 5 lines of ./exercise-files/logs/app.log by going in the .ex-files/logs/ then run a command to display it.
# CONSTRAINT: Your answer must NOT contain any '/' character.
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
# Q7 Show lines in between
# 
# You are in ./exercise-files/
# Show lines 4 through 7 of fruits.txt using a PIPE between. No sed, awk, or grep.
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
# Q8 stderr redirection
# 
# You are in ./exercise-files/
# Run cat on fruits.txt AND a non-existent file called "nofile".
# Redirect ONLY the stderr error message to a file called errors.txt so that the fruit list still appears as normal output.
# CONSTRAINT: Your answer must redirect stderr explicitly.
#
# Expected stdout (on screen):
#   apple
#   banana
#   ...
#   lemon
#
# Side effect: errors.txt is created in ./exercise-files/ containing the error.
# ------------------------------------------------------------------
ANS8=""

# ------------------------------------------------------------------
# Q9 Reverse the last lines of a file
# 
# You are in ./exercise-files/
# Show the LAST 3 fruits in fruits.txt is REVERSING order.
# CONSTRAINT: Answer must be ≤ 30 characters long.
#
# Expected output:
#   lemon
#   kiwi
#   honeydew
# ------------------------------------------------------------------
ANS9=""
