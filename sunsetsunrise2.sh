#!/usr/bin/bash

# Developer : Hamdy Abou El Anein

# How to configure :


# Make this shell script executable with : chmod +x sunsetsunrise.sh
# In .conkyrc change the path to this script : /home/yourname/sunsetsunrise.ch
# If you are like me in the UTC +1 time zone let the +1 like this : h: ((.[3] + 1). If you are on UTC put 0, on UTC +2 put +2 etc
# Change the latitude and longitude to you current location after : lat= and lng= You can find your lat and lng there  : https://www.latlong.net/

sunrise=$(curl -s "https://api.sunrise-sunset.org/json?lat=46.745995&lng=7.122781&date=today" 2>/dev/null| jq -r '.results.sunrise')
if [ "$sunrise" != "null" ]; then
    sunrise=$(date -d "$sunrise" +%H:%M:%S)
else
    sunrise=""
fi

sunset=$(curl -s "https://api.sunrise-sunset.org/json?lat=46.745995&lng=7.122781&date=today" 2>/dev/null| jq -r '.results.sunset')
if [ "$sunset" != "null" ]; then
    sunset=$(date -d "$sunset" +%H:%M:%S)
else
    sunset=""
fi

echo "Lever du soleil : $sunrise"
echo "Coucher du soleil : $sunset"








