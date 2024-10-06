#!/bin/sh

total=0
dest="$(mktemp -d)"

for dir in releases community main; do
    old_total="$total"
    src="rsync://rsync.alpinelinux.org/alpine/v3.20/$dir/x86"
    size=$(rsync -a -n --stats "$src" "$dest" | grep '^Total file size' | tr -d ',' | awk '{ print $4 }')
    total=$(( old_total + size ))
    echo "$dir: $size" | awk '{ print $1 sprintf("%.1f", $2/1073741824) }'
done

echo "total: $total" | awk '{ print $1 sprintf("%.1f", $2/1073741824) }'
rm -r "$dest"
