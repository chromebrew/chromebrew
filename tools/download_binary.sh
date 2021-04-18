#!/bin/bash

# Overview:
#
#   A generic script to download binaries from various repositories.
#
# Usage:
#
#   bash ./download_binary.sh [package|all] [repo]
#
#   If no options are provided, core package binaries will be downloaded.
#   If no repo is provided, the default is sourceforge.
#
# Author: Ed Reel (uberhacker) edreel at gmail dot com
#
# Updated: 2021-04-14
#
# License: GPL-3+

if test $1; then
  if [[ "$1" == "all" ]]; then
    echo "Downloading all packages..."
    PACKAGES="$(ls -1 ../packages/*.rb | xargs | sed 's,../packages/,,g' | sed 's,\.rb , ,g' | sed 's,\.rb$,,')"
  else
    [ ! -f ../packages/$1.rb ] && echo "Package $1.rb not found." && exit 1
    echo "Downloading $1 package binaries..."
    PACKAGES=$1
  fi
else
  echo "Downloading core package binaries..."
  PACKAGES=$(cat ../tools/core_packages.txt | xargs)
fi
BINTRAY_REPO="https://dl.bintray.com/chromebrew/chromebrew/"
SOURCEFORGE_REPO="https://downloads.sourceforge.net/project/chromebrew/"
BALTO_REPO="https://baltocdn.com/chromebrew/chromebrew/chromebrew/downloads/"
REPO="sourceforge"
if test $2; then
  valid=
  valid_repos="balto bintray sourceforge"
  for r in $valid_repos; do
    [[ "$2" == "$r" ]] && valid=1
  done
  if [ ! $valid ]; then
    echo "$2 is an invalid repo."
    exit 1
  else
    REPO=$2
  fi
fi

for package in ${PACKAGES}; do
  for arch in armv7l i686 x86_64; do
    pkgfile=../packages/${package}.rb
    url="$(grep -m 3 ${arch}: ${pkgfile} | head -n 1 | cut -d\' -f2 | tr -d \' | tr -d \" | sed 's/,//g')"
    sha256="$(grep -m 3 ${arch}: ${pkgfile} | tail -n 1 | cut -d\' -f2 | tr -d \' | tr -d \" | sed 's/,//g')"
    case ${REPO} in
      balto)
        new_package=$(echo ${package} | sed 's,\_,,')
        new_base="${BALTO_REPO}${package:0:1}/${new_package}/"
        ;;
      bintray)
        new_base="${BINTRAY_REPO}"
        ;;
      sourceforge)
        new_base="${SOURCEFORGE_REPO}${arch}/"
        ;;
    esac
    tarfile="$(basename ${url})"
    noname="${tarfile#*-}"
    version="${noname%-chromeos*}"
    new_url="${new_base}${tarfile}"
    #echo $url
    #echo $new_url
    #exit
    #sed -i "s,${url},${new_url},g" ${pkgfile}
    #if [ "${package}" == "glibc" ]; then
    #  case ${arch} in
    #  armv7l)
    #    url="${new_base}glibc-2.27-chromeos-armv7l.tar.xz"
    #    sha256="64b4b73e2096998fd1a0a0e7d18472ef977aebb2f1cad83d99c77e164cb6a1d6"
    #    ;;
    #  x86_64)
    #    url="${new_base}glibc-2.27-chromeos-x86_64.tar.xz"
    #    sha256="5fe94642dbbf900d22b715021c73ac1a601b81517f0da1e7413f0af8fbea7997"
    #    ;;
    #  esac
    #fi
    echo "Package: ${package}, Arch: ${arch}, Version: ${version}"
    echo "Downloading ${url}..."
    curl -#Lsf ${url} -o ${tarfile}
    echo -e "Verifying ${tarfile}..."
    echo -e "$(echo "${sha256}" "${tarfile}" | sha256sum -c -)"
    case "${?}" in
    0)
      echo -e "Verification passed."
      ;;
    *)
      echo -e "Verification failed."
      exit 1
      ;;
    esac
  done
done
