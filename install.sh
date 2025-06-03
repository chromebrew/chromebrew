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

# Add proper support for parsing /etc/lsb-release
# Reference: https://www.chromium.org/chromium-os/developer-library/reference/infrastructure/lsb-release/
lsbval() {
  local key="$1"
  local lsbfile="${2:-/etc/lsb-release}"

  if ! echo "${key}" | grep -Eq '^[a-zA-Z0-9_]+$'; then
    return 1
  fi

  sed -E -n -e \
    "/^[[:space:]]*${key}[[:space:]]*=/{
      s:^[^=]+=[[:space:]]*::
      s:[[:space:]]+$::
      p
    }" "${lsbfile}"
}

# Print a message before exit on error
set_trap() { trap "echo_error 'An error occured during the installation :/'" ERR; }
set_trap

# Check if the script is being run as root.
if [ "${EUID}" == "0" ]; then
  echo_error "Chromebrew should not be installed or run as root."
  echo_info "Please login as 'chronos' and restart the install."
  exit 1
fi

# Reject crostini.
if [[ -d /opt/google/cros-containers && "${CREW_FORCE_INSTALL}" != '1' ]]; then
  echo_error "Crostini containers are not supported by Chromebrew :/"
  echo_info "Run 'CREW_FORCE_INSTALL=1 bash <(curl -Ls git.io/vddgY) && . ~/.bashrc' to perform install anyway"
  exit 1
fi

# Reject non-stable Chrome OS channels.
if [ -f /etc/lsb-release ]; then
  if [[ ! "$(lsbval CHROMEOS_RELEASE_TRACK)" =~ stable-channel && "${CREW_FORCE_INSTALL}" != '1' ]]; then
    echo_error "The beta, dev, and canary channel are unsupported by Chromebrew."
    echo_info "Run 'CREW_FORCE_INSTALL=1 bash <(curl -Ls git.io/vddgY) && . ~/.bashrc' to perform install anyway."
    exit 1
  fi
  CHROMEOS_RELEASE_CHROME_MILESTONE="$(lsbval CHROMEOS_RELEASE_CHROME_MILESTONE)"
else
  echo_info "Unable to detect system information, installation will continue."
fi

# Default chromebrew repo values.
: "${OWNER:=chromebrew}"
: "${REPO:=chromebrew}}"
: "${BRANCH:=master}"

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

# Chromebrew directories.
CREW_LIB_PATH="${CREW_PREFIX}/lib/crew"
CREW_CONFIG_PATH="${CREW_PREFIX}/etc/crew"
CREW_META_PATH="${CREW_CONFIG_PATH}/meta"
CREW_BREW_DIR="${CREW_PREFIX}/tmp/crew"
CREW_DEST_DIR="${CREW_BREW_DIR}/dest"
: "${CREW_CACHE_DIR:=$CREW_PREFIX/tmp/packages}"

if [ -n "$CREW_CACHE_ENABLED" ]; then
  echo_intra "Verifying setup of ${CREW_CACHE_DIR} since CREW_CACHE_ENABLED is set..."
  mkdir -p "${CREW_CACHE_DIR}"
  sudo chown -R "$(id -u)":"$(id -g)" "${CREW_CACHE_DIR}" || true
fi

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
  CREW_LIB_SUFFIX='64'
fi

# Package version string may include LIBC_VERSION.
[[ $BRANCH == 'pre_glibc_standalone' ]] && LIBC_VERSION=$(/lib"${CREW_LIB_SUFFIX}"/libc.so.6 2>/dev/null | awk 'match($0, /Gentoo ([^-]+)/) {print substr($0, RSTART+7, RLENGTH-7)}')
: "${CREW_PY_VER:=3.13}"

# Warn users of the AMD segfault issue and allow them to work around it.
# The easiest way to distinguish StoneyRidge platorms is to check for the FMA4
# instruction, as it was first introduced in Bulldozer and later dropped in Zen.
if grep -s "fma4" /proc/cpuinfo ; then
  echo_info "Notice: You are running an AMD StoneyRidge device; due to some bugs some packages may fail with a segmentation fault and need to be rebuilt."
  echo_info "If this happens, please report them to: https://github.com/chromebrew/chromebrew/issues"
  echo_info "If the install fails, try running 'CREW_AMD_INSTALL=1 bash <(curl -Ls git.io/vddgY) && . ~/.bashrc'"
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
function curl_wrapper () {
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
crew_folders="bin cache doc docbook include lib/crew/packages lib${CREW_LIB_SUFFIX} libexec man sbin share var etc/crew/meta etc/env.d tmp/crew/dest"
# shellcheck disable=SC2086
# Quoting crew_folders leads to breakage.
(cd "${CREW_PREFIX}" && mkdir -p ${crew_folders})


# Remove old git config directories if they exist.
find "${CREW_LIB_PATH}" -mindepth 1 -delete

echo_out 'Set up the local package repo...'

# Download the chromebrew repository.
curl_wrapper -L --progress-bar https://github.com/"${OWNER}"/"${REPO}"/tarball/"${BRANCH}" | tar -xz --strip-components=1 -C "${CREW_LIB_PATH}"

# Note that ordering of BOOTSTRAP_PACKAGES matters!
if [[ $BRANCH == 'pre_glibc_standalone' ]]; then
  BOOTSTRAP_PACKAGES='zstd_static upx patchelf lz4 zlib xzutils zlib_ng gcc_lib crew_mvdir ruby pcre2 libnghttp2 git ca_certificates libyaml openssl findutils psmisc uutils_coreutils curl'
else
  # ncurses, readline, and bash are needed before ruby because our ruby
  # invokes the architecture specific bash instead of using /bin/sh, which
  # may be aarch64 when we are using an armv7l userspace. That wreaks
  # havoc with our LD_PRELOAD implementation.
  # ruby wants gcc_lib, so install our version build against our glibc
  # first.
  # psmisc provides pstree which is used by crew
  # findutils provides find which is used by crew during installs.
  BOOTSTRAP_PACKAGES='zstd_static glibc crew_preload libxcrypt upx patchelf lz4 zlib xzutils zlib_ng crew_mvdir ncurses readline bash gcc_lib ruby pcre2 libnghttp2 git ca_certificates libyaml openssl gmp findutils psmisc uutils_coreutils curl'
fi

if [[ -n "${CHROMEOS_RELEASE_CHROME_MILESTONE}" ]]; then
  # Recent Arm systems have a cut down system.
  (( "${CHROMEOS_RELEASE_CHROME_MILESTONE}" > "112" )) && [[ "${ARCH}" == "armv7l" ]] && BOOTSTRAP_PACKAGES+=' bzip2 pcre2'
fi

if [[ -n "${CHROMEOS_RELEASE_CHROME_MILESTONE}" ]] && [[ $BRANCH == 'pre_glibc_standalone' ]]; then
  # shellcheck disable=SC2231
  for i in /lib${CREW_LIB_SUFFIX}/libc.so*
  do
    sudo cp "$i" "$CREW_PREFIX/lib${CREW_LIB_SUFFIX}/"
    libcname=$(basename "$i")
    sudo chown chronos "$CREW_PREFIX/lib${CREW_LIB_SUFFIX}/${libcname}"
    sudo chmod 644 "$CREW_PREFIX/lib${CREW_LIB_SUFFIX}/${libcname}"
  done
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
    if [ -n "$CREW_CACHE_ENABLED" ]; then
      echo_intra "Looking for ${3} in ${CREW_CACHE_DIR}"
      if [[ -f "$CREW_CACHE_DIR/${3}" ]] ; then
        echo_info "$CREW_CACHE_DIR/${3} found."
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
      else
        echo_intra "$CREW_CACHE_DIR/${3} not found"
      fi
    fi
    # Download
    echo_intra "Downloading ${1}..."
    curl_wrapper '-#' -L "${2}" -o "${3}"

    # Verify
    echo_intra "Verifying ${1}..."
    if echo "${4}" "${3}" | sha256sum -c - ; then
      if [ -n "$CREW_CACHE_ENABLED" ] ; then
        cp "${3}" "$CREW_CACHE_DIR/${3}" || true
      fi
      echo_success "Verification of ${1} succeeded."
      return 0
    else
      if [[ ${5} -lt 2 ]]; then
        echo_error "Verification of ${1} failed, something may be wrong with the download."
        exit 1
      else
        echo_info "Verification of ${1} failed. Will try another sha256 hash if available."
        return 1
      fi
    fi
}

function extract_install () {
    # Start with a clean slate.
    rm -rf "${CREW_DEST_DIR}"
    mkdir "${CREW_DEST_DIR}"
    cd "${CREW_DEST_DIR}"
    XZ_STATUS=
    if ! xz --help &>/dev/null; then
      XZ_STATUS="broken"
    elif [[ -f /usr/bin/xz ]] && env -u LD_LIBRARY_PATH /usr/bin/xz --help &>/dev/null; then
      XZ_STATUS="system"
    fi
    ZSTD_STATUS=
    if ! zstd --help &>/dev/null; then
      ZSTD_STATUS="broken"
    elif [[ -f /usr/bin/zstd ]] && env -u LD_LIBRARY_PATH /usr/bin/zstd --help &>/dev/null; then
      ZSTD_STATUS="system"
    fi
    [[ -z ${XZ_STATUS} ]] || echo_info "XZ: ${XZ_STATUS}"
    [[ -z ${ZSTD_STATUS} ]] || echo_info "ZSTD: ${ZSTD_STATUS}"
    # Extract and install.
    echo_intra "Extracting ${1} ..."
    if [[ "${2##*.}" == "xz" ]]; then
      if [[ -z $XZ_STATUS ]]; then
        tar xpf ../"${2}"
      elif [[ $XZ_STATUS == 'system' ]]; then
       env -u LD_LIBRARY_PATH tar -I /usr/bin/xz -xpf ../"${2}"
      elif [[ $XZ_STATUS == 'broken' ]] && [[ -z $ZSTD_STATUS ]] && zstd --help 2>/dev/null| grep -q lzma; then
        tar -I zstd -xpf ../"${2}"
      elif [[ $XZ_STATUS == 'broken' ]] && [[ $ZSTD_STATUS == 'broken' ]]; then
        echo_error "xz and zstd are broken. Install will fail." && exit 1
      elif [[ $XZ_STATUS == 'broken' ]] && [[ $ZSTD_STATUS == 'system' ]]; then
        env -u LD_LIBRARY_PATH tar -I /usr/bin/zstd -xpf ../"${2}"
      fi
    fi
    if [[ "${2##*.}" == "zst" ]]; then
      if [[ -z $ZSTD_STATUS ]] && tar --usage | grep -q zstd ; then
        tar xpf ../"${2}"
      elif [[ $ZSTD_STATUS == 'system' ]]; then
        env -u LD_LIBRARY_PATH tar -I /usr/bin/zstd -xpf ../"${2}"
      elif [[ $ZSTD_STATUS == 'broken' ]]; then
        echo_error "zstd is broken. Install will fail."
        exit 1
      else
        tar -I zstd -xpf ../"${2}"
      fi
    fi

    echo_intra "Installing ${1}..."
    tar cpf - ./*/* | (cd /; tar xp --keep-directory-symlink -m -f -)

    if [[ "${1}" == 'glibc' ]] || [[ "${1}" == 'crew_preload' ]]; then
      # update ld.so cache
      "${CREW_PREFIX}/bin/ldconfig" || true
      [[ -d /usr/local/opt/glibc-libs ]] && export LD_PRELOAD=crew-preload.so
    elif [[ -d /usr/local/opt/glibc-libs ]]; then
      # decompress and switch to our glibc for existing binaries
      if command -v upx &> /dev/null; then
        echo_intra "Running upx on ${1}..."
        grep "/usr/local/\(bin\|lib\|lib${LIB_SUFFIX}\)" < filelist | xargs -P "$(nproc)" -n1 upx -qq -d 2> /dev/null || true
      fi

      if command -v patchelf &> /dev/null; then
        echo_intra "Running patchelf on ${1}..."
        grep '/usr/local/bin' < filelist | xargs -P "$(nproc)" -n1 patchelf --set-interpreter "${CREW_PREFIX}/bin/ld.so" 2> /dev/null || true
      fi
    fi

    mv ./dlist "${CREW_META_PATH}/${1}.directorylist"
    mv ./filelist "${CREW_META_PATH}/${1}.filelist"
}

function update_device_json () {
  cd "${CREW_CONFIG_PATH}"
  echo_intra "Adding new information on ${1} ${2} to device.json..."
  new_info=$(jq --arg name "$1" --arg version "$2" --arg sha256 "$3" '.installed_packages |= . + [{"name": $name, "version": $version, "sha256": $sha256}]' device.json)
  cat <<< "${new_info}" > device.json
}

function install_ruby_gem () {
  for gem in "$@"; do
    ruby_gem="${gem}"
    echo_intra "Installing ${ruby_gem^} gem..."
    gem install -N "${ruby_gem}" --conservative
    gem_version="$(ruby -e "gem('${ruby_gem}')" -e "puts Gem.loaded_specs['${ruby_gem}'].version.to_s")"
    json_gem_version="${gem_version}-${CREW_RUBY_VER}"
    crew_gem_package="ruby_${ruby_gem//-/_}"
    update_device_json "${crew_gem_package}" "${json_gem_version}" ""
    gem_filelist_path="${CREW_META_PATH}/${crew_gem_package}.filelist"
    echo_intra "Saving ${ruby_gem^} filelist..."
    gem contents "${ruby_gem}" > "${gem_filelist_path}"
    echo_success "${ruby_gem^} gem installed."
    BOOTSTRAP_PACKAGES+=" ${crew_gem_package}"
  done
}

echo_info "Downloading Bootstrap packages:\n${BOOTSTRAP_PACKAGES}"

# Set LD_LIBRARY_PATH so crew doesn't break on i686, xz doesn't fail on
# x86_64, and the mandb postinstall doesn't fail in newer arm
# containers.
if [[ "${ARCH}" == "armv7l" ]] ; then
  # Handle arm multarch.
  export LD_LIBRARY_PATH="$CREW_PREFIX/lib64:/usr/lib64:/lib64:$CREW_PREFIX/lib${LIB_SUFFIX}:/usr/lib${LIB_SUFFIX}:/lib${LIB_SUFFIX}"
else
  export LD_LIBRARY_PATH="${CREW_PREFIX}/lib${LIB_SUFFIX}:/usr/lib${LIB_SUFFIX}:/lib${LIB_SUFFIX}"
fi
echo -e "# Generated by install.sh\nLD_LIBRARY_PATH=$LD_LIBRARY_PATH" >> "$CREW_PREFIX"/etc/env.d/00-library

# Extract, install and register packages.
for package in $BOOTSTRAP_PACKAGES; do
  cd "${CREW_LIB_PATH}/packages"
  version=$(grep "\ \ version" "${package}.rb" | head -n 1 | sed "s/#{LIBC_VERSION}/$LIBC_VERSION/g" | sed "s/#{@gcc_libc_version}/$LIBC_VERSION/g" | sed "s/#{CREW_PY_VER}/py$CREW_PY_VER/g"| awk '{print substr($2,2,length($2)-2)}')
  binary_compression=$(sed -n "s/.*binary_compression '\([^']*\)'.*/\1/p" "${package}.rb")
  if [[ -z "$binary_compression" ]]; then
    binary_compression='tar.zst'
  fi

  url="https://gitlab.com/api/v4/projects/26210301/packages/generic/${package}/${version}_${ARCH}/${package}-${version}-chromeos-${ARCH}.${binary_compression}"
  tarfile=$(basename "${url}")

  sha256=$(sed -n "s/.*${ARCH}: '\([^']*\)'.*/\1/p" "${package}.rb")
  shacount=$(echo "$sha256" | wc -w)
  for sha in $sha256
  do
    if download_check "${package}" "${url}" "${tarfile}" "${sha}" "${shacount}"; then
      extract_install "${package}" "${tarfile}"
      update_device_json "${package}" "${version}" "${sha}"
    fi
  done
done

# Work around https://github.com/chromebrew/chromebrew/issues/3305.
# shellcheck disable=SC2024
"${CREW_PREFIX}/bin/ldconfig" &> /tmp/crew_ldconfig || true

echo_out "\nCreating symlink to 'crew' in ${CREW_PREFIX}/bin/"
ln -sfv "../lib/crew/bin/crew" "${CREW_PREFIX}/bin/"

echo "export CREW_PREFIX=${CREW_PREFIX}" >> "${CREW_PREFIX}/etc/env.d/profile"

echo_info 'Updating RubyGems...'
gem sources -u
gem update --no-update-sources -N --system

# Mark packages as installed for pre-installed gems.
mapfile -t installed_gems < <(gem list | awk -F ' \(' '{print $1, $2}' | sed -e 's/default://' -e 's/)//' -e 's/,//' | awk '{print $1, $2}')
CREW_RUBY_VER="ruby$(ruby -e 'puts RUBY_VERSION.slice(/(?:.*(?=\.))/)')"
for i in "${!installed_gems[@]}"
  do
   j="${installed_gems[$i]}"
   gem_package="${j% *}"
   crew_gem_package="ruby_${gem_package//-/_}"
   gem_version="${j#* }"
   gem contents "${gem_package}" > "${CREW_META_PATH}/${crew_gem_package}.filelist"
   update_device_json "ruby_${gem_package//-/_}" "${gem_version}-${CREW_RUBY_VER}" ""
done

echo_info "Installing essential ruby gems...\n"
BOOTSTRAP_GEMS='base64 bigdecimal connection_pool concurrent-ruby drb i18n logger minitest securerandom tzinfo activesupport highline ptools'
# shellcheck disable=SC2086
install_ruby_gem ${BOOTSTRAP_GEMS}

# This is needed for SSL env variables to be populated so ruby doesn't
# complain about missing certs, resulting in failed https connections.
echo_info "Installing crew_profile_base...\n"
yes | crew install crew_profile_base

# shellcheck disable=SC1090
trap - ERR && source ~/.bashrc && set_trap

echo_info "Installing core Chromebrew packages...\n"
yes | crew install core || (yes | crew install core) || (yes | crew install core)

echo_info "\nRunning Bootstrap package postinstall scripts...\n"
# Due to a bug in crew where it accepts spaces in package files names rather than
# splitting strings at spaces, we cannot quote ${BOOTSTRAP_PACKAGES}.
# shellcheck disable=SC2086
for i in ${BOOTSTRAP_PACKAGES}
do
  echo_info "Doing postinstall for $i"
  crew postinstall $i || echo_error "Postinstall for $i failed."
done

if ! "${CREW_PREFIX}"/bin/git version &> /dev/null; then
  echo_error "\nGit is broken on your system, and crew update will not work properly."
  echo_error "Please report this here:"
  echo_error "https://github.com/chromebrew/chromebrew/issues\n\n"
else
  echo_info "Synchronizing local package repo..."

  cd "${CREW_LIB_PATH}"

  # Make the git default branch error messages go away.
  git config --global init.defaultBranch main

  # Setup the folder with git information.
  git init --ref-format=reftable
  git remote add origin "https://github.com/${OWNER}/${REPO}"

  # Help handle situations where GitHub is down.
  git config --local http.lowSpeedLimit 1000
  git config --local http.lowSpeedTime 5

  # Checkout, overwriting local files.
  git fetch --all
  git checkout -f "${BRANCH}"

  # Set sparse-checkout folders.
  git sparse-checkout set packages "manifest/${ARCH}" lib commands bin crew tests tools
  git reset --hard origin/"${BRANCH}"

  # Set mtimes of files to when the file was committed.
  git-restore-mtime -sq 2>/dev/null

  CREW_REPO=https://github.com/${OWNER}/${REPO}.git CREW_BRANCH=${BRANCH} \
    crew update && \
    yes | crew upgrade

  echo_info "Cleaning up older ruby gem versions...\n"
  gem cleanup
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
