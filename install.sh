#!/bin/bash
CREW_INSTALLER_VERSION=2025122701
# Exit on fail.
set -eE

RESET='\e[0m'

# Simplify colors and print errors to stderr (2).
echo_error() { echo -e "\e[1;91m${*}${RESET}" >&2; } # Use Light Red for errors.
echo_info() { echo -e "\e[1;33m${*}${RESET}" >&1; } # Use Yellow for informational messages.
echo_info_stderr() { echo -e "\e[1;35m${*}${RESET}" >&2; } # Use Magenta for informational messages to STDERR.
echo_success() { echo -e "\e[1;32m${*}${RESET}" >&1; } # Use Green for success messages.
echo_warn() { echo -e "\e[0;33m${*}${RESET}" >&1; } # Use Orange for warning messages.
echo_intra() { echo -e "\e[1;34m${*}${RESET}" >&1; } # Use Blue for intrafunction messages.
echo_out() { echo -e "\e[0;37m${*}${RESET}" >&1; } # Use Gray for program output.

set -a
# Default chromebrew environment variable values.
: "${OWNER:=chromebrew}"
: "${REPO:=chromebrew}}"
: "${BRANCH:=master}"
: "${CREW_BRANCH:=${BRANCH}}"
: "${CREW_REPO:=https://github.com/${OWNER}/${REPO}.git}"
: "${CREW_PREFIX:=/usr/local}"
: "${CREW_CACHE_DIR:=$CREW_PREFIX/tmp/packages}"
# For container usage, where we want to specify i686 arch
# on a x86_64 host by setting ARCH=i686.
: "${ARCH:=$(uname -m)}"
: "${CREW_PY_VER:=3.14}"
set +a

# Check if the script is being run in the VT-2 Developer Console.
if [[ "${ARCH}" != "i686" && "${TERM}" == "xterm" ]]; then
  echo_error "Chromebrew should not be installed in the VT-2 Developer Console."
  echo_info "\nPlease return to bash shell initiated from crosh and try again."
  echo_info "To exit the VT-2 Developer Console, press Ctrl + Alt + <- (left arrow)"
  exit 1
fi

# Print a message before exit on error
# shellcheck disable=SC2064
set_trap() { trap "echo_error 'An error occured during the installation using Chromebrew installer ${CREW_INSTALLER_VERSION} :/'" ERR; }
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

# Add proper support for parsing /etc/lsb-release
# Reference: https://www.chromium.org/chromium-os/developer-library/reference/infrastructure/lsb-release/
lsbval() {
  local key="$1"
  local lsbfile="${2:-/etc/lsb-release}"

  if ! echo "${key}" | /bin/grep -Eq '^[a-zA-Z0-9_]+$'; then
    return 1
  fi

  /bin/sed -E -n -e \
    "/^[[:space:]]*${key}[[:space:]]*=/{
      s:^[^=]+=[[:space:]]*::
      s:[[:space:]]+$::
      p
    }" "${lsbfile}"
}

# Reject non-stable Chrome OS channels.
if [ -f /etc/lsb-release ]; then
  if [[ ! "$(lsbval CHROMEOS_RELEASE_TRACK)" =~ [ltc|stable]-channel && "${CREW_FORCE_INSTALL}" != '1' ]]; then
    echo_error "The beta, dev, and canary channel are unsupported by Chromebrew."
    echo_info "Run 'CREW_FORCE_INSTALL=1 bash <(curl -Ls git.io/vddgY) && . ~/.bashrc' to perform install anyway."
    exit 1
  fi
  CHROMEOS_RELEASE_CHROME_MILESTONE="$(lsbval CHROMEOS_RELEASE_CHROME_MILESTONE)"
else
  echo_info "Unable to detect system information, installation will continue."
fi

this_installer=$(basename "$0")
case "${this_installer}" in
  63)
    # We are being piped in. Assume we are being piped in from curl
    # and echo the current installer date from github.
    echo_info "Current Chromebrew Installer is from $(curl -s "https://api.github.com/repos/chromebrew/chromebrew/commits?path=install.sh&page=1&per_page=1" | jq -r '.[0].commit.committer.date')"
    ;;
  install.sh)
    # The installer was manually downloaded or we are in a container
    # image install.
    echo_info "Current Chromebrew Installer is from $(curl -s "https://api.github.com/repos/chromebrew/chromebrew/commits?path=install.sh&page=1&per_page=1" | jq -r '.[0].commit.committer.date')"
    echo_info "Installer ${this_installer} last modified at: $(stat -c %y "$0")"
    ;;
  *)
    echo_info "Installer ${this_installer} last modified at: $(stat -c %y "$0")"
esac

# Check if the user owns the CREW_PREFIX directory and prompt to fix if not.
if [ -n "$(/usr/bin/find ${CREW_PREFIX} ! -user $(id -u) -printf '%u')" ]; then
  CREW_USER=$(/usr/bin/whoami)
  echo_error "\nUnable to install due to some files or subdirectories not owned by ${CREW_USER} in ${CREW_PREFIX}."
  echo_info "\nPlease enter the VT-2 Developer Console and execute the following:"
  echo_intra "/bin/bash <(curl -L https://raw.githubusercontent.com/chromebrew/chromebrew/master/restore.sh)"
  echo_info "\nand then return to this bash session and try again."
  echo_warn "\nNOTICE: This will remove ALL files and subdirectories in ${CREW_PREFIX} which is recommended to install Chromebrew."
  echo_info "\nTo start the VT-2 Developer Console, press Ctrl + Alt + -> (right arrow)"
  echo_info "To exit the VT-2 Developer Console, press Ctrl + Alt + <- (left arrow)"
  exit 1
fi

# Make sure installation directory is clean.
if [ -d "${CREW_PREFIX}" ]; then
  if [ "$(ls -A "${CREW_PREFIX}")" ]; then
    echo_error "\nThe Chromebrew installation directory ${CREW_PREFIX} is not empty."
    echo_warn "\nIf you proceed, ALL files and subdirectories will be removed in ${CREW_PREFIX}!"
    read -n 1 -p "Continue? [y/N]: " response
    case "${response}" in
      y|Y)
        echo_intra "\nRemoving all files and subdirectories in ${CREW_PREFIX}..."
        /usr/bin/find "${CREW_PREFIX}" -mindepth 1 -delete
        ;;
      *)
        echo_intra "\nInstallation canceled."
        exit 1
        ;;
    esac
  fi
else
  /bin/mkdir -p "${CREW_PREFIX}"
fi

# Do not redundantly use sudo if the user already owns the directory.
#if [ "$(stat -c '%u' "${CREW_PREFIX}")" != "$(id -u)" ]; then
#  # This will allow things to work without sudo.
#  sudo chown "$(id -u)":"$(id -g)" "${CREW_PREFIX}"
#fi

# Chromebrew directories.
CREW_LIB_PATH="${CREW_PREFIX}/lib/crew"
CREW_CONFIG_PATH="${CREW_PREFIX}/etc/crew"
CREW_META_PATH="${CREW_CONFIG_PATH}/meta"
CREW_BREW_DIR="${CREW_PREFIX}/tmp/crew"
CREW_DEST_DIR="${CREW_BREW_DIR}/dest"

if [ -n "${CREW_CACHE_ENABLED}" ]; then
  echo_intra "Verifying setup of ${CREW_CACHE_DIR} since CREW_CACHE_ENABLED is set..."
  mkdir -p "${CREW_CACHE_DIR}"
  #sudo chown -R "$(id -u)":"$(id -g)" "${CREW_CACHE_DIR}" || true
fi

# Set LD_LIBRARY_PATH.
CREW_LIB_SUFFIX=''
SYSTEM_LIB_SUFFIX=''
if [[ "$ARCH" == "x86_64" ]]; then
  CREW_LIB_SUFFIX='64'
  SYSTEM_LIB_SUFFIX='64'
fi
export LD_LIBRARY_PATH="${CREW_PREFIX}/lib${CREW_LIB_SUFFIX}:/usr/lib${CREW_LIB_SUFFIX}:/lib${CREW_LIB_SUFFIX}"

# For container usage, when we are emulating armv7l via linux32, where uname -m will report armv8l.
# Additionally, if the architecture is aarch64, set it to armv7l, as we treat as if it was armv7l.
# When we have proper support for aarch64, remove this.
PREFIX_CMD=''
if [[ "${ARCH}" = "armv8l" ]] || [[ "${ARCH}" = "aarch64" ]]; then
  echo_info "Setting ARCH to armv7l."
  ARCH='armv7l'
  [ -f ./dockerenv ] && PREFIX_CMD="linux32 env LD_LIBRARY_PATH=${LD_LIBRARY_PATH}"
fi

if [ -f ./dockerenv ] && [[ "${ARCH}" = "x86_64" ]] && [[ -f "/lib/ld-2.23.so" ]]; then
  echo_info "Setting ARCH to i686."
  ARCH='i686'
  # Set CREW_PRE_GLIBC_STANDALONE for i686.
  export CREW_PRE_GLIBC_STANDALONE=1
  echo "export CREW_PRE_GLIBC_STANDALONE=1" >> ~/.bashrc
  PREFIX_CMD="linux32 env LD_LIBRARY_PATH=${LD_LIBRARY_PATH}"
fi

PATCHELF_INTERPRETER="${CREW_PREFIX}/bin/ld.so"
case "${ARCH}" in
x86_64)
  PATCHELF_INTERPRETER="${CREW_PREFIX}/opt/glibc-libs/ld-linux-x86-64.so.2"
  ;;
aarch64|armv7l|armv8l)
  PATCHELF_INTERPRETER="${CREW_PREFIX}/opt/glibc-libs/ld-linux-armhf.so.3"
  ;;
esac

CREW_NPROC="$(nproc)"
export CREW_NPROC

# Warn users of the AMD segfault issue and allow them to work around it.
# The easiest way to distinguish StoneyRidge platorms is to check for the FMA4
# instruction, as it was first introduced in Bulldozer and later dropped in Zen.
if grep -s "fma4" /proc/cpuinfo ; then
  echo_warn "NOTICE: You are running an AMD StoneyRidge device; due to bugs some packages may fail with a segmentation fault and need to be rebuilt."
  echo_info "If this happens, please report them to https://github.com/chromebrew/chromebrew/issues."
  echo_info "If the install fails, try entering the VT-2 shell and execute the following:"
  # Otherwise one may get segfaults during install on stoneyridge devices.
  # See https://github.com/chromebrew/chromebrew/issues/8823
  echo_intra "\necho 0 | sudo tee /proc/sys/kernel/randomize_va_space"
  echo_info "\nand then return to this crosh session and try again."
  echo_info "\nTo start the VT-2 session, type Ctrl + Alt + ->"
  echo_info "To exit the VT-2 session, type Ctrl + Alt + <-"
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
  CURL_STATUS=
  if [[ -f "/usr/bin/curl" ]] && LD_LIBRARY_PATH=/usr/lib${SYSTEM_LIB_SUFFIX}:/lib${SYSTEM_LIB_SUFFIX} /usr/bin/curl --help &>/dev/null; then
    CURL_STATUS="system"
  elif [[ -x "${CREW_PREFIX}/bin/curl" ]] && "${CREW_PREFIX}"/bin/curl --help &>/dev/null; then
    CURL_STATUS="crew"
  elif [[ -f /usr/bin/curl ]] && env -u LD_LIBRARY_PATH /usr/bin/curl --help &>/dev/null; then
    CURL_STATUS="system"
  elif ! curl --help &>/dev/null; then
    CURL_STATUS="broken"
    DEBUG_OUT="CURL: ${CURL_STATUS}\nLD_LIBRARY_PATH ${LD_LIBRARY_PATH}"
    DEBUG_OUT+="$(ldd /usr/local/bin/curl)"
    echo_info_stderr "${DEBUG_OUT}"
    echo_error "curl is broken. Install will fail."
    exit 1
  else
    CURL_STATUS="unknown"
  fi
  [[ -z ${CURL_STATUS} ]] || echo_info_stderr "CURL: ${CURL_STATUS}"

  for (( i = 0; i < 4; i++ )); do
    if [[ "$CURL_STATUS" == "crew" ]]; then
      curl --ssl-reqd --tlsv1.2 -C - "${@}" && return 0
    elif [[ "$CURL_STATUS" == "system" ]]; then
      if [[ "$ARCH" == "i686" ]]; then
        # i686 system curl throws a "SSL certificate problem: self signed certificate in certificate chain" error.
        LD_LIBRARY_PATH=/usr/lib${SYSTEM_LIB_SUFFIX}:/lib${SYSTEM_LIB_SUFFIX} /usr/bin/curl -k "${@}" && return 0
      else
        LD_LIBRARY_PATH=/usr/lib${SYSTEM_LIB_SUFFIX}:/lib${SYSTEM_LIB_SUFFIX} /usr/bin/curl --ssl-reqd --tlsv1.2 -C - "${@}" && return 0
      fi
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
/usr/bin/find "${CREW_LIB_PATH}" -mindepth 1 -delete

echo_out 'Set up the local package repo...'

# Download the chromebrew repository.
curl_wrapper -L --progress-bar https://github.com/"${OWNER}"/"${REPO}"/tarball/"${BRANCH}" | tar -xz --strip-components=1 -C "${CREW_LIB_PATH}"

# Note that ordering of BOOTSTRAP_PACKAGES matters!
# ncurses, readline, and bash are needed before ruby because our ruby
# invokes the architecture specific bash instead of using /bin/sh.
if [[ -n "${CREW_PRE_GLIBC_STANDALONE}" ]]; then
  # Package version string may include LIBC_VERSION, but only on older
  # systems.
  LIBC_VERSION=$(/lib"${CREW_LIB_SUFFIX}"/libc.so.6 2>/dev/null | awk 'match($0, /Gentoo ([^-]+)/) {print substr($0, RSTART+7, RLENGTH-7)}')
  # Add the appropriate glibc stub package for these systems as
  # subsequent package installs may rely on it.
  BOOTSTRAP_PACKAGES='zlib zlib_ng'
  [[ "$ARCH" == "i686" ]] && BOOTSTRAP_PACKAGES+=' zstd_static glibc_build223'
  [[ "$LIBC_VERSION" == "2.27" ]] && BOOTSTRAP_PACKAGES+=' zstd_static glibc_build227'

  [[ -n "${PREFIX_CMD}" ]] && BOOTSTRAP_PACKAGES+=' util_linux'
  # Overwrite the glibc libcrypt.so.1.1.0 with the one from libxcrypt.
  BOOTSTRAP_PACKAGES+=' libxcrypt upx patchelf lz4 xzutils gcc_lib crew_mvdir ca_certificates libyaml openssl findutils ncurses readline psmisc'
else
  # Ruby wants gcc_lib, so install our version build against our glibc
  # first.
  # psmisc provides pstree which is used by crew
  # findutils provides find which is used by crew during installs.
  BOOTSTRAP_PACKAGES='zlib zlib_ng zstd_static glibc'
  # Get linux32 as early as possible.
  [[ -n "${PREFIX_CMD}" ]] && BOOTSTRAP_PACKAGES+=' util_linux'
  BOOTSTRAP_PACKAGES+=' libxcrypt upx patchelf lz4 xzutils crew_mvdir ncurses readline gcc_lib ca_certificates libyaml openssl gmp findutils psmisc'
  [[ "${ARCH}" == 'i686' ]] || BOOTSTRAP_PACKAGES+=' uutils_coreutils'
fi

if [[ -n "${CHROMEOS_RELEASE_CHROME_MILESTONE}" ]]; then
  # Recent Arm systems have a cut down system.
  # Tar breaks during install on multiarch systems.
  (( "${CHROMEOS_RELEASE_CHROME_MILESTONE}" > "112" )) && [[ "${ARCH}" == "armv7l" ]] && BOOTSTRAP_PACKAGES+=' bzip2 attr acl tar'
fi
# Add git dependencies except curl to BOOTSTRAP_PACKAGES.
BOOTSTRAP_PACKAGES+=' pcre2 expat git'

# Add curl dependencies to BOOTSTRAP_PACKAGES since curl is a git
# dependency, installing curl last so we don't break the system curl.
BOOTSTRAP_PACKAGES+=' brotli c_ares libcyrussasl libidn2 libnghttp2 libnghttp3 libngtcp2 libpsl libssh libunistring openldap curl zstd ruby'

if [[ -n "${CHROMEOS_RELEASE_CHROME_MILESTONE}" ]] && [[ -n "${CREW_PRE_GLIBC_STANDALONE}" ]]; then
  # shellcheck disable=SC2231
  for i in /lib${CREW_LIB_SUFFIX}/libc.so*
  do
    cp "$i" "$CREW_PREFIX/lib${CREW_LIB_SUFFIX}/"
    libcname=$(basename "$i")
    #sudo chown chronos "$CREW_PREFIX/lib${CREW_LIB_SUFFIX}/${libcname}"
    #sudo chmod 644 "$CREW_PREFIX/lib${CREW_LIB_SUFFIX}/${libcname}"
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
      if echo "${4}" "$CREW_CACHE_DIR/${3}" | sha256sum -c -; then
        echo_success "Verification of cached ${1} succeeded."
        ln -sf "$CREW_CACHE_DIR/${3}" "$CREW_BREW_DIR/${3}" || true
        return 0
      else
        echo_error "Verification of cached $CREW_CACHE_DIR/${3} failed with sha256 ${4}, downloading."
      fi
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
  /bin/rm -rf "${CREW_DEST_DIR}"
  /bin/mkdir "${CREW_DEST_DIR}"
  cd "${CREW_DEST_DIR}"
  XZ_STATUS=
  if [[ -f /usr/bin/xz ]] && env -u LD_LIBRARY_PATH /usr/bin/xz --help &>/dev/null; then
    XZ_STATUS="system"
  elif ! xz --help &>/dev/null; then
    XZ_STATUS="broken"
  fi
  ZSTD_STATUS=
  ZSTD=
  if [[ -x "${CREW_PREFIX}/bin/zstd-static" ]] && "${CREW_PREFIX}"/bin/zstd-static --help &>/dev/null; then
    ZSTD_STATUS="crew"
    ZSTD="${CREW_PREFIX}/bin/zstd-static"
  elif [[ -f /usr/bin/zstd ]] && env -u LD_LIBRARY_PATH /usr/bin/zstd --help &>/dev/null; then
    ZSTD_STATUS="system"
    ZSTD="/usr/bin/zstd"
  elif ! zstd --help &>/dev/null; then
    ZSTD_STATUS="broken"
  fi

  [[ -z ${XZ_STATUS} ]] || echo_info_stderr "XZ: ${XZ_STATUS}"
  [[ -z ${ZSTD_STATUS} ]] || echo_info_stderr "ZSTD: ${ZSTD_STATUS}"
  # Extract and install.
  echo_intra "Extracting ${1} ..."
  if [[ "${2##*.}" == "xz" ]]; then
    if [[ -z $XZ_STATUS ]]; then
      /bin/tar xpf ../"${2}"
    elif [[ $XZ_STATUS == 'system' ]]; then
      LD_LIBRARY_PATH=/usr/lib${SYSTEM_LIB_SUFFIX}:/lib${SYSTEM_LIB_SUFFIX} /bin/tar -I /usr/bin/xz -xpf ../"${2}"
    elif [[ $XZ_STATUS == 'broken' ]] && [[ -z $ZSTD_STATUS ]] && zstd --help 2>/dev/null| grep -q lzma; then
      /bin/tar -I "${ZSTD}" -xpf ../"${2}"
    elif [[ $XZ_STATUS == 'broken' ]] && [[ $ZSTD_STATUS == 'broken' ]]; then
      echo_error "xz and zstd are broken. Install will fail." && exit 1
    elif [[ $XZ_STATUS == 'broken' ]] && [[ $ZSTD_STATUS == 'system' ]]; then
      env -u LD_LIBRARY_PATH tar -I "${ZSTD}" -xpf ../"${2}"
    fi
  fi
  if [[ "${2##*.}" == "zst" ]]; then
    if [[ -z $ZSTD_STATUS ]] && tar --usage | grep -q zstd ; then
      /bin/tar xpf ../"${2}"
    elif [[ $ZSTD_STATUS == 'system' ]]; then
      LD_LIBRARY_PATH=/usr/lib${SYSTEM_LIB_SUFFIX}:/lib${SYSTEM_LIB_SUFFIX} /bin/tar -I "${ZSTD}" -xpf ../"${2}"
    elif [[ $ZSTD_STATUS == 'crew' ]]; then
      /bin/tar -I "${ZSTD}" -xpf ../"${2}"
    elif [[ $ZSTD_STATUS == 'broken' ]]; then
      DEBUG_OUT="ZSTD: ${ZSTD_STATUS}\nLD_LIBRARY_PATH ${LD_LIBRARY_PATH}"
      DEBUG_OUT+="$(ldd "$ZSTD")"
      echo_info_stderr "${DEBUG_OUT}"
      echo_error "zstd is broken. Install will fail."
      exit 1
    else
      /bin/tar -I zstd -xpf ../"${2}"
    fi
  fi

  echo_intra "Installing ${1}..."
  /bin/tar cpf - ./*/* | (cd /; /bin/tar xp --keep-directory-symlink -m -f -)

  if [[ "${1}" == 'glibc' ]] || [[ "${1}" == 'crew_preload' ]]; then
    # Update ld.so cache.
    if [[ "$ARCH" == "i686" ]] || [[ "$ARCH" == "armv7l" ]]; then
      ("${CREW_PREFIX}/bin/ldconfig" | tee /tmp/crew_ldconfig) || true
    else
     "${CREW_PREFIX}/bin/ldconfig" || true
    fi
    #[[ -d /usr/local/opt/glibc-libs ]] && export LD_PRELOAD=crew-preload.so
  else
    # Decompress binaries.
    if command -v upx &> /dev/null; then
      echo_intra "Running upx on ${1}..."
      /bin/grep "${CREW_PREFIX}/\(bin\|lib\|lib${CREW_LIB_SUFFIX}\)" < filelist | xargs -P "$(nproc)" -n1 upx -qq -d 2> /dev/null || true
    fi
    # Switch to our glibc for existing binaries if needed.
    #if [[ -d /usr/local/opt/glibc-libs ]]; then
    #  if command -v patchelf &> /dev/null; then
    #    echo_intra "Running patchelf on ${1}..."
    #    grep '/usr/local/bin' < filelist | xargs -P "$(nproc)" -n1 patchelf --set-interpreter "${PATCHELF_INTERPRETER}" 2> /dev/null || true
    #  fi
    #fi
  fi

  /bin/mv ./dlist "${CREW_META_PATH}/${1}.directorylist"
  /bin/mv ./filelist "${CREW_META_PATH}/${1}.filelist"
}

function get_pkg_version () {
  /bin/grep "\ \ version" "${1}" | head -n 1 | /bin/sed "s/#{LIBC_VERSION}/$LIBC_VERSION/g" | /bin/sed "s/#{@gcc_libc_version}/$LIBC_VERSION/g" | /bin/sed "s/#{CREW_PY_VER}/py$CREW_PY_VER/g"| /bin/sed "s/#{CREW_RUBY_VER}/$CREW_RUBY_VER/g"| awk '{print substr($2,2,length($2)-2)}'
}

function update_device_json () {
  cd "${CREW_CONFIG_PATH}"
  echo_intra "Adding new information on ${1} ${2} to device.json..."
  new_info=$(jq --arg name "$1" --arg version "$2" --arg sha256 "$3" '.installed_packages |= . + [{"name": $name, "version": $version, "sha256": $sha256}]' device.json)
  /bin/cat <<< "${new_info}" > device.json
}

function install_ruby_gem () {
  for gem in "$@"; do
    if gem search --local -q --no-versions --no-details -e "${gem//_/-}" | grep -q "${gem//_/-}" ;then
      ruby_gem="${gem//_/-}"
    else
      ruby_gem="${gem}"
    fi
    echo_intra "Installing ${ruby_gem^} gem..."
    gem_file="/usr/local/lib/crew/packages/ruby_${ruby_gem//-/_}.rb"

    curdir=$(pwd)
    if grep -q gem_compile_needed "${gem_file}"; then
      cd "$CREW_BREW_DIR"
      version=$(get_pkg_version "${gem_file}")
      url="https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_${gem}/${version}_${ARCH}/ruby_${gem}-${version}-chromeos-${ARCH}.gem"
      sha256=$(/bin/sed -n "s/.*${ARCH}: '\([^']*\)'.*/\1/p" "${gem_file}")
      gemfile=$(basename "${url}")
      if download_check "ruby_${gem}" "${url}" "${gemfile}" "${sha256}" '1'; then
        gem install --no-update-sources -N --local "ruby_${gem}-${version}-chromeos-${ARCH}.gem" --conservative
      fi
    else
      gem install -N "${ruby_gem}" --conservative
    fi
    cd "$curdir"
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
if [[ "${ARCH}" == "armv7l" ]] && [[ -d "/lib64" ]]; then
  # Handle arm multarch.
  export LD_LIBRARY_PATH="$CREW_PREFIX/lib64:/usr/lib64:/lib64:$CREW_PREFIX/lib${CREW_LIB_SUFFIX}:/usr/lib${CREW_LIB_SUFFIX}:/lib${CREW_LIB_SUFFIX}"
else
  export LD_LIBRARY_PATH="${CREW_PREFIX}/lib${CREW_LIB_SUFFIX}:/usr/lib${CREW_LIB_SUFFIX}:/lib${CREW_LIB_SUFFIX}"
fi
echo -e "# Generated by install.sh\nLD_LIBRARY_PATH=$LD_LIBRARY_PATH" >> "$CREW_PREFIX"/etc/env.d/00-library

# Extract, install and register packages.
for package in $BOOTSTRAP_PACKAGES; do
  cd "${CREW_LIB_PATH}/packages"
  version=$(get_pkg_version "${CREW_LIB_PATH}"/packages/"${package}".rb)
  binary_compression=$(/bin/sed -n "s/.*binary_compression '\([^']*\)'.*/\1/p" "${package}.rb")
  if [[ -z "$binary_compression" ]]; then
    binary_compression='tar.zst'
  fi

  url="https://gitlab.com/api/v4/projects/26210301/packages/generic/${package}/${version}_${ARCH}/${package}-${version}-chromeos-${ARCH}.${binary_compression}"
  tarfile=$(basename "${url}")

  sha256=$(/bin/sed -n "s/.*${ARCH}: '\([^']*\)'.*/\1/p" "${package}.rb")
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
if [[ -n "${CREW_PRE_GLIBC_STANDALONE}" ]] && { [[ "$ARCH" == "i686" ]] || [[ "$ARCH" == "armv7l" ]]; }; then
  "${CREW_PREFIX}/bin/ldconfig" &> /tmp/crew_ldconfig || true
fi

echo_out "\nCreating symlink to 'crew' in ${CREW_PREFIX}/bin/"
/bin/ln -sfv "../lib/crew/bin/crew" "${CREW_PREFIX}/bin/"

echo "export CREW_PREFIX=${CREW_PREFIX}" >> "${CREW_PREFIX}/etc/env.d/profile"

CREW_RUBY_VER="ruby$(ruby -e 'puts RUBY_VERSION.slice(/(?:.*(?=\.))/)')"
#echo_info 'Updating RubyGems...'
#${PREFIX_CMD} gem sources -u
# Avoid repl_type_completor, which pulls in the rbs gem, which needs a build.
# shellcheck disable=SC2016
#${PREFIX_CMD} gem outdated | cut -d " " -f 1 | /bin/grep -v repl_type_completor | xargs -I % /bin/bash -c 'export pkg=% ; /bin/grep -q no_compile_needed /usr/local/lib/crew/packages/ruby_${pkg//-/_}.rb && (echo "Updating % gem" ; gem update % --no-update-sources -N) || echo "Not updating % gem, since it needs a gem compile and buildessential has not been installed yet."'

# Mark packages as installed for pre-installed gems.
mapfile -t installed_gems < <(gem list | awk -F ' \(' '{print $1, $2}' | /bin/sed -e 's/default://' -e 's/)//' -e 's/,//' | awk '{print $1, $2}')
for i in "${!installed_gems[@]}"; do
  j="${installed_gems[$i]}"
  gem_package="${j% *}"
  crew_gem_package="ruby_${gem_package//-/_}"
  gem_version="${j#* }"
  gem contents "${gem_package}" > "${CREW_META_PATH}/${crew_gem_package}.filelist"
  update_device_json "ruby_${gem_package//-/_}" "${gem_version}-${CREW_RUBY_VER}" ""
done

echo_info "Installing essential ruby gems...\n"
BOOTSTRAP_GEMS='base64 connection_pool concurrent-ruby drb i18n logger minitest securerandom tzinfo highline ptools openssl rbs'
# shellcheck disable=SC2086
install_ruby_gem ${BOOTSTRAP_GEMS}

# Git needs to be working since crew invokes it in lib/const.rb.
if ! git --version; then
  DEBUG_OUT="GIT: broken\nLD_LIBRARY_PATH ${LD_LIBRARY_PATH}\n"
  DEBUG_OUT+=$(ldd "$(which git)")
  echo_info_stderr "${DEBUG_OUT}"
  echo_error "git is broken. Install will fail."
  exit 1
fi
# This is needed for SSL env variables to be populated so ruby doesn't
# complain about missing certs, resulting in failed https connections.
echo_info "Installing crew_profile_base...\n"
yes | ${PREFIX_CMD} crew install crew_profile_base

# shellcheck disable=SC1090
trap - ERR && source ~/.bashrc && set_trap
echo_info "Installing core Chromebrew packages...\n"
yes | ${PREFIX_CMD} crew install core || (yes | ${PREFIX_CMD} crew install core)

echo_info "\nRunning Bootstrap package postinstall scripts...\n"
# Due to a bug in crew where it accepts spaces in package files names rather than
# splitting strings at spaces, we cannot quote ${BOOTSTRAP_PACKAGES}.
# shellcheck disable=SC2086
for i in ${BOOTSTRAP_PACKAGES}
do
  echo_info "Doing postinstall for $i"
  ${PREFIX_CMD} crew postinstall $i || echo_error "Postinstall for $i failed."
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

  echo_info "Cleaning up older ruby gem versions...\n"
  gem cleanup

  export CREW_BRANCH CREW_REPO
  # shellcheck disable=SC2015
  (${PREFIX_CMD} crew update && yes | ${PREFIX_CMD} crew upgrade) || (${PREFIX_CMD} crew update && (yes | ${PREFIX_CMD} crew upgrade) || true)
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
echo_intra "Please run 'source ~/.bashrc'"
