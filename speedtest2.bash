#!/usr/bin/env bash
# Developer: Hamdy Abou El Anein
# Contact: hamdy.aea@protonmail.com
# SPDX-License-Identifier: GPL-3.0-or-later
# Use the locally installed speedtest-cli; NEVER download and execute remote code.
set -o pipefail
if ! command -v speedtest-cli >/dev/null 2>&1; then
    printf 'Down N/A Up N/A Ping N/A (install speedtest-cli)\n'
    exit 1
fi
result="$(timeout 50s speedtest-cli --json --secure --timeout 8 2>/dev/null)" || {
    printf 'Down N/A Up N/A Ping N/A (test unavailable)\n'
    exit 1
}
python3 -c '
import json, sys
try:
    data = json.load(sys.stdin)
    download = float(data["download"]) / 1_000_000
    upload = float(data["upload"]) / 1_000_000
    ping = float(data["ping"])
    print(f"Down {download:.2f} Mbps Up {upload:.2f} Mbps Ping {ping:.1f} ms")
except (KeyError, ValueError, TypeError, OverflowError, json.JSONDecodeError):
    print("Down N/A Up N/A Ping N/A (invalid response)")
    sys.exit(1)
' <<< "$result"
