#!/bin/sh

total=0
dest="$(mktemp -d)"

for dir in edge v3.0 v3.1 v3.2 v3.3 v3.4 v3.5 v3.6 v3.7 v3.8 v3.9 v3.10 v3.11 v3.12 v3.13 v3.14 v3.15 v3.16 v3.17 v3.18 v3.19 v3.20; do
    old_total="$total"
    src="rsync://rsync.alpinelinux.org/alpine/$dir/"
    size=$(rsync -a -n --stats "$src" "$dest" | grep '^Total file size' | tr -d ',' | awk '{ print $4 }')
    total=$(( old_total + size ))
    echo "$dir: $size" | awk '{ print $1 sprintf("%.1f", $2/1073741824) }'
done

echo "total: $total" | awk '{ print $1 sprintf("%.1f", $2/1073741824) }'
rm -r "$dest"
