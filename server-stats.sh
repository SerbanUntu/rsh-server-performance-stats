#!/bin/bash

# Constants
TOP_DATA=$(top -b -n 1)
SEPARATOR="=============================================="
echo "${SEPARATOR}"

# CPU Usage
FREE_CPU=$(echo "${TOP_DATA}" | head -n 3 | tail -n 1 | cut -d ',' -f 4 | awk '{ print $1 }')
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

# Disk Usage
DISK_DATA=$(df -h | grep "C:\\\\" | tr -s ' ')
DISK_USED=$(cut -d ' ' -f 3 <<< "${DISK_DATA}")
DISK_FREE=$(cut -d ' ' -f 4 <<< "${DISK_DATA}")
DISK_USED_PCT=$(echo "${DISK_DATA}" | cut -d ' ' -f 5 | tr -d '%')
DISK_FREE_PCT=$(echo "100 - ${DISK_USED_PCT}" | bc -l)
printf "Disk Usage:\n  Used: %s (%.1f%%)\n  Free: %s (%.1f%%)\n%s\n" \
  "${DISK_USED}" \
  "${DISK_USED_PCT}" \
  "${DISK_FREE}" \
  "${DISK_FREE_PCT}" \
  "${SEPARATOR}"

# Top 5 Processes by CPU Usage
TOP_5_CPU=$(echo "${TOP_DATA}" | tail +8 | sort -r -k9 | awk '{ print "  " $9 "%", $12, "(PID: " $1 ")" }' | head -n 5)
printf "Top 5 Processes by CPU Usage:\n%s\n%s\n" "${TOP_5_CPU}" "${SEPARATOR}"

# Top 5 Processes by Memory Usage
TOP_5_MEM=$(echo "${TOP_DATA}" | tail +8 | sort -r -k10 | awk '{ print "  " $10 "%", $12, "(PID: " $1 ")" }' | head -n 5)
printf "Top 5 Processes by Memory Usage:\n%s\n%s\n" "${TOP_5_MEM}" "${SEPARATOR}"

