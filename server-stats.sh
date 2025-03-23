USED_CPU=$(echo "100 - $(top -n 1 | head -n 3 | tail -n 1 | cut -d ',' -f 4 | tr -d " id" | cut -c 17-20)" | bc)
echo "Total CPU Usage: ${USED_CPU}%"

