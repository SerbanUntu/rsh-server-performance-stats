#!/bin/bash
FREE_CPU=$(top -n 1 | head -n 3 | tail -n 1 | cut -d ',' -f 4 | tr -d " id" | cut -c 17-20)
USED_CPU=$(echo "100 - ${FREE_CPU}" | bc)
echo "Total CPU Usage: ${USED_CPU}%"

