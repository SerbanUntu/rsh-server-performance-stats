FORMAT_STR='{ print $2 " - " $1 " requests"}'

TOP_ADDRESSES=$(awk '{ print $1 }' ./logfile.txt | sort | uniq -c | sort -nr | head -n5)
FORMATTED_ADDRESSES=$(awk "${FORMAT_STR}" <<< "${TOP_ADDRESSES}")
printf "Top 5 IP addresses with the most requests:\n%s\n\n" "${FORMATTED_ADDRESSES}"

REQ_LINES=$(cut -d'"' -f 2 ./logfile.txt)
TOP_PATHS=$(awk '{ print $2 }' <<< "${REQ_LINES}" | sort | uniq -c | sort -nr | head -n5)
FORMATTED_PATHS=$(awk "${FORMAT_STR}" <<< "${TOP_PATHS}")
printf "Top 5 most requested paths:\n%s\n\n" "${FORMATTED_PATHS}"

STATUS_CODES=$(cut -d'"' -f 3 ./logfile.txt | awk '{ print $1 }')
TOP_STATUSES=$(sort <<< "${STATUS_CODES}" | uniq -c | sort -nr | head -n5)
FORMATTED_STATUSES=$(awk "${FORMAT_STR}" <<< "${TOP_STATUSES}")
printf "Top 5 response status codes:\n%s\n" "${FORMATTED_STATUSES}"

