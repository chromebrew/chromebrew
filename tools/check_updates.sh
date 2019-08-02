#!/bin/bash
if ! test $(command -v elinks 2> /dev/null); then
  crew install elinks
fi
if [ ! -f packages.yaml ]; then
  echo "packages.yaml not found."
  exit 1
fi
if test $1; then
  grep -1 "^activity: $1" packages.yaml > /tmp/activity.txt
  grep ^url: /tmp/activity.txt | cut -d' ' -f2 | sort | uniq > /tmp/urls.txt
  rm -f /tmp/activity.txt
else
  grep ^url: packages.yaml | cut -d' ' -f2 | sort | uniq > /tmp/urls.txt
fi
if test $2; then
  lines=$(wc -l /tmp/urls.txt | cut -d' ' -f1)
  offset=$2
  urls=$(($lines - $offset))
  if test $3; then
    count=$3
    tail -$urls /tmp/urls.txt | head -$count > /tmp/new_urls.txt
  else
    tail -$urls /tmp/urls.txt > /tmp/new_urls.txt
  fi
  mv /tmp/new_urls.txt /tmp/urls.txt
fi
#for u in $(cat /tmp/urls.txt); do elinks $u; done
#rm -f /tmp/urls.txt
most /tmp/urls.txt
