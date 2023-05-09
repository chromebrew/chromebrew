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
  echo
  echo "Warning: Do not run '$SCRIPT all' if the installed packages need to remain intact."
  echo
  exit 1
fi
META_DIR=../meta
INST_DIR=/usr/local/etc/crew/meta
if [[ "$1" == "all" ]]; then
  if test "$2"; then
    SEARCH_STR="^$2"
    EXIT_MSG="All package files starting with $2 added to filelist_all.gz."
  else
    SEARCH_STR=""
    EXIT_MSG="All package files added to filelist_all.gz."
  fi
  [ -f "$META_DIR/filelist_all.gz" ] && gunzip "$META_DIR/filelist_all.gz"
  ALL_PACKAGES=$(grep -v is_fake ../packages/*.rb | sed -e 's,../packages/,,' | cut -d. -f1 | sort | uniq | grep "$SEARCH_STR" | xargs)
  for p in $ALL_PACKAGES; do
    yes | crew install "$p"
    while IFS= read -r line; do
      echo "$p: $line" >> "$META_DIR/filelist_all"
    done < "$INST_DIR/$p.filelist"
    FIRST=$(printf %.1s "$p")
    cp "$INST_DIR/$p.filelist" "$META_DIR/$FIRST"
    if ! test "$(grep "^$p$" core_packages.txt 2> /dev/null)"; then
      crew remove "$p"
    fi
  done
else
  if [ ! -f "../packages/$1.rb" ]; then
    echo "Package $1 does not exist."
    exit 1
  fi
  if [ -n "$(grep is_fake ../packages/$1.rb 2> /dev/null)" ]; then
    echo "Package $1 is fake."
    exit 1
  fi
  EXIT_MSG="Package $1 files added to filelist_all.gz."
  [ ! -f "$INST_DIR/$1.filelist" ] && yes | crew install "$1"
  [ -f "$META_DIR/filelist_all.gz" ] && gunzip "$META_DIR/filelist_all.gz"
  while IFS= read -r line; do
    echo "$1: $line" >> "$META_DIR/filelist_all"
  done < "$INST_DIR/$1.filelist"
  FIRST=$(printf %.1s "$1")
  cp "$INST_DIR/$1.filelist" "$META_DIR/$FIRST"
  if [ -z "$(grep "^$1$" core_packages.txt 2> /dev/null)" ]; then
    crew remove "$1"
  fi
fi
yes | sort "$META_DIR/filelist_all" | uniq | gzip -9 > "$META_DIR/filelist_all.gz"
rm -f "$META_DIR/filelist_all"
echo "$EXIT_MSG"
