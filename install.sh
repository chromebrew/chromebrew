#!/bin/bash

# exit on fail
set -e

#chromebrew directories
: "${OWNER:=chromebrew}"
: "${REPO:=chromebrew}"
: "${BRANCH:=master}"
URL="https://raw.githubusercontent.com/${OWNER}/${REPO}/${BRANCH}"
: "${CREW_PREFIX:=/usr/local}"
CREW_LIB_PATH="${CREW_PREFIX}/lib/crew"
CREW_CONFIG_PATH="${CREW_PREFIX}/etc/crew"
CREW_BREW_DIR="${CREW_PREFIX}/tmp/crew"
CREW_DEST_DIR="${CREW_BREW_DIR}/dest"
CREW_PACKAGES_PATH="${CREW_LIB_PATH}/packages"
: "${CURL:=/usr/bin/curl}"
: "${CREW_CACHE_DIR:=$CREW_PREFIX/tmp/packages}"
# For container usage, where we want to specify i686 arch
# on a x86_64 host by setting ARCH=i686.
: "${ARCH:=$(uname -m)}"
# For container usage, when we are emulating armv7l via linux32
# uname -m reports armv8l.
ARCH="${ARCH/armv8l/armv7l}"

# BOOTSTRAP_PACKAGES cannot depend on crew_profile_base for their core operations (completion scripts are fine)
BOOTSTRAP_PACKAGES="crew_mvdir pixz ca_certificates ruby openssl"
[ -x /usr/bin/zstd ] || BOOTSTRAP_PACKAGES="zstd ${BOOTSTRAP_PACKAGES}" # use system zstd if available
[ -x "${CREW_PREFIX}"/bin/xz ] && rm "${CREW_PREFIX}"/bin/xz # remove local xz if installed

# i686 requires gcc and openssl
[ "${ARCH}" == "i686" ] && BOOTSTRAP_PACKAGES+=" gcc_lib"

RED='\e[1;91m';    # Use Light Red for errors.
YELLOW='\e[1;33m'; # Use Yellow for informational messages.
GREEN='\e[1;32m';  # Use Green for success messages.
BLUE='\e[1;34m';   # Use Blue for intrafunction messages.
GRAY='\e[0;37m';   # Use Gray for program output.
MAGENTA='\e[1;35m';
RESET='\e[0m'

# Simplify colors and print errors to stderr (2).
echo_error() { echo -e "${RED}${*}${RESET}" >&2; }
echo_info() { echo -e "${YELLOW}${*}${RESET}" >&1; }
echo_success() { echo -e "${GREEN}${*}${RESET}" >&1; }
echo_intra() { echo -e "${BLUE}${*}${RESET}" >&1; }
echo_out() { echo -e "${GRAY}${*}${RESET}" >&1; }
echo_other() { echo -e "${MAGENTA}${*}${RESET}" >&2; }

# Skip all checks if running on a docker container.
[[ -f "/.dockerenv" ]] && CREW_FORCE_INSTALL=1

# Reject crostini.
if [[ -d /opt/google/cros-containers && "${CREW_FORCE_INSTALL}" != '1' ]]; then
  echo_error "Crostini containers are not supported by Chromebrew :/"
  echo_info "Run 'curl -Ls git.io/vddgY | CREW_FORCE_INSTALL=1 bash' to perform install anyway"
  exit 1
fi

# Disallow non-stable channels Chrome OS.
if [ -f /etc/lsb-release ]; then
  if [[ ! "$(< /etc/lsb-release)" =~ CHROMEOS_RELEASE_TRACK=stable-channel$'\n' && "${CREW_FORCE_INSTALL}" != '1' ]]; then
    echo_error "The beta, dev, and canary channel are unsupported by Chromebrew"
    echo_info "Run 'curl -Ls git.io/vddgY | CREW_FORCE_INSTALL=1 bash' to perform install anyway"
    exit 1
  fi
else
  echo_info "Unable to detect system information, installation will continue."
fi

if [ "${EUID}" == "0" ]; then
  echo_error "Chromebrew should not be installed or run as root."
  exit 1;
fi

echo_success "Welcome to Chromebrew!"

# Prompt user to enter the sudo password if it set.
# If the PASSWD_FILE specified by chromeos-setdevpasswd exist, that means a sudo password is set.
if [[ "$(< /usr/sbin/chromeos-setdevpasswd)" =~ PASSWD_FILE=\'([^\']+) ]] && [ -f "${BASH_REMATCH[1]}" ]; then
  echo_intra "Please enter the developer mode password"
  # Reset sudo timeout.
  sudo -k
  sudo /bin/true
fi

# Force curl to use system libraries.
function curl () {
  # Retry if download failed.
  # The --retry/--retry-all-errors parameter in curl will not work with
  # the 'curl: (7) Couldn't connect to server' error, a for loop is used
  # here.
  for (( i = 0; i < 4; i++ )); do
    # force TLS as we know GitLab supports it
    env -u LD_LIBRARY_PATH "${CURL}" --ssl-reqd --tlsv1.2 -C - "${@}" && return 0
    echo_info "Retrying, $((3-i)) retries left."
  done
  # The download failed if we're still here.
  echo_error "Download failed :/ Please check your network settings."
  return 1
}

case "${ARCH}" in
"i686"|"x86_64"|"armv7l"|"aarch64")
  LIB_SUFFIX=
  # See https://superuser.com/a/1369875
  # If /bin/bash is 64-bit, then set LIB_SUFFIX, as this is true on both
  # x86_64 and aarch64 userspace
  # shellcheck disable=SC2046
  [ $(od -An -t x1 -j 4 -N 1  /bin/bash) == 02 ] && LIB_SUFFIX='64'
  if [[ $LIB_SUFFIX == '64' ]] && [[ $ARCH == 'aarch64' ]]; then
    echo_error "Your device is not supported by Chromebrew yet, installing as armv7l."
    LIB_SUFFIX=
    ARMV7LONAARCH64=1
  fi
  ;;
*)
  echo_error "Your device is not supported by Chromebrew yet :/"
  exit 1
  ;;
esac

libc_version=$(/lib"$LIB_SUFFIX"/libc.so.6 | head -n 1 | sed -E 's/.*(stable release version.*) (.*)./\2/')
case "${libc_version}" in
"2.35")
# Prepend the correct packages for M113 onwards systems.
BOOTSTRAP_PACKAGES="glibc_lib235 zlibpkg gmp ${BOOTSTRAP_PACKAGES}"
  ;;
*)
  ;;
esac

echo_info "\n\nDoing initial setup for install in ${CREW_PREFIX}."
echo_info "This may take a while if there are preexisting files in ${CREW_PREFIX}...\n"

# This will allow things to work without sudo.
crew_folders="bin cache doc docbook etc include lib lib$LIB_SUFFIX libexec man sbin share tmp var"
for folder in $crew_folders
do
  if [ -d "${CREW_PREFIX}"/"${folder}" ]; then
    echo_intra "Resetting ownership of ${CREW_PREFIX}/${folder}"
    sudo chown -R "$(id -u)":"$(id -g)" "${CREW_PREFIX}"/"${folder}"
  fi
done
sudo chown "$(id -u)":"$(id -g)" "${CREW_PREFIX}"

# Delete ${CREW_PREFIX}/{var,local} symlinks on some Chromium OS distro
# if they exist.
[ -L "${CREW_PREFIX}"/var ] && sudo rm -f "${CREW_PREFIX}/var"
[ -L "${CREW_PREFIX}"/local ] && sudo rm -f "${CREW_PREFIX}/local"

# Prepare directories.
for dir in "${CREW_CONFIG_PATH}/meta" "${CREW_DEST_DIR}" "${CREW_PACKAGES_PATH}" "${CREW_CACHE_DIR}" ; do
  if [ ! -d "${dir}" ]; then
    mkdir -p "${dir}"
  fi
done

echo_info "\nDownloading information for Bootstrap packages..."
echo -en "${GRAY}"
# Use parallel mode if available.
CURL_OPTS="-OL"
[[ "$(curl --help curl)" =~ --parallel ]] && CURL_OPTS+="Z"
BOOTSTRAP_PKGS="${BOOTSTRAP_PACKAGES// /.rb,}.rb"
cd "${CREW_PACKAGES_PATH}" && curl "${CURL_OPTS}" "${URL}/packages/{${BOOTSTRAP_PKGS}}"
echo -e "${RESET}"

# Prepare url and sha256.
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

# Create the device.json file if it doesn't exist.
cd "${CREW_CONFIG_PATH}"
if [ ! -f device.json ]; then
  echo_info "\nCreating new device.json."
  jq --arg key0 'architecture' --arg value0 "${ARCH}" \
    --arg key1 'installed_packages' \
    '. | .[$key0]=$value0 | .[$key1]=[]' <<<'{}' > device.json
fi

for package in ${BOOTSTRAP_PACKAGES}; do
  pkgfile="${CREW_PACKAGES_PATH}/${package}.rb"

  [[ "$(sed -n '/binary_sha256/,/}/p' "${pkgfile}")" =~ .*${ARCH}:[[:blank:]]*[\'\"]([^\'\"]*) ]]
    sha256s+=("${BASH_REMATCH[1]}")

  [[ "$(sed -n '/binary_url/,/}/p' "${pkgfile}")" =~ .*${ARCH}:[[:blank:]]*[\'\"]([^\'\"]*) ]]
    urls+=("${BASH_REMATCH[1]}")
done

# These functions are for handling packages.
function download_check () {
    cd "$CREW_BREW_DIR"
    # Use cached file if available and caching enabled.
    if [ -n "$CREW_CACHE_ENABLED" ] && [[ -f "$CREW_CACHE_DIR/${3}" ]] ; then
      echo_intra "Verifying cached ${1}..."
      echo_success "$(echo "${4}" "$CREW_CACHE_DIR/${3}" | sha256sum -c -)"
      case "${?}" in
      0)
        ln -sf "$CREW_CACHE_DIR/${3}" "$CREW_BREW_DIR/${3}" || true
        return
        ;;
      *)
        echo_error "Verification of cached ${1} failed, downloading."
      esac
    fi
    #download
    echo_intra "Downloading ${1}..."
    curl '-#' -L "${2}" -o "${3}"

    #verify
    echo_intra "Verifying ${1}..."
    echo_success "$(echo "${4}" "${3}" | sha256sum -c -)"
    case "${?}" in
    0)
      if [ -n "$CREW_CACHE_ENABLED" ] ; then
        cp "${3}" "$CREW_CACHE_DIR/${3}" || true
      fi
      return
      ;;
    *)
      echo_error "Verification failed, something may be wrong with the download."
      exit 1;;
    esac
}

function extract_install () {
    # Start with a clean slate.
    rm -rf "${CREW_DEST_DIR}"
    mkdir "${CREW_DEST_DIR}"
    cd "${CREW_DEST_DIR}"

    #Extract and install.
    echo_intra "Extracting ${1} ..."
    case "${2}" in
    *.zst)
      if [[ -e /usr/bin/zstd ]]; then
        tar -I /usr/bin/zstd -xpf ../"${2}"
      elif ("${CREW_PREFIX}"/bin/zstd --version &> /dev/null); then
        tar -I "${CREW_PREFIX}"/bin/zstd -xpf ../"${2}"
      else
        echo "Zstd is broken or nonfunctional, and some packages can not be extracted properly."
        exit 1
      fi
    ;;
    *.tpxz)
      if "${CREW_PREFIX}"/bin/pixz -h &> /dev/null; then
        tar -I "${CREW_PREFIX}"/bin/pixz -xpf ../"${2}"
      else
        echo "Pixz is broken or nonfunctional, and some packages can not be extracted properly."
        exit 1
      fi
    ;;
    *)
      tar xpf ../"${2}"
    ;;
    esac
    echo_intra "Installing ${1} ..."
    tar cpf - ./*/* | (cd /; tar xp --keep-directory-symlink -m -f -)
    mv ./dlist "${CREW_CONFIG_PATH}/meta/${1}.directorylist"
    mv ./filelist "${CREW_CONFIG_PATH}/meta/${1}.filelist"
}

function update_device_json () {
  cd "${CREW_CONFIG_PATH}"

  if [[ $(jq --arg key "$1" -e '.installed_packages[] | select(.name == $key )' device.json) ]]; then
    echo_intra "Updating version number of ${1} in device.json..."
    ver_num=$(jq --arg key0 "$1" --arg value0 "$2" '(.installed_packages[] | select(.name == $key0) | .version) |= $value0' device.json)
    cat <<< "${ver_num}" > device.json
  else
    echo_intra "Adding new information on ${1} to device.json..."
    new_info=$(jq --arg key0 "$1" --arg value0 "$2" '.installed_packages |= . + [{"name": $key0, "version": $value0}]' device.json)
    cat <<< "${new_info}" > device.json
  fi
}
echo_info "Downloading Bootstrap packages...\n"
# Extract, install and register packages.
for i in $(seq 0 $((${#urls[@]} - 1))); do
  url=${urls["${i}"]}
  sha256=${sha256s["${i}"]}
  tarfile=$(basename "${url}")
  name="${tarfile%%-*}"   # extract string before first '-'
  rest="${tarfile#*-}"    # extract string after first '-'
  version="${rest%%-chromeos*}"
                          # extract string between first '-' and "-chromeos"

  download_check "${name}" "${url}" "${tarfile}" "${sha256}"
  extract_install "${name}" "${tarfile}"
  update_device_json "${name}" "${version}"
done

echo_info "\nCreating symlink to 'crew' in ${CREW_PREFIX}/bin/"
echo -e "${GRAY}"
ln -sfv "../lib/crew/bin/crew" "${CREW_PREFIX}/bin/"
echo -e "${RESET}"

echo_info "Setup and synchronize local package repo..."
echo -e "${GRAY}"

# Remove old git config directories if they exist.
find "${CREW_LIB_PATH}" -mindepth 1 -delete

curl -L --progress-bar https://github.com/"${OWNER}"/"${REPO}"/tarball/"${BRANCH}" | tar -xz --strip-components=1 -C "${CREW_LIB_PATH}"

# Set LD_LIBRARY_PATH so crew doesn't break on i686 and
# the mandb install doesn't fail.
export LD_LIBRARY_PATH="${CREW_PREFIX}/lib${LIB_SUFFIX}"

# Since we just downloaded the package repo, just update package
# compatibility information.
crew update compatible

echo_info "Installing core Chromebrew packages...\n"
yes | crew install core

echo_info "\nRunning Bootstrap package postinstall scripts...\n"
# shellcheck disable=SC2086
# Do NOT quote BOOTSTRAP_PACKAGES, otherwise crew thinks the list of
# packages passed to crew postinstall is a single package.
crew postinstall ${BOOTSTRAP_PACKAGES}

if ! "${CREW_PREFIX}"/bin/git version &> /dev/null; then
  echo_error "\nGit is broken on your system, and crew update will not work properly."
  echo_error "Please report this here:"
  echo_error "https://github.com/chromebrew/chromebrew/issues\n\n"
else
  echo_info "Synchronizng local package repo..."
  # First clear out temporary package repo so we can replace it with the
  # repo downloaded via git.
  find "${CREW_LIB_PATH}" -mindepth 1 -delete

  # Do a minimal clone, which also sets origin to the master/main branch
  # by default. For more on why this setup might be useful see:
  # https://github.blog/2020-01-17-bring-your-monorepo-down-to-size-with-sparse-checkout/
  # If using alternate branch don't use depth=1 .
  if [[ "$BRANCH" == "master" ]]; then
    git clone --depth=1 --filter=blob:none --no-checkout "https://github.com/${OWNER}/${REPO}.git" "${CREW_LIB_PATH}"
  else
    git clone --filter=blob:none --no-checkout "https://github.com/${OWNER}/${REPO}.git" "${CREW_LIB_PATH}"
  fi

  cd "${CREW_LIB_PATH}"

  # Checkout, overwriting local files.
  [[ "$BRANCH" != "master" ]] && git fetch --all
  git checkout "${BRANCH}"

  # Set sparse-checkout folders.
  git sparse-checkout set packages lib bin crew tools
  git reset --hard origin/"${BRANCH}"
fi
echo -e "${RESET}"

echo "                       . .
                   ..,:;;;::'..
                 .':lllllllool,.
                ...cl;..... ,::;'.
               .'oc...;::::..0KKo.
               .'od: .:::::, lolc.
             .'lNMMMO ;ooc.,XMMWx;:;.
            .dMMMMMMXkMMMMxoMMMMMMMMO.
            .:O0NMMMMMMMMMM0MMMMMN0Oc.
              .:xdloddddddoXMMMk:x:....
              .xMNOKX0OOOOxcodlcXMN0O0XKc.
              .OMXOKXOOOOOk;ol:OXMK...;N0.
              'XMKOXXOOOOOk:docOKMW,  .kW;
             .cMMKOXXOOOOOOOOOOO0MM;  .lMc.
             .cMM00XKOOOOkkkkkkOOWMl. .cMo.
             .lMWO0XKOOOkkkkkkkkONMo.  ;Wk.
             .oMNO0X0OOkkkkkkkkkOXMd..,oW0'
             .xMNO0X0OOkkkkkkkkkkXMWKXKOx;.
             .0MXOOOOOOkkkkkkkkkOKM0..
             'NMWNXXKK000000KKXNNMMX.
             .;okk0XNWWMMMMWWNKOkdc'.
                .....'cc:cc:''..."
echo "  ___ _                               _
 / (_)|\                              |\\
|     ||__    ,_    __  _  _  _    __ |/_  ,_    __  _   _   _
|     |/  |  /  |  /  \/ |/ |/ |  |_/ |  \/  |  |_/ /|   |   |\_
 \___/|   |_/   |_/\__/  |  |  |_/|__/\__/   |_/|__/  \_/ \_/
"

if [[ "${CREW_PREFIX}" != "/usr/local" ]]; then
  echo_info "\n$
Since you have installed Chromebrew in a directory other than '/usr/local',
you need to run these commands to complete your installation:
"

  echo_intra "
echo 'export CREW_PREFIX=${CREW_PREFIX}' >> ~/.bashrc
echo 'export PATH=\"\${CREW_PREFIX}/bin:\${CREW_PREFIX}/sbin:\${PATH}\"' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=${CREW_PREFIX}/lib${LIB_SUFFIX}' >> ~/.bashrc
source ~/.bashrc"
fi
echo_intra "
Edit ${CREW_PREFIX}/etc/env.d/03-pager to change the default PAGER.
most is used by default

You may wish to edit the ${CREW_PREFIX}/etc/env.d/02-editor file for an editor default.

Chromebrew provides nano, vim and emacs as default TUI editor options."

echo_success "Chromebrew installed successfully and package lists updated."
if [[ "$ARMV7LONAARCH64" == '1' ]]; then
  echo_other "\n
Since you have installed an armv7l Chromebrew on an aarch64 userspace
system, you MUST run these commands to complete your installation:
"

  echo_info "
echo -e '\\\nexport LD_LIBRARY_PATH=${CREW_PREFIX}/lib' >> ~/.bashrc
source ~/.bashrc"
fi
