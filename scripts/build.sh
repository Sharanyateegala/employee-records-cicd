#!/bin/sh
set -eu
mkdir -p dist
awk -F, '
function escape(s) {
  gsub(/&/, "\&amp;", s)
  gsub(/</, "\&lt;", s)
  gsub(/>/, "\&gt;", s)
  gsub(/"/, "\&quot;", s)
  return s
}
{sub(/\r$/, "", $0)}
NR == 1 {next}
{ count++; rows = rows "<tr><td>" escape($1) "</td><td>" escape($2) "</td><td>" escape($3) "</td><td>" escape($4) "</td></tr>\n" }
END {
 print "<!doctype html><html lang=\"en\"><head><meta charset=\"utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"><title>Employee Records</title>"
 print "<style>body{font-family:Arial,sans-serif;margin:32px;max-width:960px;color:#1f2937}h1{color:#163b65}table{border-collapse:collapse;width:100%}th,td{border:1px solid #cbd5e1;padding:10px;text-align:left}th{background:#e9f2fc}tr:nth-child(even){background:#f8fafc}</style></head><body>"
 print "<h1>Employee Records</h1><p><strong>Total employees: " count "</strong></p>"
 print "<table><thead><tr><th>Employee ID</th><th>Name</th><th>Department</th><th>City</th></tr></thead><tbody>"
 printf "%s", rows
 print "</tbody></table></body></html>"
}
' records.csv > dist/index.html
printf 'Built webpage with %s employees\n' "$(awk 'END{print NR-1}' records.csv)"
