#!/bin/bash
# build-thumbs.sh [tops.tsv ...]   rebuilds out/thumbnails/ from the tops TSVs
# Columns: videoId <tab> slug <tab> tag <tab> line1 <tab> line2
# The still for a row is stills/<slug>.jpg. Defaults to every tops*.tsv.
set -euo pipefail
cd "$(dirname "$0")"
for f in "${@:-}"; do :; done
files=("$@"); [ ${#files[@]} -eq 0 ] && files=(tops*.tsv)
for f in "${files[@]}"; do
  while IFS=$'\t' read -r id slug tag l1 l2; do
    [ -n "${slug:-}" ] || continue
    ./make-thumb.sh "$slug" "$tag" "$l1" "$l2" "stills/$slug.jpg"
  done < "$f"
done
