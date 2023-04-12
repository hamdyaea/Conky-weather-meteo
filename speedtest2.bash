#!/usr/bin/bash

speedtest=$(curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py 2>/dev/null| python - --secure)
if [ $? -eq 0 ]; then
    downspeed=$(echo "$speedtest" | grep Download | awk '{print $2}')
    upspeed=$(echo "$speedtest" | grep Upload | awk '{print $2}')
    pingresult=$(echo "$speedtest" |  grep 'Hosted' | cut -d ':' -f 2)
else
    downspeed=""
    upspeed=""
    pingresult=""
fi

echo "Down $downspeed Up $upspeed Ping $pingresult"
