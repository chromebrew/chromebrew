#!/bin/bash

# Exit on fail.
set -e

# Default chromebrew repo values.

: "${OWNER:=chromebrew}"
: "${REPO:=chromebrew}"
: "${BRANCH:=master}"

# Chromebrew directories
: "${CREW_PREFIX:=/usr/local}"
CREW_LIB_PATH="${CREW_PREFIX}/lib/crew"
CREW_CONFIG_PATH="${CREW_PREFIX}/etc/crew"
CREW_BREW_DIR="${CREW_PREFIX}/tmp/crew"
CREW_DEST_DIR="${CREW_BREW_DIR}/dest"
: "${CURL:=/usr/bin/curl}"
: "${CREW_CACHE_DIR:=$CREW_PREFIX/tmp/packages}"

# Architecture

# For container usage, where we want to specify i686 arch
# on a x86_64 host by setting ARCH=i686.
: "${ARCH:=$(uname -m)}"
# For container usage, when we are emulating armv7l via linux32
# uname -m reports armv8l.
ARCH="${ARCH/armv8l/armv7l}"

# Determine if there is a difference between kernel and user space
if [[ "${ARCH}" == "aarch64" && ! -d '/lib64' ]]; then
  USER_SPACE_ARCH='armv7l'
else
  USER_SPACE_ARCH="${ARCH}"
fi

if [[ "$ARCH" == "x86_64" ]]; then
  LIB_SUFFIX='64'
fi


RESET='\e[0m'

# Simplify colors and print errors to stderr (2).
echo_error() { echo -e "\e[1;91m${*}${RESET}" >&2; } # Use Light Red for errors.
echo_info() { echo -e "\e[1;33m${*}${RESET}" >&1; } # Use Yellow for informational messages.
echo_success() { echo -e "\e[1;32m${*}${RESET}" >&1; } # Use Green for success messages.
echo_intra() { echo -e "\e[1;34m${*}${RESET}" >&1; } # Use Blue for intrafunction messages.
echo_out() { echo -e "\e[0;37m${*}${RESET}" >&1; } # Use Gray for program output.

# Skip all checks if running on a docker container.
[[ -f "/.dockerenv" ]] && CREW_FORCE_INSTALL=1

# Reject crostini.
if [[ -d /opt/google/cros-containers && "${CREW_FORCE_INSTALL}" != '1' ]]; then
  echo_error "Crostini containers are not supported by Chromebrew :/"
  echo_info "Run 'CREW_FORCE_INSTALL=1 exec bash --init-file <(curl -Ls git.io/vddgY)' to perform install anyway"
  exit 1
fi

# Reject non-stable Chrome OS channels.
if [ -f /etc/lsb-release ]; then
  if [[ ! "$(< /etc/lsb-release)" =~ CHROMEOS_RELEASE_TRACK=stable-channel$'\n' && "${CREW_FORCE_INSTALL}" != '1' ]]; then
    echo_error "The beta, dev, and canary channel are unsupported by Chromebrew"
    echo_info "Run 'CREW_FORCE_INSTALL=1 exec bash --init-file <(curl -Ls git.io/vddgY)' to perform install anyway"
    exit 1
  fi
else
  echo_info "Unable to detect system information, installation will continue."
fi

# Check if the script is being run as root.
if [ "${EUID}" == "0" ]; then
  echo_error "Chromebrew should not be installed or run as root."
  exit 1;
fi

echo_success "Welcome to Chromebrew!"

# Prompt user to enter the sudo password if it is set.
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
    # Force TLS as we know GitLab supports it
    env -u LD_LIBRARY_PATH "${CURL}" --ssl-reqd --tlsv1.2 -C - "${@}" && return 0
    echo_info "Retrying, $((3-i)) retries left."
  done
  # The download failed if we're still here.
  echo_error "Download failed :/ Please check your network settings."
  return 1
}

if [[ "$USER_SPACE_ARCH" == 'armv7l' ]] && [[ "$ARCH" == 'aarch64' ]]; then
    echo_error "Your device is not supported by Chromebrew yet, installing as armv7l."
fi

if [ -d "${CREW_PREFIX}" ]; then
  if [ "$(ls -A "${CREW_PREFIX}")" ]; then
    echo_error "${CREW_PREFIX} is not empty, would you like it to be cleared?"
    echo_info "This will delete ALL files in ${CREW_PREFIX}!"
    echo_info "Continue?"
    select continue in "Yes" "No"; do
      if [[ "${continue}" == "Yes" ]]; then
        sudo find "${CREW_PREFIX}" -mindepth 1 -delete
        break 2
      else
        exit 1
      fi
    done
  fi
else
  sudo mkdir "${CREW_PREFIX}"
fi

# This will allow things to work without sudo.
sudo chown "$(id -u)":"$(id -g)" "${CREW_PREFIX}"
# This will create the directories.
crew_folders="bin cache doc docbook include lib/crew/packages lib$LIB_SUFFIX libexec man sbin share var etc/crew/meta etc/env.d tmp/crew/dest"
# shellcheck disable=SC2086
# Quoting crew_folders leads to breakage
(cd "${CREW_PREFIX}"; mkdir -p ${crew_folders})


# Remove old git config directories if they exist.
find "${CREW_LIB_PATH}" -mindepth 1 -delete

# Download the chromebrew repository.
${CURL} -L --progress-bar https://github.com/"${OWNER}"/"${REPO}"/tarball/"${BRANCH}" | tar -xz --strip-components=1 -C "${CREW_LIB_PATH}"

# Prepare urls and sha256s variables.
urls=()
sha256s=()

BOOTSTRAP_PACKAGES="zstd crew_mvdir ruby git ca_certificates openssl"

# Older i686 systems.
[[ "${ARCH}" == "i686" ]] && BOOTSTRAP_PACKAGES+=" gcc_lib"


libc_version=$(/lib"$LIB_SUFFIX"/libc.so.6 | head -n 1 | sed -E 's/.*(stable release version.*) (.*)./\2/')
case ${libc_version} in
  # Append the correct packages for M113 onwards systems.
  "2.35") BOOTSTRAP_PACKAGES="${BOOTSTRAP_PACKAGES} glibc_lib235 zlibpkg gmp";;
esac

# Get the URLs and hashes of the bootstrap packages.
for package in $BOOTSTRAP_PACKAGES; do
  cd "${CREW_LIB_PATH}/packages"
  [[ "$(sed -n '/binary_sha256/,/}/p' "${package}.rb")" =~ .*${ARCH}:[[:blank:]]*[\'\"]([^\'\"]*) ]]
    sha256s+=("${BASH_REMATCH[1]}")

  nln=$(nl -b a -n ln "${package}.rb" | sed -n '/class/p' | head -1 | cut -c 1)
  vln=$(nl -b a -n ln "${package}.rb" | sed -n '/  version/p' | head -1 | cut -c 1)
  name=$(sed -n "${nln}s/class\(.*\)<.*/\L\1/;${nln}s/^[ \t]*//;${nln}s/[ \t]*$//p" "${package}.rb")
  version=$(sed -n "${vln}s/version \(.*\)/\1/;${vln}s/^[ \t]*//;${vln}s/[ \t]*$//;${vln}s/ *#.*//p" "${package}.rb" | tr -d "'")

  # This is really ugly, FIXME after #7082 is merged.
  if [[ "${package}" == "zstd" ]] || [[ "${package}" == "crew_mvdir" ]] || [[ "${package}" == "gmp" ]]; then
    if [[ "$ARCH" == "aarch64" ]]; then
      urls+=("https://gitlab.com/api/v4/projects/26210301/packages/generic/${name}/${version}_armv7l/${name}-${version}-chromeos-armv7l.tar.xz")
    else
      urls+=("https://gitlab.com/api/v4/projects/26210301/packages/generic/${name}/${version}_${ARCH}/${name}-${version}-chromeos-${ARCH}.tar.xz")
    fi
  else
    [[ "${package}" == "glibc_lib235" ]] && name="glibc_lib"
    if [[ "$ARCH" == "aarch64" ]]; then
      urls+=("https://gitlab.com/api/v4/projects/26210301/packages/generic/${name}/${version}_armv7l/${name}-${version}-chromeos-armv7l.tar.zst")
    else
      urls+=("https://gitlab.com/api/v4/projects/26210301/packages/generic/${name}/${version}_${ARCH}/${name}-${version}-chromeos-${ARCH}.tar.zst")
    fi
  fi

done

# Create the device.json file if it doesn't exist.
if [ ! -f "${CREW_CONFIG_PATH}/device.json" ]; then
  cd "${CREW_CONFIG_PATH}"
  echo_info "\nCreating new device.json."
  jq --arg key0 'architecture' --arg value0 "${ARCH}" \
    --arg key1 'installed_packages' \
    '. | .[$key0]=$value0 | .[$key1]=[]' <<<'{}' > device.json
fi

# Functions to maintain packages

# These functions are for handling packages.
function download_check () {
    cd "$CREW_BREW_DIR"
    # Use cached file if available and caching is enabled.
    if [ -n "$CREW_CACHE_ENABLED" ] && [[ -f "$CREW_CACHE_DIR/${3}" ]] ; then
      mkdir -p "$CREW_CACHE_DIR"
      sudo chown -R "$(id -u)":"$(id -g)" "$CREW_CACHE_DIR" || true
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
    # Download
    echo_intra "Downloading ${1}..."
    curl '-#' -L "${2}" -o "${3}"

    # Verify
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

    # Extract and install.
    echo_intra "Extracting ${1} ..."
    # This could be avoided if our zstd was compiled with lzma support.
    if [[ "${2##*.}" == "zst" ]]; then
      tar -I zstd -xpf ../"${2}"
    else
      tar xpf ../"${2}"
    fi

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
  version="${rest%%-chromeos*}" # extract string between first '-' and "-chromeos"

  download_check "${name}" "${url}" "${tarfile}" "${sha256}"
  extract_install "${name}" "${tarfile}"
  update_device_json "${name}" "${version}"
done

# Work around https://github.com/chromebrew/chromebrew/issues/3305.
# shellcheck disable=SC2024
sudo ldconfig &> /tmp/crew_ldconfig || true

echo_out "\nCreating symlink to 'crew' in ${CREW_PREFIX}/bin/"
ln -sfv "../lib/crew/bin/crew" "${CREW_PREFIX}/bin/"

echo_out "Set up and synchronize local package repo..."

# Set LD_LIBRARY_PATH so crew doesn't break on i686 and
# the mandb postinstall doesn't fail.
if [[ "$ARCH" == "i686" ]]; then
  echo "LD_LIBRARY_PATH=$CREW_PREFIX/lib:/lib" >> "$CREW_PREFIX"/etc/env.d/00-library
  export LD_LIBRARY_PATH=$CREW_PREFIX/lib:/lib
fi
# Add the CREW_PREFIX bin and musl bin directories to PATH.
echo -e "## Inserted by Chromebrew's install.sh\nPATH=$CREW_PREFIX/bin:$CREW_PREFIX/sbin:$CREW_PREFIX/share/musl/bin:\$PATH" > "$CREW_PREFIX"/etc/env.d/path
export PATH=$CREW_PREFIX/bin:$CREW_PREFIX/share/musl/bin:$PATH

echo "export CREW_PREFIX=${CREW_PREFIX}" >> "${CREW_PREFIX}/etc/env.d/profile"

# Since we downloaded the package repo, just update package compatibility information.
crew update compatible

echo_info "Installing core Chromebrew packages...\n"
# We need these to install core.
yes | crew install pixz
yes | crew install core

echo_info "\nRunning Bootstrap package postinstall scripts...\n"
# Due to a bug in crew where it accepts spaces in package files names rather than
# splitting strings at spaces, we cannot quote ${BOOTSTRAP_PACKAGES}
# shellcheck disable=SC2086
crew postinstall ${BOOTSTRAP_PACKAGES}

if ! "${CREW_PREFIX}"/bin/git version &> /dev/null; then
  echo_error "\nGit is broken on your system, and crew update will not work properly."
  echo_error "Please report this here:"
  echo_error "https://github.com/chromebrew/chromebrew/issues\n\n"
else
  echo_info "Synchronizng local package repo..."

  cd "${CREW_LIB_PATH}"

  # Setup the folder with git information.
  git init
  git remote add origin "https://github.com/${OWNER}/${REPO}"

  # Checkout, overwriting local files.
  git fetch --all
  git checkout -f "${BRANCH}"

  # Set sparse-checkout folders.
  git sparse-checkout set packages "manifest/${USER_SPACE_ARCH}" lib bin crew tools
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

echo_info "Please run 'source ~/.bashrc' to set up the profile environment."

echo_intra "
Edit ${CREW_PREFIX}/etc/env.d/03-pager to change the default PAGER.
most is used by default
You may wish to edit the ${CREW_PREFIX}/etc/env.d/02-editor file for an editor default.
Chromebrew provides nano, vim and emacs as default TUI editor options."

echo_success "Chromebrew installed successfully and package lists updated."
