#!/bin/bash

echo "Input date format: year-month-day"

read date

echo "Searching for matching IPs"

ips=$(cat /srv/db/webhoneypot-$date.json | jq '.["sip"]' | sort | uniq | cut -d '"' -f 2)

for i in $ips; do
    cat /srv/cowrie/var/log/cowrie/cowrie.log.$date | cut -d ' ' -f 2 | cut -d ',' -f 3 | cut -d ']' -f 1 | grep $i | sort | uniq -c
done

echo "Finished"
