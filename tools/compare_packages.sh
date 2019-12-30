#!/bin/bash
if ! test $(command -v vimdiff 2> /dev/null); then
  echo "vimdiff not found."
  exit 1
fi
if [ ! -f packages.yaml ]; then
  echo "packages.yaml not found."
  exit 1
fi
ls ../packages/*.rb | sort | cut -d'/' -f3 | cut -d'.' -f1 > /tmp/packages_all.txt
rm -f /tmp/packages.txt
touch /tmp/packages.txt
for p in $(cat /tmp/packages_all.txt); do
  if [ ! $(grep 'is_fake' ../packages/${p}.rb 2> /dev/null) ]; then
    echo $p >> /tmp/packages.txt
  fi
done
grep "^name:" packages.yaml | sort | cut -d' ' -f2 > /tmp/packages_to_check.txt
sort < /tmp/packages.txt > /tmp/packages_available.txt
vimdiff /tmp/packages_available.txt /tmp/packages_to_check.txt
rm -f /tmp/packages.txt /tmp/packages_all.txt /tmp/packages_available.txt /tmp/packages_to_check.txt
