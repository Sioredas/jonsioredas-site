#!/bin/bash
# build-thumbs.sh [tops.tsv ...]   rebuilds out/thumbnails/ from the tops TSVs
# Columns: videoId <tab> slug <tab> tag <tab> line1 <tab> line2
# The still for a row is stills/<slug>.jpg. Defaults to every tops*.tsv.
set -euo pipefail
cd "$(dirname "$0")"

if [ "$#" -gt 0 ]; then
  files=("$@")
else
  files=(tops*.tsv)
fi

for f in "${files[@]}"; do
  while IFS=$'\t' read -r id slug tag l1 l2 || [ -n "${slug:-}" ]; do
    [ -n "${slug:-}" ] || continue
    ./make-thumb.sh "$slug" "$tag" "$l1" "$l2" "stills/$slug.jpg"
  done < "$f"
done
