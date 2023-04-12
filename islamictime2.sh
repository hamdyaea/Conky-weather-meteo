#!/usr/bin/bash

response=$(curl -s http://api.aladhan.com/v1/timingsByCity\?city\=Arconciel\&country\=CH\&method\=5\&timezonestring\=Europe/Zurich 2>/dev/null)

if [ $? -eq 0 ]; then
  fajr=$(echo $response | jq '.data.timings.Fajr' | sed 's/\"//g')
  dhuhr=$(echo $response | jq '.data.timings.Dhuhr' | sed 's/\"//g')
  asr=$(echo $response | jq '.data.timings.Asr' | sed 's/\"//g')
  maghrib=$(echo $response | jq '.data.timings.Maghrib' | sed 's/\"//g')
  isha=$(echo $response | jq '.data.timings.Isha' | sed 's/\"//g')
  hijri_weekday=$(echo $response | jq '.data.date.hijri.weekday.en' | sed 's/\"//g')
  hijri_date=$(echo $response | jq '.data.date.hijri.date' | sed 's/\"//g')
  readable_date=$(echo $response | jq '.data.date.readable' | sed 's/\"//g')

  echo "Fajr $fajr Dhuhr $dhuhr Asr $asr Maghrib $maghrib Isha $isha"
  echo "$hijri_weekday $hijri_date $readable_date"
else
  echo ""
fi

