TOP_ADDRESSES=$(awk '{ print $1 }' ./logfile.txt | sort | uniq -c | sort -nr | head -n5)
FORMATTED_ADDRESSES=$(awk '{ print $2 " - " $1 " requests"}' <<< "${TOP_ADDRESSES}")
printf "Top 5 IP addresses with the most requests:\n%s\n\n" "${FORMATTED_ADDRESSES}"

REQ_LINES=$(cut -d'"' -f 2 ./logfile.txt)
TOP_PATHS=$(awk '{ print $2 }' <<< "${REQ_LINES}" | sort | uniq -c | sort -nr | head -n5)
FORMATTED_PATHS=$(awk '{ print $2 " - " $1 " requests"}' <<< "${TOP_PATHS}")
printf "Top 5 most requested paths:\n%s\n" "${FORMATTED_PATHS}"

