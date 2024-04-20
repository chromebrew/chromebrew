#!/bin/bash

# Exit on fail.
set -eE

RESET='\e[0m'

# Simplify colors and print errors to stderr (2).
echo_error() { echo -e "\e[1;91m${*}${RESET}" >&2; } # Use Light Red for errors.
echo_info() { echo -e "\e[1;33m${*}${RESET}" >&1; } # Use Yellow for informational messages.
echo_success() { echo -e "\e[1;32m${*}${RESET}" >&1; } # Use Green for success messages.
echo_intra() { echo -e "\e[1;34m${*}${RESET}" >&1; } # Use Blue for intrafunction messages.
echo_out() { echo -e "\e[0;37m${*}${RESET}" >&1; } # Use Gray for program output.

# Print a message before exit on error
trap "echo_error 'An error occured during the installation :/'" ERR

# Check if the script is being run as root.
if [ "${EUID}" == "0" ]; then
  echo_error "Chromebrew should not be installed or run as root."
  echo_info "Please login as 'chronos' and restart the install."
  exit 1
fi

# Reject crostini.
if [[ -d /opt/google/cros-containers && "${CREW_FORCE_INSTALL}" != '1' ]]; then
  echo_error "Crostini containers are not supported by Chromebrew :/"
  echo_info "Run 'CREW_FORCE_INSTALL=1 exec bash --init-file <(curl -Ls git.io/vddgY)' to perform install anyway"
  exit 1
fi

# Reject non-stable Chrome OS channels.
if [ -f /etc/lsb-release ]; then
  if [[ ! "$(< /etc/lsb-release)" =~ CHROMEOS_RELEASE_TRACK=stable-channel$'\n' && "${CREW_FORCE_INSTALL}" != '1' ]]; then
    echo_error "The beta, dev, and canary channel are unsupported by Chromebrew."
    echo_info "Run 'CREW_FORCE_INSTALL=1 exec bash --init-file <(curl -Ls git.io/vddgY)' to perform install anyway."
    exit 1
  fi
  export "$(grep CHROMEOS_RELEASE_CHROME_MILESTONE /etc/lsb-release)"
else
  echo_info "Unable to detect system information, installation will continue."
fi

# Check if the user owns the CREW_PREFIX directory, as sudo is unnecessary if this is the case.
# Check if the user is on ChromeOS v117+ and not in the VT-2 console, as sudo will not work.
: "${CREW_PREFIX:=/usr/local}"
if [[ "$(stat -c '%u' "${CREW_PREFIX}")" == "$(id -u)" ]] && sudo 2>&1 | grep -q 'no new privileges'; then
  echo_error "Please run the installer in the VT-2 shell."
  echo_info "To start the VT-2 session, type Ctrl + Alt + ->"
  exit 1
fi

# Make sure installation directory is clean.
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
  sudo mkdir -p "${CREW_PREFIX}"
fi

# Do not redundantly use sudo if the user already owns the directory.
if [ "$(stat -c '%u' "${CREW_PREFIX}")" != "$(id -u)" ]; then
  # This will allow things to work without sudo.
  sudo chown "$(id -u)":"$(id -g)" "${CREW_PREFIX}"
fi

# Default chromebrew repo values.
: "${OWNER:=chromebrew}"
: "${REPO:=chromebrew}"
: "${BRANCH:=master}"

# Chromebrew directories.
CREW_LIB_PATH="${CREW_PREFIX}/lib/crew"
CREW_CONFIG_PATH="${CREW_PREFIX}/etc/crew"
CREW_BREW_DIR="${CREW_PREFIX}/tmp/crew"
CREW_DEST_DIR="${CREW_BREW_DIR}/dest"
: "${CREW_CACHE_DIR:=$CREW_PREFIX/tmp/packages}"

# Architecture

# For container usage, where we want to specify i686 arch
# on a x86_64 host by setting ARCH=i686.
: "${ARCH:=$(uname -m)}"

# For container usage, when we are emulating armv7l via linux32, where uname -m will report armv8l.
# Additionally, if the architecture is aarch64, set it to armv7l, as we treat as if it was armv7l.
# When we have proper support for aarch64, remove this.
if [[ "${ARCH}" = "armv8l" ]] || [[ "${ARCH}" = "aarch64" ]]; then
  ARCH='armv7l'
fi

if [[ "$ARCH" == "x86_64" ]]; then
  LIB_SUFFIX='64'
fi

# Warn users of the AMD segfault issue and allow them to work around it.
# The easiest way to distinguish StoneyRidge platorms is to check for the FMA4
# instruction, as it was first introduced in Bulldozer and later dropped in Zen.
if grep -s "fma4" /proc/cpuinfo ; then
  echo_info "Notice: You are running an AMD StoneyRidge device; due to some bugs some packages may fail with a segmentation fault and need to be rebuilt."
  echo_info "If this happens, please report them to: https://github.com/chromebrew/chromebrew/issues"
  echo_info "If the install fails, try running 'CREW_AMD_INSTALL=1 exec bash --init-file <(curl -Ls git.io/vddgY)'"
  if [ "${CREW_AMD_INSTALL}" == "1" ]; then
    # Otherwise one may get segfaults during install on stoneyridge devices.
    # See https://github.com/chromebrew/chromebrew/issues/8823
    echo 0 | sudo tee /proc/sys/kernel/randomize_va_space
  fi
fi

echo_success "Welcome to Chromebrew!"

# Prompt user to enter the sudo password if it is set.
# If the PASSWD_FILE specified by chromeos-setdevpasswd exist, that means a sudo password is set.
if [[ "$(< /usr/sbin/chromeos-setdevpasswd)" =~ PASSWD_FILE=\'([^\']+) ]] && [ -f "${BASH_REMATCH[1]}" ]; then
  echo_intra "Please enter the developer mode password."
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
    if [[ "$ARCH" == "i686" ]]; then
      # i686 curl throws a "SSL certificate problem: self signed certificate in certificate chain" error.
      env -u LD_LIBRARY_PATH curl -kC - "${@}" && return 0
    else
      # Force TLS as we know GitLab supports it.
      env -u LD_LIBRARY_PATH curl --ssl-reqd --tlsv1.2 -C - "${@}" && return 0
    fi
    echo_info "Retrying, $((3-i)) retries left."
  done
  # The download failed if we're still here.
  echo_error "Download failed :/ Please check your network settings."
  return 1
}

# This will create the directories.
crew_folders="bin cache doc docbook include lib/crew/packages lib$LIB_SUFFIX libexec man sbin share var etc/crew/meta etc/env.d tmp/crew/dest"
# shellcheck disable=SC2086
# Quoting crew_folders leads to breakage.
(cd "${CREW_PREFIX}" && mkdir -p ${crew_folders})


# Remove old git config directories if they exist.
find "${CREW_LIB_PATH}" -mindepth 1 -delete

# Download the chromebrew repository.
curl -L --progress-bar https://github.com/"${OWNER}"/"${REPO}"/tarball/"${BRANCH}" | tar -xz --strip-components=1 -C "${CREW_LIB_PATH}"

BOOTSTRAP_PACKAGES='zstd crew_mvdir ruby git ca_certificates libyaml openssl'

# Older i686 systems.
[[ "${ARCH}" == "i686" ]] && BOOTSTRAP_PACKAGES+=' zlibpkg gcc_lib'

if [[ -n "${CHROMEOS_RELEASE_CHROME_MILESTONE}" ]]; then
  sudo cp /lib$LIB_SUFFIX/libc.so* /usr/local/
  sudo chown chronos /usr/local/lib$LIB_SUFFIX/libc.so*
  sudo chmod 777 /usr/local/lib$LIB_SUFFIX/libc.so*
  if (( "${CHROMEOS_RELEASE_CHROME_MILESTONE}" > "112" )); then
    # Recent Arm systems have a cut down system.
    [[ "${ARCH}" == "armv7l" ]] && BOOTSTRAP_PACKAGES+=' bzip2 ncurses readline pcre2 gcc_lib'
    if (( "${CHROMEOS_RELEASE_CHROME_MILESTONE}" < "123" )); then
      # Append the correct packages for systems running M122 and lower.
      BOOTSTRAP_PACKAGES+=' glibc_lib235 zlibpkg gmp'
    elif (( "${CHROMEOS_RELEASE_CHROME_MILESTONE}" > "122" )); then
      # Append the correct packages for systems running M123 onwards.
      BOOTSTRAP_PACKAGES+=' glibc_lib237 zlibpkg gmp'
    fi
  fi
fi

# Create the device.json file.
cd "${CREW_CONFIG_PATH}"
echo_info "\nCreating device.json."
jq --arg key0 'architecture' --arg value0 "${ARCH}" \
  --arg key1 'installed_packages' \
  '. | .[$key0]=$value0 | .[$key1]=[]' <<<'{}' > device.json

# Functions to maintain packages.

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
  echo_intra "Adding new information on ${1} to device.json..."
  new_info=$(jq --arg name "$1" --arg version "$2" --arg sha256 "$3" '.installed_packages |= . + [{"name": $name, "version": $version, "binary_sha256": $sha256}]' device.json)
  cat <<< "${new_info}" > device.json
}

echo_info "Downloading Bootstrap packages...\n"
# Extract, install and register packages.
for package in $BOOTSTRAP_PACKAGES; do
  cd "${CREW_LIB_PATH}/packages"
  version=$(sed -n "s/.*version '\([^']*\)'.*/\1/p" "${package}.rb")
  binary_compression=$(sed -n "s/.*binary_compression '\([^']*\)'.*/\1/p" "${package}.rb")
  if [[ -z "$binary_compression" ]]; then
    binary_compression='tar.zst'
  fi

  url="https://gitlab.com/api/v4/projects/26210301/packages/generic/${package}/${version}_${ARCH}/${package}-${version}-chromeos-${ARCH}.${binary_compression}"
  tarfile=$(basename "${url}")

  sha256=$(sed -n "s/.*${ARCH}: '\([^']*\)'.*/\1/p" "${package}.rb")

  download_check "${package}" "${url}" "${tarfile}" "${sha256}"
  extract_install "${package}" "${tarfile}"
  update_device_json "${package}" "${version}" "${sha256}"
done

# Work around https://github.com/chromebrew/chromebrew/issues/3305.
# shellcheck disable=SC2024
sudo ldconfig &> /tmp/crew_ldconfig || true

echo_out "\nCreating symlink to 'crew' in ${CREW_PREFIX}/bin/"
ln -sfv "../lib/crew/bin/crew" "${CREW_PREFIX}/bin/"

echo_out "Set up and synchronize local package repo..."

# Set LD_LIBRARY_PATH so crew doesn't break on i686, xz doesn't fail on
# x86_64, and the mandb postinstall doesn't fail in newer arm
# containers.
echo "LD_LIBRARY_PATH=$CREW_PREFIX/lib${LIB_SUFFIX}:/lib${LIB_SUFFIX}" >> "$CREW_PREFIX"/etc/env.d/00-library
export LD_LIBRARY_PATH="${CREW_PREFIX}/lib${LIB_SUFFIX}:/lib${LIB_SUFFIX}"

echo "export CREW_PREFIX=${CREW_PREFIX}" >> "${CREW_PREFIX}/etc/env.d/profile"

# Install activesupport gem for ruby
echo_info 'Installing essential ruby gems.'
gem update -N --system
gem install -N activesupport --conservative
gem install -N concurrent-ruby --conservative

# Since we downloaded the package repo, just update package compatibility information.
crew update compatible

echo_info "Installing core Chromebrew packages...\n"
yes | crew install core

echo_info "\nRunning Bootstrap package postinstall scripts...\n"
# Due to a bug in crew where it accepts spaces in package files names rather than
# splitting strings at spaces, we cannot quote ${BOOTSTRAP_PACKAGES}.
# shellcheck disable=SC2086
crew postinstall ${BOOTSTRAP_PACKAGES}

if ! "${CREW_PREFIX}"/bin/git version &> /dev/null; then
  echo_error "\nGit is broken on your system, and crew update will not work properly."
  echo_error "Please report this here:"
  echo_error "https://github.com/chromebrew/chromebrew/issues\n\n"
else
  echo_info "Synchronizng local package repo..."

  cd "${CREW_LIB_PATH}"

  # Make the git default branch error messages go away.
  git config --global init.defaultBranch main

  # Setup the folder with git information.
  git init
  git remote add origin "https://github.com/${OWNER}/${REPO}"

  # Checkout, overwriting local files.
  git fetch --all
  git checkout -f "${BRANCH}"

  # Set sparse-checkout folders.
  git sparse-checkout set packages "manifest/${ARCH}" lib commands bin crew tests tools
  git reset --hard origin/"${BRANCH}"

  # Set mtimes of files to when the file was committed.
  git-restore-mtime -sq 2>/dev/null
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

echo_intra "
Edit ${CREW_PREFIX}/etc/env.d/03-pager to change the default PAGER.
most is used by default
You may wish to edit the ${CREW_PREFIX}/etc/env.d/02-editor file for an editor default.
Chromebrew provides nano, vim and emacs as default TUI editor options."

echo_success "Chromebrew installed successfully and package lists updated."
