#!/usr/bin/env bash
# getrealdeps for Chromebrew
# Author: Satadru Pramanik (satmandu) satadru at gmail dot com
# set -x
pkg="${1%.rb}"

# Exit quickly if an invalid package name is given.
[[ ( -z "$pkg" ) || ( "$pkg" == *"#"* ) ]] && exit 1

if [ -z "${NOCOLORS}" ]; then
  RED='\e[1;91m';    # Use Light Red for errors.
  YELLOW='\e[1;33m'; # Use Yellow for informational messages.
  GREEN='\e[1;32m';  # Use Green for success messages.
  BLUE='\e[1;34m';   # Use Blue for intrafunction messages.
  GRAY='\e[0;37m';   # Use Gray for program output.
  MAGENTA='\e[1;35m';
  RESET='\e[0m'
else
  RED='';
  YELLOW='';
  GREEN='';
  BLUE='';
  GRAY='';
  MAGENTA='';
  RESET=''
fi

# Simplify colors and print errors to stderr (2).
echo_error() { echo -e "${RED}${*}${RESET}" >&2; }
echo_info() { echo -e "${YELLOW}${*}${RESET}" >&1; }
echo_success() { echo -e "${GREEN}${*}${RESET}" >&1; }
echo_intra() { echo -e "${BLUE}${*}${RESET}" >&1; }
echo_out() { echo -e "${GRAY}${*}${RESET}" >&1; }
echo_other() { echo -e "${MAGENTA}${*}${RESET}" >&2; }

# Install jq if a functional local copy does not exist.
if ! jq --version &> /dev/null; then
  crew install jq
fi

# Package needs to be installed for package filelist to be populated.
if ! [[ $(jq --arg key "${pkg}" -e '.installed_packages[] | select(.name == $key )' /usr/local/etc/crew/device.json) ]]; then
  crew install "${pkg}"
fi

if ! [[ -f "/usr/local/etc/crew/meta/${pkg}.filelist" ]]; then
  echo_error "Package $pkg either does not exist or does not contain any libraries."
  exit 1
fi

# Install grep if a functional local copy does not exist.
if grep --version &> /dev/null; then
  GREP=grep
else
  crew install grep
  GREP=/usr/local/bin/grep
fi

# Install mawk if a functional local copy of awk does not exist.
if ! awk -W version &> /dev/null; then
  crew install mawk
fi

: "${CREW_LIB_PREFIX:=$(crew const | $GREP CREW_LIB_PREFIX | awk -F = '{print $2}')}"

# Which packages have a needed library in CREW_LIB_PREFIX
# This is a subset of what crew whatprovides gives
whatprovidesfxn() {
  pkgdepslcl="${1}"
  # Handle patchelf inserted full library paths.
  if [[ "${pkgdepslcl}" == *"${CREW_LIB_PREFIX}"* ]]; then
    filelcl=$($GREP --exclude "${pkg}.filelist" "${pkgdepslcl}$" /usr/local/etc/crew/meta/*.filelist)
  else
    filelcl=$($GREP --exclude "${pkg}.filelist" "^${CREW_LIB_PREFIX}.*${pkgdepslcl}$" /usr/local/etc/crew/meta/*.filelist)
  fi
  packagelcl=$(echo "$filelcl" | \
  sed 's/.filelist.*//g' | sed 's:.*/::' | awk '!x[$0]++' | sed s/://g)
  echo "$packagelcl"
}

# What files does a package provide
crewfilesfxn() {
 pkgname="${1}"
 files=$(< /usr/local/etc/crew/meta/"${pkgname}".filelist)
 echo "$files"
}

pkgfiles=$(crewfilesfxn "${pkg}")
# Use readelf to determine library dependencies, as
# this doesn't almost run a program like using ldd would.
rm -rf /tmp/deps/"${pkg}"
pkgdeps=$(unset lines ; for i in $pkgfiles ; \
do \
[[ -f "${i}" ]] || continue
read -r -n 4 exec_header_bytes < "${i}"
[[ "$exec_header_bytes" == $'\x7FELF' ]] || continue
[[ $i = *_tkinter* ]] && continue # Carveout for Python3
mkdir -p /tmp/deps/"${pkg}"/
lines+=$(echo ; readelf -d "$i" 2>/dev/null | $GREP NEEDED | awk '{print $5}' \
| sed 's/\[//g' | sed 's/\]//g' | awk '!x[$0]++' | tee /tmp/deps/"${pkg}"/$(basename "$i") ; echo ) ; \
done ; \
echo "$lines" | tr " " "\n" \
| awk 'NF' | awk '!x[$0]++')

# Remove duplicates.
pkgdeps="$(awk 'NF' <<< "${pkgdeps}" | awk '!x[$0]++')"

# Figure out which Chromebrew packages provide the relevant deps.
pkgdeps=$(unset lines; for j in $pkgdeps ; \
do lines+=$(echo ; whatprovidesfxn "$j"); done ; \
echo "$lines" | tr " " "\n" | awk '!x[$0]++')

# Remove original package from list.
pkgdeps=$(tr " " "\n" <<< "$pkgdeps" | sed "/${pkg}/d" | sort -u )

# Note which dependencies are missing.
missingpkgdeps=$(
for i in $pkgdeps
do
  $GREP -q "depends_on '$i'" /usr/local/lib/crew/packages/"${pkg}".rb || echo "$i"
done
)
echo_info "\nPackage ${pkg} has runtime library dependencies on these packages:"
echo -e "${RESET}"
for i in $pkgdeps
do
echo_intra "  depends_on '$i' # R"
done
echo -e "${RESET}"

# If there are no missing deps, no warning is needed.
if [ -n "${missingpkgdeps}" ]; then
  echo_error "\nPackage file ${pkg}.rb is missing these runtime library dependencies:"
  echo -e "${RESET}"
  for i in $missingpkgdeps
  do
    echo_other "  depends_on '$i' # R"
  done
fi
echo -e "${RESET}"
