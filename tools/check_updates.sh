#!/bin/bash
if ! test $(command -v elinks 2> /dev/null); then
  crew install elinks
fi
if [ ! -f packages.yaml ]; then
  echo "packages.yaml not found."
  exit 1
fi
if test $1; then
  grep -2 "^activity: $1" packages.yaml > /tmp/activity.txt
  grep ^name: /tmp/activity.txt | cut -d' ' -f2  > /tmp/names.txt
  grep ^url: /tmp/activity.txt | cut -d' ' -f2 > /tmp/urls.txt
  rm -f /tmp/activity.txt
else
  grep ^name: packages.yaml | cut -d' ' -f2 > /tmp/names.txt
  grep ^url: packages.yaml | cut -d' ' -f2 > /tmp/urls.txt
fi
if test $2; then
  lines=$(wc -l /tmp/urls.txt | cut -d' ' -f1)
  offset=$2
  urls=$(($lines - $offset))
  if test $3; then
    count=$3
    tail -$urls /tmp/names.txt | head -$count > /tmp/new_names.txt
    tail -$urls /tmp/urls.txt | head -$count > /tmp/new_urls.txt
  else
    tail -$urls /tmp/names.txt > /tmp/new_names.txt
    tail -$urls /tmp/urls.txt > /tmp/new_urls.txt
  fi
  mv /tmp/new_names.txt /tmp/names.txt
  mv /tmp/new_urls.txt /tmp/urls.txt
fi
#for u in $(cat /tmp/urls.txt); do elinks $u; done
#rm -f /tmp/urls.txt
c=1
for u in $(cat /tmp/urls.txt); do
  if [[ $u == *"github.com"* && $u == *"/releases"* ]]; then
    name=$(head -$c /tmp/names.txt | tail -1)
    version=$(grep "^  version" ../packages/$name.rb | cut -d"'" -f2)
    content=$(curl -Ls $u)
    d=${content#*/archive/}
    rel=$(echo $d | cut -d '"' -f1)
    ver=${rel%.zip*}
    nu=$(echo "${u/releases/archive}")
    echo "$name | $nu/$ver.tar.gz | $version | $ver"
  fi
  c=$((c+1))
done
#most /tmp/urls.txt
