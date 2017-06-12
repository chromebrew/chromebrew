#!/bin/bash

# Create SHA1/SHA256 list of binary files from packages/* and install.sh
#
# You can test SHA1/SHA256 by using 'sha1sum -c sha-file' or 'sha256sum -c sha-file'

case x$1 in
x|x-h)
  echo "Usage: $0 [options] > output_file
Options:
  -h: help
  -a: show all SHA1/SHA256

Create SHA1/SHA256 list of binary files from packages/*.rb files and install.sh.
It is possible to check SHA1/SHA256 by using 'sha1sum -c file' or 'sha256sum -c file'"
  exit 0;;
x-a)
  ;;
esac

grep -h '\(link=\|sha256=\)' install.sh |
  sed -e 's/link=//' \
      -e 's/sha256=//'\
      -e 's/^[ \t]*["'"'"']//' \
      -e 's/[\?&].*["'"'"'].*$//' \
      -e 's/["'"'"'].*$//' \
      -e 's/\(http\|https\|ftp\):.*\///' | \
  sed -ne 'N;s/\(.*\)\n\(.*\)/\2 \1/;p'

for f in packages/*.rb; do
  grep -h '\(armv7l\|i686\|x86_64\):' $f | \
    sort | \
    sed -e 's:/www\.dropbox\.com/:/dl.dropboxusercontent.com/:' \
        -e 's/\(armv7l\|i686\|x86_64\)://' \
        -e 's/^[ \t]*["'"'"']//' \
        -e 's/[\?&].*["'"'"'].*$//' \
        -e 's/["'"'"'].*$//' \
        -e 's/\(http\|https\|ftp\):.*\///' | \
  sed -ne 'N;s/\n/ /;p'
done
