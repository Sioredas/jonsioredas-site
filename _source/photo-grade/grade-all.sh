#!/bin/bash
# Re-creates every site photo in images/web/ from the originals in images/, with one shared grade
# (warm gold highlights, Poly Green shadows, soft blacks, calm color, light vignette and grain).
# Per-photo numbers first even out exposure, white balance, contrast and saturation so they match.
# To add a new photo: run it once with neutral values (0 1 1 1 1 1), compare, then nudge.
set -e
cd "$(dirname "$0")"
swiftc -O grade.swift -o /tmp/jonsioredas-grade
G=/tmp/jonsioredas-grade; I=../../images; W=../../images/web
#   original                         output                    width   EV   gainR gainG gainB contrast saturation
$G $I/hero-coaching.jpg          $W/hero-1680.jpg          1680  0.00  1.00  1.00  1.03  1.00  0.95
$G $I/hero-coaching.jpg          $W/hero-1100.jpg          1100  0.00  1.00  1.00  1.03  1.00  0.95
$G $I/gopoly/jon-2024.jpg        $W/camps-clinics.jpg      1200  0.62  1.12  0.97  0.94  1.00  0.85
$G $I/camp-huddle.jpg            $W/camp-huddle.jpg        1200  0.05  0.97  1.00  1.05  1.20  1.10
$G $I/gopoly/jon-podium-75th.jpg $W/speaking-podium.jpg    1000 -0.45  0.97  1.02  1.02  1.10  1.28
$G $I/jon-ncaa.jpg               $W/ncaa-embrace.jpg       1100 -0.15  1.08  1.00  0.90  1.02  0.86
$G $I/jon-headshot.jpg           $W/headshot.jpg            760 -0.02  0.98  1.00  1.05  1.06  0.90
