#!/usr/bin/env bash
# Developer: Hamdy Abou El Anein
# Contact: hamdy.aea@protonmail.com
# SPDX-License-Identifier: GPL-3.0-or-later
# One HTTPS request with a timeout; no external code execution.
set -o pipefail
city="${PRAYER_CITY:-Arconciel}"
country="${PRAYER_COUNTRY:-CH}"
timezone="${PRAYER_TIMEZONE:-Europe/Zurich}"
if ! command -v jq >/dev/null 2>&1; then
    printf 'Prayer times unavailable (install jq)\n'
    exit 1
fi
response="$(curl -fsSL --max-time 12 --get \
    --data-urlencode "city=$city" \
    --data-urlencode "country=$country" \
    --data-urlencode "method=5" \
    --data-urlencode "timezonestring=$timezone" \
    'https://api.aladhan.com/v1/timingsByCity' 2>/dev/null)" || {
    printf 'Prayer times unavailable\n'
    exit 1
}
jq -er '
  select(.code == 200 and .data.timings.Fajr != null) |
  "Fajr \(.data.timings.Fajr) Dhuhr \(.data.timings.Dhuhr) Asr \(.data.timings.Asr) Maghrib \(.data.timings.Maghrib) Isha \(.data.timings.Isha)\n\(.data.date.hijri.weekday.en) \(.data.date.hijri.date) \(.data.date.readable)"
' <<< "$response" || {
    printf 'Prayer times unavailable (invalid response)\n'
    exit 1
}
