#!/usr/bin/env python3
# Developer: Hamdy Abou El Anein
# Contact: hamdy.aea@protonmail.com
# SPDX-License-Identifier: GPL-3.0-or-later
"""Offline script tests: fake curl and speedtest-cli, never access internet."""
import os
from pathlib import Path
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]


class ConkyScriptsTests(unittest.TestCase):
    def run_script(self, name, mocks=None, env_extra=None):
        with tempfile.TemporaryDirectory() as tmp:
            for cmd, response in (mocks or {}).items():
                script = Path(tmp) / cmd
                script.write_text('#!/bin/sh\ncat <<\'RESPONSE\'\n' + response + '\nRESPONSE\n')
                script.chmod(0o700)
            env = dict(os.environ, PATH=tmp + ":" + os.environ.get("PATH", ""), TZ="Europe/Zurich")
            env.update(env_extra or {})
            return subprocess.run(["bash", str(ROOT / name)], capture_output=True,
                                  text=True, env=env, timeout=15)

    def test_speedtest_json(self):
        data = '{"download":40000000,"upload":12000000,"ping":19.5}'
        result = self.run_script("speedtest2.bash", {"speedtest-cli": data})
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("Down 40.00 Mbps Up 12.00 Mbps Ping 19.5 ms", result.stdout)

    def test_speedtest_invalid_json(self):
        result = self.run_script("speedtest2.bash", {"speedtest-cli": "not-json"})
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("N/A", result.stdout)

    def test_prayer_one_request(self):
        response = '{"code":200,"data":{"timings":{"Fajr":"05:12","Dhuhr":"12:20","Asr":"15:12","Maghrib":"17:00","Isha":"18:40"},"date":{"hijri":{"weekday":{"en":"Tuesday"},"date":"22-05-1448"},"readable":"03 Nov 2026"}}}'
        result = self.run_script("islamictime2.sh", {"curl": response})
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("Fajr 05:12", result.stdout)
        self.assertIn("Tuesday", result.stdout)

    def test_sunrise_utc_to_local(self):
        response = '{"status":"OK","results":{"sunrise":"6:00:00 AM","sunset":"4:00:00 PM"}}'
        result = self.run_script("sunsetsunrise2.sh", {"curl": response})
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("07:00:00", result.stdout)
        self.assertIn("17:00:00", result.stdout)

    def test_invalid_coordinates_do_not_fetch(self):
        result = self.run_script("sunsetsunrise2.sh", {"curl": "should not run"},
                                 {"SUN_LAT": "1;touch /tmp/unsafe"})
        self.assertEqual(result.returncode, 2)
        self.assertIn("invalid coordinates", result.stdout)


if __name__ == "__main__":
    unittest.main()
