#!/usr/bin/env bash
# getrealdeps for Chromebrew
# Author: Satadru Pramanik (satmandu) satadru at gmail dot com
# set -x
pkg="${1}"
[[ ! -e '/usr/local/bin/grep' ]] && crew install grep
GREP=/usr/local/bin/grep
CREW_LIB_PREFIX=$(crew const | $GREP CREW_LIB_PREFIX | awk -F = '{print $2}')

# Which packages have a needed library in CREW_LIB_PREFIX
# This is a subset of what crew whatprovides gives
whatprovidesfxn() {
  pkgdepslcl="${1}"
  filelcl=$(cd /usr/local/etc/crew/meta/ ; $GREP --exclude "${pkg}.filelist" "$pkgdepslcl" *.filelist | $GREP "$CREW_LIB_PREFIX")
  packagelcl=$(echo "$filelcl" | \
  sed 's/.filelist.*//g' | sed 's:.*/::' | awk '!x[$0]++' | sed s/://g)
  echo "$packagelcl"
}

# What files does a package provide
crewfilesfxn() {
 pkgname="${1}"
 files=$(cat /usr/local/etc/crew/meta/"${pkgname}".filelist)
 echo "$files"
}

pkgfiles=$(crewfilesfxn "${pkg}")
# Use readelf to determine library dependencie, as
# this doesn't almost run a program like using ldd would.
rm -rf /tmp/deps/"${pkg}"
pkgdeps=$(unset lines ; for i in $pkgfiles ; \
do \
[[ $i = *.c ]] && continue
[[ $i = *.gz ]] && continue
[[ $i = *.h ]] && continue
[[ $i = *.json ]] && continue
[[ $i = *.py* ]] && continue
[[ $i = *_tkinter* ]] && continue # Carveout for Python3
[[ $i = *.txt ]] && continue
[[ $i = *.xml ]] && continue
[[ $i = *.zip ]] && continue
mkdir -p /tmp/deps/"${pkg}"/
lines+=$(echo ; readelf -d "$i" 2>/dev/null | $GREP NEEDED | awk '{print $5}' \
| sed 's/\[//g' | sed 's/\]//g' | awk '!x[$0]++' | tee /tmp/deps/"${pkg}"/$(basename "$i") ; echo ) ; \
done ; \
echo "$lines" | tr " " "\n" \
| awk 'NF' | awk '!x[$0]++')

# Remove duplicates.
pkgdeps=$(echo "$pkgdeps" | tr " " "\n" |  awk '!x[$0]++')

# Figure out which Chromebrew packages provide the relevant deps.
pkgdeps=$(unset lines; for j in $pkgdeps ; \
do lines+=$(echo ; whatprovidesfxn "$j"); done ; \
echo "$lines" | tr " " "\n" | awk '!x[$0]++')

# Remove original package from list.
pkgdeps=$(echo "$pkgdeps" | tr " " "\n" | sed "/${1}/d" | sort -u )

# Note which dependencies are missing.
missingpkgdeps=$(
for i in $pkgdeps
do
  $GREP -q "depends_on '$i'" /usr/local/lib/crew/packages/"${1}".rb || echo "$i"
done
)

for i in $pkgdeps
do
echo "  depends_on '$i' # R"
done

# If there are no missing deps, no warning is needed.
if [ -n "${missingpkgdeps}" ]; then
  echo "There are missing dependencies in the package:"
  for i in $missingpkgdeps
  do
    echo "  depends_on '$i' # R"
  done
fi
