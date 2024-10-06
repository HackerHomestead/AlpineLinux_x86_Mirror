#!/bin/sh

# make sure we never run 2 rsync at the same time
lockfile="/home/handy/repo/alpine-mirror.lock"
if [ -z "$flock" ] ; then
  exec env flock=1 flock -n $lockfile "$0" "$@"
fi

for dir in releases community main; do
	src="rsync://rsync.alpinelinux.org/alpine/v3.20/$dir/x86"
	dest="/home/handy/repo/alpine/$dir/x86"

	mkdir -p "$dest"
	/usr/bin/rsync \
		--progress \
		--archive \
		--update \
		--hard-links \
		--delete \
		--delete-after \
		--delay-updates \
		--timeout=600 \
		"$src" "$dest"
done
