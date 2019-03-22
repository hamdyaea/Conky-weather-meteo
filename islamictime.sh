#!/bin/sh

# Developer : Hamdy Abou El Anein


echo "Fajr" $(curl http://api.aladhan.com/v1/timingsByCity\?city\=Arconciel\&country\=CH\&method\=5\&timezonestring\=Europe/Zurich | jq '.data.timings.Fajr') " Dhuhr" $(curl http://api.aladhan.com/v1/timingsByCity\?city\=Arconciel\&country\=CH\&method\=5\&timezonestring\=Europe/Zurich | jq '.data.timings.Dhuhr')
echo "Asr" $(curl http://api.aladhan.com/v1/timingsByCity\?city\=Arconciel\&country\=CH\&method\=5\&timezonestring\=Europe/Zurich | jq '.data.timings.Asr')" Maghrib" $(curl http://api.aladhan.com/v1/timingsByCity\?city\=Arconciel\&country\=CH\&method\=5\&timezonestring\=Europe/Zurich | jq '.data.timings.Maghrib')
echo "Isha" $(curl http://api.aladhan.com/v1/timingsByCity\?city\=Arconciel\&country\=CH\&method\=5\&timezonestring\=Europe/Zurich | jq '.data.timings.Isha')
echo $(curl http://api.aladhan.com/v1/timingsByCity\?city\=Arconciel\&country\=CH\&method\=5\&timezonestring\=Europe/Zurich | jq '.data.date.hijri.weekday.en')
echo $(curl http://api.aladhan.com/v1/timingsByCity\?city\=Arconciel\&country\=CH\&method\=5\&timezonestring\=Europe/Zurich | jq '.data.date.hijri.date')" " $(curl http://api.aladhan.com/v1/timingsByCity\?city\=Arconciel\&country\=CH\&method\=5\&timezonestring\=Europe/Zurich | jq '.data.date.readable')