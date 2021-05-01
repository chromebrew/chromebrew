#!/bin/bash

# Overview:
#
#   A script to upload binaries to baltorepo.com.
#
# Usage:
#
#   bash ./balto_upload.sh <package>
#
#   A token is needed to upload.  Set as follows:
#   export BALTO_TOKEN=<your token here>
#
# Directory structure:
#
#   release/armv7l/*.tar.xz  binary tarball for armv7l
#   release/i686/*.tar.xz    binary tarball for i686
#   release/x86_64/*.tar.xz  binary tarball for x86_64
#
# Author: Ed Reel (uberhacker) edreel at gmail dot com
#         Contact me if you would like access to the repository.
#
# Updated: 2021-04-14
#
# License: GPL-3+

[ -z "$1" ] && echo "Usage: $(basename $0) <package>" && exit 1
[ ! -f ../packages/$1.rb ] && echo "Package $1.rb not found." && exit 1
for ARCH in armv7l i686 x86_64; do
  NAME=$1
  [[ "${NAME}" =~ "_" ]] && NAME=$(echo ${NAME}|sed -e 's/_//g')
  PACKAGE=../packages/$1.rb
  FILE="../release/${ARCH}/${1}-*${ARCH}.tar.xz"
  DOWNLOAD=$(ls ${FILE} 2> /dev/null | sed 's,../release/${ARCH}/,,')
  if [ -n "${DOWNLOAD}" ]; then
    NONAME=${DOWNLOAD#*-}
    VERSION=${NONAME%-chromeos*}
    RAWDESC=$(grep "^  description" ${PACKAGE})
    DESCRIPTION=$(echo ${RAWDESC}|sed -e 's/^description //'|sed -e 's/"//g'|sed -e "s/'//g"|cut -c -200)
    #echo "NAME=$NAME"
    #echo "VARIANT=$ARCH"
    #echo "VERSION=$VERSION"
    #echo "DOWNLOAD=$DOWNLOAD"
    #echo "DESCRIPTION=$DESCRIPTION"
    #exit
    curl \
    --header "Authorization: Bearer ${BALTO_TOKEN}" \
    --form "download=@${DOWNLOAD}" \
    --form "name=${NAME}" \
    --form "variant=${ARCH}" \
    --form "version=${VERSION}" \
    --form "description=${DESCRIPTION}" \
    https://chromebrew.baltorepo.com/chromebrew/chromebrew/upload/
  fi
done
