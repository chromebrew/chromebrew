#!/bin/bash
if ! test $(command -v elinks 2> /dev/null); then
  crew install elinks
fi
if [ ! -f packages.yaml ]; then
  echo "packages.yaml not found."
  exit 1
fi
grep ^url: packages.yaml | cut -d' ' -f2 > /tmp/urls.txt
if test $1; then
  lines=$(wc -l /tmp/urls.txt | cut -d' ' -f1)
  offset=$1
  urls=$(($lines - $offset))
  if test $2; then
    count=$2
    tail -$urls /tmp/urls.txt | head -$count > /tmp/new_urls.txt
  else
    tail -$urls /tmp/urls.txt > /tmp/new_urls.txt
  fi
  mv /tmp/new_urls.txt /tmp/urls.txt
fi
for u in $(cat /tmp/urls.txt); do elinks $u; done
rm -f /tmp/urls.txt
