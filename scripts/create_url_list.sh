#!/bin/bash

# Create URL list of binary URLs from packages/* and install.sh
#
# You can download all of them by using 'wget -N -P output_dir -i output_file' command

case x$1 in
x|x-h)
  echo "Usage: $0 [options] > output_file
Options:
  -h: help
  -s: show URLs      (ignore github URL)
  -a: show all URLs  (include github URL)

Create URL list of binary URLs from packages/*.rb files and install.sh.
It is possible to download them all using 'wget -N -P output_dir -i output_file'"
  exit 0;;
x-s)
  EXCLUDE_GITHUB_URL="grep -v 'github\.com'";;
x-a)
  EXCLUDE_GITHUB_URL="cat";;
esac

grep -h 'link=.*\(http\|https\|ftp\):' install.sh | \
  eval $EXCLUDE_GITHUB_URL | \
  sed -e 's:/www\.dropbox\.com/:/dl.dropboxusercontent.com/:' \
      -e 's/link=//' \
      -e 's/^[ \t]*["'"'"']//' \
      -e 's/[\?&].*["'"'"'].*$//' \
      -e 's/["'"'"'].*$//'

grep -h '\(armv7l\|i686\|x86_64\):.*\(http\|https\|ftp\):' packages/*.rb | \
  eval $EXCLUDE_GITHUB_URL | \
  sed -e 's:/www\.dropbox\.com/:/dl.dropboxusercontent.com/:' \
      -e 's/\(armv7l\|i686\|x86_64\)://' \
      -e 's/^[ \t]*["'"'"']//' \
      -e 's/[\?&].*["'"'"'].*$//' \
      -e 's/["'"'"'].*$//'
