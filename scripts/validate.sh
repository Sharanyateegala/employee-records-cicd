#!/bin/sh
set -eu
[ -f records.csv ] || { echo 'Missing records.csv'; exit 1; }
awk -F, '
  {sub(/\r$/, "", $0)}
  NR==1 { sub(/^\357\273\277/, "", $0); if ($0 != "Employee ID,Name,Department,City") {print "Wrong CSV header"; exit 1}; next }
  NF != 4 {print "Wrong number of columns on line " NR; exit 1}
  $1 !~ /^[0-9]+$/ || $2=="" || $3=="" || $4=="" {print "Invalid data on line " NR; exit 1}
  seen[$1]++ {print "Duplicate employee ID on line " NR; exit 1}
  END {if (NR < 2) {print "No employee records"; exit 1}; print "Validated " NR-1 " records"}
' records.csv
