#!/bin/sh

# make sure we never run 2 rsync at the same time
lockfile="/home/handy/repo/alpine-mirror.lock"
if [ -z "$flock" ] ; then
  exec env flock=1 flock -n $lockfile "$0" "$@"
fi

#src=rsync://rsync.alpinelinux.org/alpine/ 

src=rsync://rsync.alpinelinux.org/alpine/v3.20/releases/x86
#src=rsync://rsync.alpinelinux.org/alpine/v3.20/community/x86
#src=rsync://rsync.alpinelinux.org/alpine/v3.20/main/x86

#dest=/var/www/localhost/htdocs/alpine/
dest=/home/handy/repo/alpine/v3.20/releases/x86/

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
        $exclude \
        "$src" "$dest"
