#!/bin/bash
# Renders the YouTube source HTML to exact-pixel PNGs with headless Chrome.
#   ./render.sh          everything
#   ./render.sh banner   one target (banner | avatar | monogram | watermark)
# Thumbnails have their own script: ./make-thumb.sh
set -uo pipefail
cd "$(dirname "$0")"
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
mkdir -p out
only="${1:-all}"

shot () { # shot <target> <html> <w> <h> <outfile>
  [ "$only" = all ] || [ "$only" = "$1" ] || return 0
  "$CHROME" --headless --disable-gpu --hide-scrollbars --force-device-scale-factor=1 \
    --default-background-color=00000000 --virtual-time-budget=9000 \
    --window-size="$3,$4" --screenshot="out/$5" "file://$PWD/$2" 2>/dev/null
  printf '  %-26s %s %s\n' "out/$5" \
    "$(sips -g pixelWidth -g pixelHeight "out/$5" | awk '/pixel/{printf "%sx",$2}' | sed 's/x$//')" \
    "$(du -h "out/$5" | cut -f1 | tr -d ' ')"
}

shot banner    banner.html    2560 1440 youtube-banner.png
shot avatar    avatar.html     800  800 youtube-avatar.png
shot monogram  monogram.html   800  800 logo-monogram.png
shot watermark watermark.html  150  150 youtube-watermark.png
