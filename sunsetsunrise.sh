#!/bin/sh

# Developer : Hamdy Abou El Anein

# How to configure :


# Make this shell script executable with : chmod +x sunsetsunrise.sh
# In .conkyrc change the path to this script : /home/yourname/sunsetsunrise.ch
# If you are like me in the UTC +1 time zone let the +1 like this : h: ((.[3] + 1). If you are on UTC put 0, on UTC +2 put +2 etc
# Change the latitude and longitude to you current location after : lat= and lng= You can find your lat and lng there  : https://www.latlong.net/


echo "Lever du soleil "$(curl "https://api.sunrise-sunset.org/json?lat=46.745995&lng=7.122781&date=today" | jq '.results.sunrise | strptime("%I:%M:%S %p")| {h: ((.[3] + 1) % 24), m:.[4], s:.[5]}| if .h < 12 then "\(.h):\(.m):\(.s) AM" elif .h == 12 then "\(.h):\(.m):\(.s) PM" else "\(.h - 12):\(.m):\(.s) PM" end' | sed 's/\"//'| sed 's/\"//')
echo "Couché du soleil "$(curl "https://api.sunrise-sunset.org/json?lat=46.745995&lng=7.122781&date=today" | jq '.results.sunset | strptime("%I:%M:%S %p")| {h: ((.[3] + 1) % 24), m:.[4], s:.[5]}| if .h < 12 then "\(.h):\(.m):\(.s) AM" elif .h == 12 then "\(.h):\(.m):\(.s) PM" else "\(.h - 12):\(.m):\(.s) PM" end'| sed 's/\"//'| sed 's/\"//')








