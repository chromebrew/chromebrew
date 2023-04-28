#!/bin/bash
if ! test "$1"; then
  SCRIPT="$(basename "$0")"
  echo "Build the database of package files."
  echo
  echo "Usage: $SCRIPT <all>|<package> <starts with>"
  echo
  echo "Examples: $SCRIPT all"
  echo "          This will search for all package names."
  echo
  echo "          $SCRIPT all z"
  echo "          This will search for all package names that start with the letter z."
  echo
  echo "          $SCRIPT rust"
  echo "          This will search for the rust package."
  exit 1
fi
META_DIR=/usr/local/etc/crew/meta
if [[ "$1" == "all" ]]; then
  if test "$2"; then
    SEARCH_STR="^$2"
    EXIT_MSG="All package files starting with $2 added to filelist_all.gz."
  else
    EXIT_MSG="All package files added to filelist_all.gz."
    SEARCH_STR=""
  fi
  gunzip ../filelist_all.gz
  ALL_PACKAGES="$(crew search "$SEARCH_STR" -d | cut -d: -f1 | xargs)"
  for p in $ALL_PACKAGES; do
    yes | crew install "$p"
    while IFS= read -r line; do
      echo "$p: $line" >> ../filelist_all
    done < "$META_DIR/$p.filelist"
    if ! test "$(grep "^$p$" core_packages.txt 2> /dev/null)"; then
      crew remove "$p"
    fi
  done
else
  if [ -f "../packages/$1.rb" ]; then
    if [ -f "$META_DIR/$1.filelist" ]; then
      EXIT_MSG="Package $1 files added to filelist_all.gz."
      gunzip ../filelist_all.gz
      while IFS= read -r line; do
        echo "$1: $line" >> ../filelist_all
      done < "$META_DIR/$1.filelist"
    else
      echo "Package $1 is not installed."
      exit 1
    fi
  else
    echo "Package $1 does not exist."
    exit 1
  fi
fi
yes | sort ../filelist_all | uniq | gzip -9 > ../filelist_all.gz
rm -f ../filelist_all
echo "$EXIT_MSG"
