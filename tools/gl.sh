#!/bin/bash

# Overview:
#
#   A script to upload binaries to GitLab and update package files.
#
# Usage:
#
#   bash ./gl.sh [package1 package2 ...]
#
#   If no packages are provided, all packages with binaries in release/* will be processed.
#
#   A token is needed to upload.  Set as follows:
#   export GITLAB_TOKEN=<your token here>
#
# Directory structure:
#
#   release/armv7l/*.(tar.xz|tpxz|tar.zst)(.sha256)  binary tarball and sha256 files for armv7l
#   release/i686/*.(tar.xz|tpxz|tar.zst)(.sha256)    binary tarball and sha256 files for i686
#   release/x86_64/*.(tar.xz|tpxz|tar.zst)(.sha256)  binary tarball and sha256 files for x86_64
#
# Author: Ed Reel (uberhacker) edreel at gmail dot com
#         Contact me if you would like access to the repository.
#
# Updated: 2021-05-02
#
# License: GPL-3+

shopt -s extglob

packages=
if test $1; then
  for package in $@; do
    pkgfile="../packages/${package}.rb"
    if [ -f ${pkgfile} ]; then
      packages+=" ${package}"
    else
      echo "Package ${pkgfile} not found."
    fi
  done
else
  packages=$(find ../release/*/*.xz -exec basename -s .tar.xz {} + | cut -d'-' -f1 | sort | uniq | xargs)" "
  packages+=$(find ../release/*/*.tpxz -exec basename -s .tpxz {} + | cut -d'-' -f1 | sort | uniq | xargs)" "
  packages+=$(find ../release/*/*.tar.zst -exec basename -s .tar.zst {} + | cut -d'-' -f1 | sort | uniq | xargs)
fi
[ -z "${packages}" ] && echo "No packages found." && exit 1

PROJECT=26210301
REGISTRY=generic
BASE_URL="https://gitlab.com/api/v4/projects/${PROJECT}/packages/${REGISTRY}"

function update_url () {
  if sed -e '/binary_url.*({/,/})/p; d' ../packages/$1.rb | grep -q $2:; then
    sed -e "/$2:.*\(http\|https\|ftp\):/c\ \ \ \ $(printf %7s $2): '$3'," -i ../packages/$1.rb
  else
    sed -e "/binary_url.*({/a\ \ \ \ $(printf %7s $2): '$3'," -i ../packages/$1.rb
  fi
}

function update_sha256 () {
  if sed -e '/binary_sha256.*({/,/})/p; d' ../packages/$1.rb | grep -q $2:; then
    sed -e "/$2:.*['\"][0-9a-f]*['\"]/c\ \ \ \ $(printf %7s $2): '$3'," -i ../packages/$1.rb
  else
    sed -e "/binary_sha256.*({/a\ \ \ \ $(printf %7s $2): '$3'," -i ../packages/$1.rb
  fi
}

for package in ${packages}; do
  for arch in x86_64 i686 armv7l; do
    echo "Package: ${package}, Arch: ${arch}"
    pkgfile=../packages/${package}.rb
    old_url="$(grep -m 3 ${arch}: ${pkgfile} 2> /dev/null | head -n 1 | cut -d\' -f2 | tr -d \' | tr -d \" | sed 's/,//g')"
    if [ -n "${old_url}" ]; then
      old_sha256="$(grep -m 3 ${arch}: ${pkgfile} 2> /dev/null | tail -n 1 | cut -d\' -f2 | tr -d \' | tr -d \" | sed 's/,//g')"
      tarfile="$(basename ${old_url})"
      noname="${tarfile#*-}"
      old_version="${noname%-chromeos*}"
    fi
    new_tarfile="$(ls -t ../release/${arch}/${package}-*-chromeos-${arch}.@(tar.xz|tpxz|tar.zst) 2> /dev/null | head -1)"
    if [ -z "${new_tarfile}" ]; then
      echo "../release/${arch}/${package}-#-chromeos-${arch}.(tar.xz|tpxz|tar.zst) not found."
      echo
      continue
    fi
    echo "Generating sha256sum ..."
    new_sha256=$(sha256sum ${new_tarfile} | cut -d' ' -f1)
    echo
    noname="${new_tarfile#*-}"
    new_version="${noname%-chromeos*}"
    new_url=$(echo "${BASE_URL}/${package}/${new_version}_${arch}/${new_tarfile}" | sed "s,../release/${arch}/,,")
    curl --header "DEPLOY-TOKEN: ${GITLAB_TOKEN}" --upload-file "${new_tarfile}" "${new_url}"
    if [ -n "${old_url}" ]; then
      if [[ ${old_url} != ${new_url} ]]; then
        echo "Updating binary_url in ${pkgfile}..."
        echo "from: ${arch}: '${old_url}'"
        echo "  to: ${arch}: '${new_url}'"
        sed -i "s,${old_url},${new_url},g" ${pkgfile}
      else
        echo "Skipping binary_url update in ${pkgfile}..."
      fi
      if [[ ${old_sha256} != ${new_sha256} ]]; then
        echo "Updating binary_sha256 in ${pkgfile}.."
        echo "from: ${arch}: '${old_sha256}'"
        echo "  to: ${arch}: '${new_sha256}'"
        sed -i "s,${old_sha256},${new_sha256},g" ${pkgfile}
      else
        echo "Skipping binary_sha256 update in ${pkgfile}..."
      fi
    else
      if ! grep -q binary_url ../packages/${package}.rb; then
        sed -e '/source_sha256/ a\
\
\ \ binary_url ({\
\ \ })\
\ \ binary_sha256 ({\
\ \ })' -i ../packages/${package}.rb
      fi
      echo "Adding binary_url to ${pkgfile}..."
      echo "${arch}: '${new_url}'"
      echo "Adding binary_sha256 to ${pkgfile}..."
      echo "${arch}: '${new_sha256}'"
      case x${new_url} in
      x)  ;;
      *)
        update_url ${package} ${arch} ${new_url}
        update_sha256 ${package} ${arch} ${new_sha256}
        case ${arch} in
        armv7l)
          update_url ${package} aarch64 ${new_url}
          update_sha256 ${package} aarch64 ${new_sha256}
          ;;
        esac
        ;;
      esac
    fi
    echo
  done
done
