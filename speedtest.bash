#!/bin/bash

# Developer : Hamdy Abou El Anein
# hamdy.aea@protonmail.com

wget -q --spider https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py

if [ $? -eq 0  ]; then

    speedtest="$(curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python - --secure)"
    echo $speedtest > speedresult
    downspeed="$(cat speedresult| cut -d ':' -f 3 | cut -c -13)"
    upspeed="$(cat speedresult | cut -d ':' -f 4)"
    pingresult="$(cat speedresult| cut -d ':' -f 2 | cut -c -7)"

else

    downspeed=" 0"
    upspeed=" 0"
    pingresult=" 0"
fi

echo "Down"$downspeed "Up"$upspeed "Ping"$pingresult
