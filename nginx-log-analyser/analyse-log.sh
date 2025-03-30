TOP_ADDRESSES=$(awk '{ print $1 }' ./logfile.txt | uniq -c | sort -nr | head -n5)
FORMATTED_ADDRESSES=$(awk '{ print $2 " - " $1 " requests"}' <<< "${TOP_ADDRESSES}")
printf "Top 5 IP addresses with the most requests:\n%s\n" "${FORMATTED_ADDRESSES}"
