#!/bin/bash

# Upload script to jfrog (bintray)
#
# Usage
#
#   upfrog package...              Upload all version of packages
#   upfrog package-version...      Upload only a given version of packages
#   upfrog -t package...           Performs only dry-run (not upload)
#   upfrog -d package...           Performs only debug-run (not execute jfrog)
#
# Configuration
#
#   1. Login to https://bintray.com/login?targetUri=/profile/edit
#   2. Select API Key
#   3. Generate a new API Key
#   4. Install jfrog:
#      $ crew install jfrog
#   5. Configure jfrog:
#      $ jfrog bt c --user <bintray_username> --key <api_key> --licenses GPL-3.0
#      See https://www.jfrog.com/confluence/display/CLI/CLI+for+JFrog+Bintray#CLIforJFrogBintray-Configuration
#
# Note: OSS free account has limitation of the number of REST API uses by a day.
#       If you see 'Forbidden' errors, please try it again in a next day.
#

ORG=chromebrew
REPO=chromebrew
DRYRUN=
DEBUG=

# Define your environment
#
#   LOCALPATHS:      Multiple paths for your pre-compiled binaries
#   REGEXPLOCALPATH: Single path using regexp to points all of your LOCALPATHS.
#                    If your LOCALPATHS contains single directory, still "(|)"
#                    is required by jfrog, so write something like
#                    "(real-path|dummy-path)".

# For the case of multiple paths
LOCALPATHS="release/armv7l release/i686 release/x86_64"
REGEXPLOCALPATH="release/(armv7l|i686|x86_64)"

# For the case of single paths
#LOCALPATHS="release/bin"
#REGEXPLOCALPATH="release/(bin|dummy_zzzzz)"

case $1 in
-d) # debug
  DEBUG=1
  DRYRUN=--dry-run
  shift;;
-t) # test
  DRYRUN=--dry-run
  shift;;
esac

function check_pkg () {
  jfrog bt ps $ORG/$REPO/$1 > /dev/null 2> /dev/null
}

function create_pkg () {
  jfrog bt pc $ORG/$REPO/$1 --pub-dn=true --vcs-url=https://github.com/ > /dev/null 2> /dev/null
}

function check_pkg_ver () {
  jfrog bt vs $ORG/$REPO/$1/$2 > /dev/null 2> /dev/null
}

function upload_pkg_ver () {
  jfrog bt u $DRYRUN --override=true --regexp "$REGEXPLOCALPATH/$1-$2-chrome.*\.tar\..z$" "$ORG/$REPO/$1/$2" # > /dev/null 2> /dev/null
}

function publish_pkg_ver () {
  jfrog bt vp "$ORG/$REPO/$1/$2" # > /dev/null 2> /dev/null
}

function error () {
  >&2 echo $1
  exit 1
}

for name in "$@"; do
  name=`basename -s .rb $name`
  pkg=`echo $name | sed -e 's/-.*//'`

  # check file existence
  files=
  for path in $LOCALPATHS; do
    for file in $path/$name-*.tar.?z; do
      [ -f $file ] && files="$file $files"
    done
  done
  [ -s "$files" ] && continue

  # check version numbers
  versions=
  while read version; do
    versions="$versions $version"
  done < <(for file in $files; do
    echo $file | sed -e "s:^.*/$pkg-::" -e 's:-chrome.*$::'
  done | sort -n | uniq)

  if [ ! -s $DEBUG ]; then
    echo "$name -> $pkg, $versions: $files"
    continue
  fi

  # create package first
  check_pkg $pkg || create_pkg $pkg || error "failed to create $pkg package"

  # upload and publish
  for v in $versions; do
    v=`echo $v | sed -e s/,/./g`
    # check_pkg_ver $pkg $v || error "failed to check version $pkg-$v"
    upload_pkg_ver $pkg $v || error "failed to upload $pkg-$v"
    publish_pkg_ver $pkg $v || error "failed to publish $pkg-$v"
  done
done

