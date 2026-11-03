#!/usr/bin/env bash
# Developer: Hamdy Abou El Anein
# Contact: hamdy.aea@protonmail.com
# SPDX-License-Identifier: GPL-3.0-or-later
# Compatibility wrapper for the historical Conky configuration.
exec "$(dirname -- "$0")/speedtest2.bash" "$@"
