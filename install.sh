#!/bin/bash

# exit on fail
set -e

#chromebrew directories

: "${OWNER:=skycocker}"
: "${REPO:=chromebrew}"
: "${BRANCH:=master}"
: "${CURL:=curl}"
: "${CREW_PREFIX:=/usr/local}"
: "${CREW_CACHE_DIR:=$CREW_PREFIX/tmp/packages}"

URL="https://raw.githubusercontent.com/${OWNER}/${REPO}/${BRANCH}"
CREW_LIB_PATH="${CREW_PREFIX}/lib/crew"
CREW_CONFIG_PATH="${CREW_PREFIX}/etc/crew"
CREW_BREW_DIR="${CREW_PREFIX}/tmp/crew"
CREW_DEST_DIR="${CREW_BREW_DIR}/dest"
CREW_PACKAGES_PATH="${CREW_LIB_PATH}/packages"


# BOOTSTRAP_PACKAGES cannot depend on crew_profile_base for their core operations (completion scripts are fine)
BOOTSTRAP_PACKAGES="pixz jq ca_certificates git gmp ncurses libyaml ruby"

ARCH="$(uname -m)"
# For container usage, where we are emulating armv7l via linux32
ARCH="${ARCH/armv8l/armv7l}"

RED='\e[1;91m';    # Use Light Red for errors.
YELLOW='\e[1;33m'; # Use Yellow for informational messages.
GREEN='\e[1;32m';  # Use Green for success messages.
BLUE='\e[1;34m';   # Use Blue for intrafunction messages.
GRAY='\e[1;37m';   # Use Gray for program output.
MAGENTA='\e[1;35m';
RESET='\e[0m'

echo -e "${GREEN}Welcome to Chromebrew!${RESET}\n"
if [ "${EUID}" == "0" ]; then
  echo -e "${RED}Chromebrew should not be installed or run as root.${RESET}"
  exit 1;
fi

case ${ARCH}" in
"i686"|"x86_64"|"armv7l"|"aarch64")
  LIB_SUFFIX=''
  ;;
'x86_64')
  LIB_SUFFIX='64'
  ;;
*)
  echo -e "${RED}Your device is not supported by Chromebrew yet :/${RESET}"
  exit 1
  ;;
esac

echo -e "\n\n${YELLOW}Doing initial setup for install in ${CREW_PREFIX}.${RESET}"
echo -e "${YELLOW}This may take a while if there are preexisting files in ${CREW_PREFIX}...${RESET}\n"

# This will allow things to work without sudo
crew_folders="bin cache doc docbook etc include lib lib$LIB_SUFFIX libexec man sbin share tmp var"
for folder in $crew_folders
do
  if [ -d "${CREW_PREFIX}"/"${folder}" ]; then
    echo -e "${BLUE}Resetting ownership of ${CREW_PREFIX}/${folder}${RESET}"
    sudo chown -R "$(id -u)":"$(id -g)" "${CREW_PREFIX}"/"${folder}"
  fi
done
sudo chown "$(id -u)":"$(id -g)" "${CREW_PREFIX}"

# Delete 'var' symlink on Cloudready platform
if [[ $(grep neverware /etc/lsb-release) != "" ]]; then
  [ -L /usr/local/var ] && sudo rm -f /usr/local/var
  [ -L /usr/local/local ] && sudo rm -f /usr/local/local
fi

# prepare directories
mkdir -p "${CREW_CONFIG_PATH}/meta" "${CREW_DEST_DIR}" "${CREW_PACKAGES_PATH}" "${CREW_CACHE_DIR}"

# prepare url and sha256
urls=()
sha256s=()

case "${ARCH}" in
"armv7l"|"aarch64")
  if ! type "xz" > /dev/null; then
    urls+=('https://github.com/snailium/chrome-cross/releases/download/v1.8.1/xz-5.2.3-chromeos-armv7l.tar.gz')
    sha256s+=('4dc9f086ee7613ab0145ec0ed5ac804c80c620c92f515cb62bae8d3c508cbfe7')
  fi
  ;;
esac

# create the device.json file if it doesn't exist
cd "${CREW_CONFIG_PATH}"
if [ ! -f device.json ]; then
  echo -e "\n${YELLOW}Creating new device.json.${RESET}"
  jq --arg key0 'architecture' --arg value0 "${ARCH}" \
    --arg key1 'installed_packages' \
    '. | .[$key0]=$value0 | .[$key1]=[]' <<<'{}' > device.json
fi
echo -e "\n${YELLOW}Downloading information for Bootstrap packages...${RESET}"
echo -e "${GRAY}"
(cd "${CREW_LIB_PATH}"/packages && curl -#OL "${URL}"/packages/{"${BOOTSTRAP_PACKAGES// /,}"}.rb)
echo -e "${RESET}"

for package in $BOOTSTRAP_PACKAGES; do
  pkgfile="$(cat "${CREW_LIB_PATH}"/packages/"$package".rb)"
  temp_url="$(echo "$pkgfile" | grep -m 3 "$ARCH": | head -n 1 | cut -d\' -f2 | tr -d \' | tr -d \" | sed 's/,//g')"
  temp_sha256="$(echo "$pkgfile" | grep -m 3 "$ARCH": | tail -n 1 | cut -d\' -f2 | tr -d \' | tr -d \" | sed 's/,//g')"
  urls[k]="$temp_url"
  sha256s[k]="$temp_sha256"
  k=$((k+1))
done

for package in ${BOOTSTRAP_PACKAGES}; do
  urls+=("$(sed -n '/binary_url.*({/,/})/p' ${CREW_PACKAGES_PATH}/${package}.rb | sed -n "s/\,//g; s/^[[:blank:]]*${ARCH}: .\(.*\)./\1/p")")
  sha256s+=("$(sed -n '/binary_sha256.*({/,/})/p' ${CREW_PACKAGES_PATH}/${package}.rb | sed -n "s/\,//g; s/^[[:blank:]]*${ARCH}: .\(.*\)./\1/p")")
done

# functions to maintain packages
function download_check () {
    cd "$CREW_BREW_DIR"
    # use cached file if available and caching enabled
    if [ -n "$CREW_CACHE_ENABLED" ] && [[ -f "$CREW_CACHE_DIR/${3}" ]] ; then
      echo -e "${BLUE}Verifying cached ${1}...${RESET}"
      echo -e "${GREEN}$(echo "${4}" "$CREW_CACHE_DIR/${3}" | sha256sum -c -)${RESET}"
      case "${?}" in
      0)
        ln -sf "$CREW_CACHE_DIR/${3}" "$CREW_BREW_DIR/${3}" || true
        return
        ;;
      *)
        echo -e "${RED}Verification of cached ${1} failed, downloading.${RESET}"
      esac
    fi
    #download
    echo -e "${BLUE}Downloading ${1}...${RESET}"
    $CURL '-#' -L "${2}" -o "${3}"

    #verify
    echo -e "${BLUE}Verifying ${1}...${RESET}"
    echo -e "${GREEN}$(echo "${4}" "${3}" | sha256sum -c -)${RESET}"
    case "${?}" in
    0)
      if [ -n "$CREW_CACHE_ENABLED" ] ; then
        cp "${3}" "$CREW_CACHE_DIR/${3}" || true
      fi
      return
      ;;
    *)
      echo -e "${RED}Verification failed, something may be wrong with the download.${RESET}"
      exit 1;;
    esac
}

function extract_install () {
    # Start with a clean slate
    rm -rf "${CREW_DEST_DIR}"
    mkdir "${CREW_DEST_DIR}"
    cd "${CREW_DEST_DIR}"

    #extract and install
    echo -e "${BLUE}Extracting ${1} ...${RESET}"
    if ! LD_LIBRARY_PATH=${CREW_PREFIX}/lib${LIB_SUFFIX}:/lib${LIB_SUFFIX} pixz -h &> /dev/null; then
      tar xpf ../"${2}"
    else
      LD_LIBRARY_PATH=${CREW_PREFIX}/lib${LIB_SUFFIX}:/lib${LIB_SUFFIX} tar -Ipixz -xpf ../"${2}"
    fi
    echo -e "${BLUE}Installing ${1} ...${RESET}"
    tar cpf - ./*/* | (cd /; tar xp --keep-directory-symlink -f -)
    mv ./dlist "${CREW_CONFIG_PATH}/meta/${1}.directorylist"
    mv ./filelist "${CREW_CONFIG_PATH}/meta/${1}.filelist"
}

function update_device_json () {
  cd "${CREW_CONFIG_PATH}"

  if [[ $(jq --arg key "$1" -e '.installed_packages[] | select(.name == $key )' device.json) ]]; then
    echo -e "${BLUE}Updating version number of ${1} in device.json...${RESET}"
    cat <<< $(jq --arg key0 "$1" --arg value0 "$2" '(.installed_packages[] | select(.name == $key0) | .version) |= $value0' device.json) > device.json
  else
    echo -e "${BLUE}Adding new information on ${1} to device.json...${RESET}"
    cat <<< $(jq --arg key0 "$1" --arg value0 "$2" '.installed_packages |= . + [{"name": $key0, "version": $value0}]' device.json ) > device.json
  fi
}
echo -e "${YELLOW}Downloading Bootstrap packages...${RESET}\n"
# extract, install and register packages
for i in $(seq 0 $((${#urls[@]} - 1))); do
  url="${urls["${i}"]}"
  sha256="${sha256s["${i}"]}"
  tarfile="$(basename ${url})"
  name="${tarfile%%-*}"   # extract string before first '-'
  rest="${tarfile#*-}"    # extract string after first '-'
  version="$(echo ${rest} | sed -e 's/-chromeos.*$//')"
                        # extract string between first '-' and "-chromeos"

  download_check "${name}" "${url}" "${tarfile}" "${sha256}"
  extract_install "${name}" "${tarfile}"
  update_device_json "${name}" "${version}"
done

## workaround https://github.com/skycocker/chromebrew/issues/3305
sudo ldconfig &> /dev/null || true
echo -e "\n${YELLOW}Creating symlink to 'crew' in ${CREW_PREFIX}/bin/${RESET}"
echo -e "${GRAY}"
ln -sfv "../lib/crew/bin/crew" "${CREW_PREFIX}/bin/"
echo -e "${RESET}"

echo -e "${YELLOW}Setup and synchronize local package repo...${RESET}"
echo -e "${GRAY}"

# Remove old git config directories if they exist
rm -rf "${CREW_LIB_PATH}"

# Do a minimal clone, which also sets origin to the master/main branch
# by default. For more on why this setup might be useful see:
# https://github.blog/2020-01-17-bring-your-monorepo-down-to-size-with-sparse-checkout/
git clone --depth=1 --filter=blob:none --no-checkout "https://github.com/${OWNER}/${REPO}.git" "${CREW_LIB_PATH}"

cd "${CREW_LIB_PATH}"

# Checkout, overwriting local files.
git checkout "${BRANCH}"

# Set sparse-checkout folders and include install.sh for use in reinstalls
# or to fix problems.
git sparse-checkout set packages lib bin crew tools install.sh
git reset --hard origin/"${BRANCH}"
echo -e "${RESET}"

echo -e "${YELLOW}Updating crew package information...${RESET}\n"
# Since we just ran git, just update package compatibility information.
crew update compatible

echo -e "${YELLOW}Installing core Chromebrew packages...${RESET}\n"
yes | crew install core

echo -e "\n${YELLOW}Running Bootstrap package postinstall scripts...${RESET}\n"
crew postinstall $BOOTSTRAP_PACKAGES

if [[ "${CREW_PREFIX}" != "/usr/local" ]]; then
  echo -e "\n${YELLOW}
Since you have installed Chromebrew in a directory other than '/usr/local',
you need to run these commands to complete your installation:
${RESET}"

  echo -e "${BLUE}
echo 'export CREW_PREFIX=${CREW_PREFIX}' >> ~/.bashrc
echo 'export PATH=\"\${CREW_PREFIX}/bin:\${CREW_PREFIX}/sbin:\${PATH}\"' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=${CREW_PREFIX}/lib${LIB_SUFFIX}' >> ~/.bashrc
source ~/.bashrc
${RESET}"
fi
echo -e "${BLUE}
Edit ${CREW_PREFIX}/etc/env.d/02-pager to change the default PAGER.
more is used by default

You may wish to edit the ${CREW_PREFIX}/etc/env.d/01-editor file for an editor default.

Chromebrew provides nano, vim and emacs as default TUI editor options.

${RESET}"
echo -e "${GREEN}Chromebrew installed successfully and package lists updated.${RESET}"
