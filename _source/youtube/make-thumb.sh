#!/bin/bash
# make-thumb.sh <outname> <tag> <line1> <line2> [imagePath] [focus]
# e.g. ./make-thumb.sh hand-fighting-101 "HAND FIGHTING" "INSIDE TIE" "TO SNAP" ../../images/camp-huddle.jpg "50% 30%"
set -euo pipefail
cd "$(dirname "$0")"
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
mkdir -p out/thumbnails
enc () { python3 -c 'import sys,urllib.parse;print(urllib.parse.quote(sys.argv[1]))' "$1"; }
q="tag=$(enc "${2:-}")&l1=$(enc "${3:-}")&l2=$(enc "${4:-}")"
[ -n "${5:-}" ] && q="$q&img=$(enc "$5")"
[ -n "${6:-}" ] && q="$q&focus=$(enc "$6")"
"$CHROME" --headless --disable-gpu --hide-scrollbars --force-device-scale-factor=1 \
  --virtual-time-budget=9000 --window-size=1280,720 \
  --screenshot="out/thumbnails/$1.png" "file://$PWD/thumbnail.html?$q" 2>/dev/null
echo "out/thumbnails/$1.png"
