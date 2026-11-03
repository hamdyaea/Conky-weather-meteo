#!/usr/bin/env bash
# Developer: Hamdy Abou El Anein
# Contact: hamdy.aea@protonmail.com
# SPDX-License-Identifier: GPL-3.0-or-later
# API timestamps are UTC; GNU date converts them to the machine local timezone.
set -o pipefail
latitude="${SUN_LAT:-46.745995}"
longitude="${SUN_LON:-7.122781}"
if [[ ! "$latitude" =~ ^-?[0-9]+([.][0-9]+)?$ ||
      ! "$longitude" =~ ^-?[0-9]+([.][0-9]+)?$ ]]; then
    printf 'Sunrise/sunset unavailable (invalid coordinates)\n'
    exit 2
fi
response="$(curl -fsSL --max-time 12 --get \
    --data-urlencode "lat=$latitude" --data-urlencode "lng=$longitude" \
    --data-urlencode "date=today" \
    'https://api.sunrise-sunset.org/json' 2>/dev/null)" || {
    printf 'Sunrise/sunset unavailable\n'
    exit 1
}
if ! jq -e '.status == "OK" and .results.sunrise != null and .results.sunset != null' <<< "$response" >/dev/null; then
    printf 'Sunrise/sunset unavailable (invalid response)\n'
    exit 1
fi
sunrise="$(jq -r '.results.sunrise' <<< "$response")"
sunset="$(jq -r '.results.sunset' <<< "$response")"
local_sunrise="$(date -d "$sunrise UTC" +%H:%M:%S)" || exit 1
local_sunset="$(date -d "$sunset UTC" +%H:%M:%S)" || exit 1
printf 'Lever du soleil : %s\nCoucher du soleil : %s\n' "$local_sunrise" "$local_sunset"
