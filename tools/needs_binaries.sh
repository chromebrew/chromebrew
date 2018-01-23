#!/bin/bash
if [ ! -d ../packages ]; then
  echo "Unable to locate packages directory."
  exit 1
fi
cd ../packages
arch=$(uname -m)
exclusions=""
if [[ "$arch" == "aarch64" || "$arch" == "armv7l" ]]; then
  exclusions="cbase.rb dropbox.rb freebasic.rb google_cloud_sdk.rb lldb.rb mesa.rb misctools.rb"
fi
packages=$(grep -L "$arch:" *.rb)
for p in $packages; do
  include=1
  for e in $exclusions; do
    if [ "$e" == "$p" ]; then
      include=
      break
    fi
  done
  if test $include; then
    grep -L is_fake $p
  fi
done
