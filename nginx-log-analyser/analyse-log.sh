#!/bin/bash
FORMAT_STR='{ print $2 " - " $1 " requests"}'

get_top_five () {
  TOP_FIVE=$(sort <<< "$1" | uniq -c | sort -nr | head -n5)
}

ADDRESSES=$(awk '{ print $1 }' ./logfile.txt)
get_top_five "${ADDRESSES}"
FORMATTED_ADDRESSES=$(awk "${FORMAT_STR}" <<< "${TOP_FIVE}")
printf "Top 5 IP addresses with the most requests:\n%s\n\n" "${FORMATTED_ADDRESSES}"

PATHS=$(cut -d'"' -f 2 ./logfile.txt | awk '{ print $2 }')
get_top_five "${PATHS}"
FORMATTED_PATHS=$(awk "${FORMAT_STR}" <<< "${TOP_FIVE}")
printf "Top 5 most requested paths:\n%s\n\n" "${FORMATTED_PATHS}"

STATUS_CODES=$(cut -d'"' -f 3 ./logfile.txt | awk '{ print $1 }')
get_top_five "${STATUS_CODES}"
FORMATTED_STATUSES=$(awk "${FORMAT_STR}" <<< "${TOP_FIVE}")
printf "Top 5 response status codes:\n%s\n\n" "${FORMATTED_STATUSES}"

USER_AGENTS=$(cut -d'"' -f 6 ./logfile.txt)
get_top_five "${USER_AGENTS}"
FORMATTED_AGENTS=$(awk '{ for (i=2; i<=NF; i++) printf $i " "; print "- " $1 " requests"}' <<< "${TOP_FIVE}")
printf "Top 5 user agents:\n%s\n" "${FORMATTED_AGENTS}"

