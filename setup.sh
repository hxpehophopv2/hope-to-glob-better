#!/usr/bin/env bash

mkdir globbing-exercise/
cd globbing-exercise/
touch file1.txt file2.txt file3.txt file4.txt file5.txt file6.txt file7.md file8.txt file9.txt file10.txt file11.txt file12.txt file13.txt
touch fileA.txt fileB.txt fileC3.txt fileD4.txt
echo ".txt files ready!"

touch .secret.config .config secret.config this\ some\ space.md
echo "Secret files ready!"

mkdir ../site-exercise/
cd ../site-exercise/
touch index.html style-hope.css style-ken.css style-nine.css style-global.css
echo "Site practice ready!"

mkdir reports/
cd ../reports/
touch report_2025_01.pdf report_2025_02.pdf report_2026_3.pdf report_2025_3.pdf rep_2025_4.pdf rep_2025_5.pdf

cd ..
touch dump.log
echo "Dump setup completed!"

echo "Full setup completed!"
