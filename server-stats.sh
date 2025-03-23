#!/bin/bash

# Constants
SEPARATOR="=============================================="
echo "${SEPARATOR}"

# CPU Usage
FREE_CPU=$(top -n 1 | head -n 3 | tail -n 1 | cut -d ',' -f 4 | tr -d " id" | cut -c 17-20)
USED_CPU=$(echo "100 - ${FREE_CPU}" | bc)
printf "Total CPU Usage: %.1f%%\n%s\n" "${USED_CPU}" "${SEPARATOR}"

# Memory Usage
MEM_DATA=$(free | head -n 2 | tail -1 | tr -s ' ')
MEM_TOTAL_KB=$(cut -d ' ' -f 2 <<< "${MEM_DATA}")
MEM_USED_KB=$(cut -d ' ' -f 3 <<< "${MEM_DATA}")
MEM_FREE_KB=$(cut -d ' ' -f 4 <<< "${MEM_DATA}")
MEM_USED_PCT=$(echo "100 * ${MEM_USED_KB} / ${MEM_TOTAL_KB}" | bc -l)
MEM_FREE_PCT=$(echo "100 - ${MEM_USED_PCT}" | bc -l)
printf "Memory Usage:\n  Used: %s (%.1f%%)\n  Free: %s (%.1f%%)\n%s\n" \
  "$(echo "${MEM_USED_KB}000" | numfmt --to=iec-i)" \
  "${MEM_USED_PCT}" \
  "$(echo "${MEM_FREE_KB}000" | numfmt --to=iec-i)" \
  "${MEM_FREE_PCT}" \
  "${SEPARATOR}"

