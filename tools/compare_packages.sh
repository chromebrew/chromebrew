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
grep "^name:" packages.yaml | sort | cut -d' ' -f2 > /tmp/packages_to_check.txt
vimdiff /tmp/packages_all.txt /tmp/packages_to_check.txt
