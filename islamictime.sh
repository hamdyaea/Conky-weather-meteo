#!/bin/sh

# Developer : Hamdy Abou El Anein
#
# hamdy.aea@protonmail.com

echo "Fajr" $(curl http://api.aladhan.com/v1/timingsByCity\?city\=Arconciel\&country\=CH\&method\=5\&timezonestring\=Europe/Zurich | jq '.data.timings.Fajr'|sed 's/\"//'|sed 's/\"//') " Dhuhr" $(curl http://api.aladhan.com/v1/timingsByCity\?city\=Arconciel\&country\=CH\&method\=5\&timezonestring\=Europe/Zurich | jq '.data.timings.Dhuhr'|sed 's/\"//'|sed 's/\"//')
echo "Asr" $(curl http://api.aladhan.com/v1/timingsByCity\?city\=Arconciel\&country\=CH\&method\=5\&timezonestring\=Europe/Zurich | jq '.data.timings.Asr'|sed 's/\"//'|sed 's/\"//')" Maghrib" $(curl http://api.aladhan.com/v1/timingsByCity\?city\=Arconciel\&country\=CH\&method\=5\&timezonestring\=Europe/Zurich | jq '.data.timings.Maghrib'|sed 's/\"//'|sed 's/\"//')
echo "Isha" $(curl http://api.aladhan.com/v1/timingsByCity\?city\=Arconciel\&country\=CH\&method\=5\&timezonestring\=Europe/Zurich | jq '.data.timings.Isha'|sed 's/\"//'|sed 's/\"//')
echo $(curl http://api.aladhan.com/v1/timingsByCity\?city\=Arconciel\&country\=CH\&method\=5\&timezonestring\=Europe/Zurich | jq '.data.date.hijri.weekday.en'|sed 's/\"//'|sed 's/\"//')
echo $(curl http://api.aladhan.com/v1/timingsByCity\?city\=Arconciel\&country\=CH\&method\=5\&timezonestring\=Europe/Zurich | jq '.data.date.hijri.date'|sed 's/\"//'|sed 's/\"//')" " $(curl http://api.aladhan.com/v1/timingsByCity\?city\=Arconciel\&country\=CH\&method\=5\&timezonestring\=Europe/Zurich | jq '.data.date.readable'| sed 's/\"//'|sed 's/\"//')
