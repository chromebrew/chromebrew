#!/usr/bin/env bash
# getrealdeps for Chromebrew version 1.1
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

: "${CREW_PREFIX:=$(crew const CREW_PREFIX | cut -d= -f2)}"
: "${CREW_LIB_PREFIX:=$(crew const CREW_LIB_PREFIX | cut -d= -f2)}"

# Package needs to be installed for package filelist to be populated.
if ! [[ $(jq --arg key "${pkg}" -e '.installed_packages[] | select(.name == $key )' "${CREW_PREFIX}"/etc/crew/device.json) ]]; then
  crew install "${pkg}"
fi

if ! [[ -f "${CREW_PREFIX}/etc/crew/meta/${pkg}.filelist" ]]; then
  echo_error "Package $pkg either does not exist or does not contain any libraries."
  exit 1
fi

# Speed up grep
export LC_ALL=C

# Install grep if a functional local copy does not exist.
if grep --version &> /dev/null; then
  GREP="grep"
else
  crew install grep
  GREP="${CREW_PREFIX}/bin/grep"
fi

# Install mawk if a functional local copy of awk does not exist.
if ! awk -W version &> /dev/null; then
  crew install mawk
fi

# Which packages have a needed library in CREW_LIB_PREFIX
# This is a subset of what crew whatprovides gives
whatprovidesfxn() {
  pkgdepslcl="${1}"
  # Handle patchelf inserted full library paths.
  if [[ "${pkgdepslcl}" == *"${CREW_LIB_PREFIX}"* ]]; then
    filelcl=$($GREP --exclude "${pkg}.filelist" --exclude "${CREW_PREFIX}"/etc/crew/meta/*_build.filelist "${pkgdepslcl}$" "${CREW_PREFIX}"/etc/crew/meta/*.filelist)
  else
    filelcl=$($GREP --exclude "${pkg}.filelist" --exclude "${CREW_PREFIX}"/etc/crew/meta/*_build.filelist "^${CREW_LIB_PREFIX}.*${pkgdepslcl}$" "${CREW_PREFIX}"/etc/crew/meta/*.filelist)
  fi
  packagelcl=$(echo "$filelcl" | \
  sed 's/.filelist.*//g' | sed 's:.*/::' | awk '!x[$0]++' | sed s/://g)
  echo "$packagelcl"
}

# What files does a package provide
crewfilesfxn() {
 pkgname="${1}"
 files=$(< "${CREW_PREFIX}"/etc/crew/meta/"${pkgname}".filelist)
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
# Expand upx compressed binaries if in a container environment
# since otherwise we cannot figure out their dependencies.
[[ -f "/.dockerenv" ]] &&  upx -d "${i}" &> /dev/null
mkdir -p /tmp/deps/"${pkg}"/
# shellcheck disable=SC2030,SC2046
lines+=$(echo ; readelf -d "$i" 2>/dev/null | $GREP NEEDED | awk '{print $5}' \
| sed 's/\[//g' | sed 's/\]//g' | awk '!x[$0]++' | tee /tmp/deps/"${pkg}"/$(basename "$i") ; echo ) ; \
done ; \
echo "$lines" | tr " " "\n" \
| awk 'NF' | awk '!x[$0]++')

# Remove duplicates.
pkgdeps="$(awk 'NF' <<< "${pkgdeps}" | awk '!x[$0]++')"

# Figure out which Chromebrew packages provide the relevant deps.
# shellcheck disable=SC2031
pkgdeps=$(unset lines; for j in $pkgdeps ; \
do lines+=$(echo ; whatprovidesfxn "$j"); done ; \
echo "$lines" | tr " " "\n" | awk '!x[$0]++')

# Remove original package from list.
pkgdeps=$(tr " " "\n" <<< "$pkgdeps" | sed "/${pkg}/d" | sort -u )

# Note which dependencies are missing, but ignore :build lines, since
# build depenencies may still be runtime dependencies.
missingpkgdeps=$(
for i in $pkgdeps
do
  $GREP -v ":build" "${CREW_PREFIX}"/lib/crew/packages/"${pkg}".rb | $GREP -q "depends_on '$i'" || echo "$i"
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
