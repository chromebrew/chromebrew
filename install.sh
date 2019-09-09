#!/bin/bash

# exit on fail
set -e

#chromebrew directories
OWNER="skycocker"
REPO="chromebrew"
BRANCH="master"
URL="https://raw.githubusercontent.com/${OWNER}/${REPO}/${BRANCH}"
CREW_PREFIX="${CREW_PREFIX:-/usr/local}"
CREW_LIB_PATH="${CREW_PREFIX}/lib/crew/"
CREW_CONFIG_PATH="${CREW_PREFIX}/etc/crew/"
CREW_BREW_DIR="${CREW_PREFIX}/tmp/crew/"
CREW_DEST_DIR="${CREW_BREW_DIR}/dest"
CREW_PACKAGES_PATH="${CREW_LIB_PATH}/packages"

ARCH="$(uname -m)"

if [ "${EUID}" == "0" ]; then
  echo 'Chromebrew should not be installed or run as root.'
  exit 1;
fi

case "${ARCH}" in
"i686"|"x86_64"|"armv7l"|"aarch64")
  LIB_SUFFIX=
  [ "${ARCH}" == "x86_64" ] && LIB_SUFFIX='64'
  ;;
*)
  echo 'Your device is not supported by Chromebrew yet.'
  exit 1;;
esac

# This will allow things to work without sudo
sudo chown -R "$(id -u)":"$(id -g)" "${CREW_PREFIX}"

# prepare directories
for dir in "${CREW_CONFIG_PATH}/meta" "${CREW_DEST_DIR}" "${CREW_PACKAGES_PATH}"; do
  if [ ! -d "${dir}" ]; then
    mkdir -p "${dir}"
  fi
done

# prepare url and sha256
# install only gcc8, ruby, libiconv, git and libssh2 (order matters)
urls=()
sha256s=()
case "${ARCH}" in
"aarch64")
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/gcc8-8.3.0-chromeos-armv7l.tar.xz')
  sha256s+=('fbd8a589befb3d10400af6e4975d02a6940bab4907628f8fc0d6913ea89f70ae')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.3-chromeos-armv7l.tar.xz')
  sha256s+=('5e485a0320b298e1f5c4ff50d98c6fe6d06ad9a38d9119d580a8b469418e1e6a')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.15-1-chromeos-armv7l.tar.xz')
  sha256s+=('cfa05a46d37d49479047f205e3d4ab2a8c11f953ed91e11465a1195ff2d95d01')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/git-2.23.0-chromeos-armv7l.tar.xz')
  sha256s+=('b89d3e83fe9c797c69b4ec90c6f88004270437fbdd4fd378a6a31d66ee7cb276')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.8.1-chromeos-armv7l.tar.xz')
  sha256s+=('d8fae766d77818ef95ae8a993bda0c03730d773cfb8392ceaaf6c8697206409c')
  ;;
"armv7l")
  if ! type "xz" > /dev/null; then
    urls+=('https://github.com/snailium/chrome-cross/releases/download/v1.8.1/xz-5.2.3-chromeos-armv7l.tar.gz')
    sha256s+=('4dc9f086ee7613ab0145ec0ed5ac804c80c620c92f515cb62bae8d3c508cbfe7')
  fi
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/gcc8-8.3.0-chromeos-armv7l.tar.xz')
  sha256s+=('fbd8a589befb3d10400af6e4975d02a6940bab4907628f8fc0d6913ea89f70ae')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.3-chromeos-armv7l.tar.xz')
  sha256s+=('5e485a0320b298e1f5c4ff50d98c6fe6d06ad9a38d9119d580a8b469418e1e6a')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.15-1-chromeos-armv7l.tar.xz')
  sha256s+=('cfa05a46d37d49479047f205e3d4ab2a8c11f953ed91e11465a1195ff2d95d01')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/git-2.23.0-chromeos-armv7l.tar.xz')
  sha256s+=('b89d3e83fe9c797c69b4ec90c6f88004270437fbdd4fd378a6a31d66ee7cb276')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.8.1-chromeos-armv7l.tar.xz')
  sha256s+=('d8fae766d77818ef95ae8a993bda0c03730d773cfb8392ceaaf6c8697206409c')
  ;;
"i686")
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/gcc8-8.3.0-chromeos-i686.tar.xz')
  sha256s+=('4d625e92969fde16c1a92601740e22c07331f8056452edf7cf0bf2c1c88aa152')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.3-chromeos-i686.tar.xz')
  sha256s+=('6f4a5b96c31ef5ee4f09ac15da4c7a4a9d838ed5233038136ead1e155d17f342')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.15-1-chromeos-i686.tar.xz')
  sha256s+=('b080cd1e667dd9efba1a4392c7c177f5b8292f1b6fc29e862634b7ad41d29ab5')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/git-2.23.0-chromeos-i686.tar.xz')
  sha256s+=('b02bb5d57315a2c620ecf177ac19fdadf03139136d7bc864e86b08d26e08472b')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.8.1-chromeos-i686.tar.xz')
  sha256s+=('ccdea94d6dcc0bdd27b364cd99f53e9aba6f90f0b8272a5f3856bf2a9a32beb6')
  ;;
"x86_64")
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/gcc8-8.3.0-chromeos-x86_64.tar.xz')
  sha256s+=('ae8c8c33e4090f7fdbd39b2364754dcfc5f6bdd9a74062fde3eeb6272562f48b')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.3-chromeos-x86_64.tar.xz')
  sha256s+=('352b78fc883cf8936136991fda9ca5d49e90b2951626158d6af8ef4b58d67f97')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.15-1-chromeos-x86_64.tar.xz')
  sha256s+=('7ac97b03fff5d1befecb26ac471daa239c2c23ab1bc774a5366e6c46d1bb9ad3')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/git-2.23.0-chromeos-x86_64.tar.xz')
  sha256s+=('a67df6819289a4acb87e07c9f84300c1856c9116691318bf440cab7f8eb044e6')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.8.1-chromeos-x86_64.tar.xz')
  sha256s+=('1025b413f30c5ac27bfa340e41cb437bf19311e72b95030f64020e25be4cda31')
  ;;
esac

# functions to maintain packages
function download_check () {
    cd "${CREW_BREW_DIR}"

    #download
    echo "Downloading ${1}..."
    curl --progress-bar -C - -L --ssl "${2}" -o "${3}"

    #verify
    echo "Verifying ${1}..."
    echo "${4}" "${3}" | sha256sum -c -
    case "${?}" in
    0) ;;
    *)
      echo "Verification failed, something may be wrong with the download."
      exit 1;;
    esac
}

function extract_install () {
    # Start with a clean slate
    rm -rf "${CREW_DEST_DIR}"
    mkdir "${CREW_DEST_DIR}"
    cd "${CREW_DEST_DIR}"

    #extract and install
    echo "Extracting ${1} (this may take a while)..."
    tar xpf ../"${2}"
    echo "Installing ${1} (this may take a while)..."
    tar cpf - ./*/* | (cd /; tar xp --keep-directory-symlink -f -)
    mv ./dlist "${CREW_CONFIG_PATH}/meta/${1}.directorylist"
    mv ./filelist "${CREW_CONFIG_PATH}/meta/${1}.filelist"
}

function update_device_json () {
  cd "${CREW_CONFIG_PATH}"

  if grep '"name": "'"${1}"'"' device.json > /dev/null; then
    echo "Updating version number of ${1} in device.json..."
    sed -i device.json -e '/"name": "'"${1}"'"/N;//s/"version": ".*"/"version": "'"${2}"'"/'
  elif grep '^    }$' device.json > /dev/null; then
    echo "Adding new information on ${1} to device.json..."
    sed -i device.json -e '/^    }$/s/$/,\
    {\
      "name": "'"${1}"'",\
      "version": "'"${2}"'"\
    }/'
  else
    echo "Adding new information on ${1} to device.json..."
    sed -i device.json -e '/^  "installed_packages": \[$/s/$/\
    {\
      "name": "'"${1}"'",\
      "version": "'"${2}"'"\
    }/'
  fi
}

# create the device.json file if it doesn't exist
cd "${CREW_CONFIG_PATH}"
if [ ! -f device.json ]; then
  echo "Creating new device.json..."
  echo '{' > device.json
  echo '  "architecture": "'"${ARCH}"'",' >> device.json
  echo '  "installed_packages": [' >> device.json
  echo '  ]' >> device.json
  echo '}' >> device.json
fi

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

# workaround https://github.com/skycocker/chromebrew/issues/3305
sudo ldconfig > /dev/null 2> /dev/null || true

# create symlink to 'crew' in ${CREW_PREFIX}/bin/
rm -f "${CREW_PREFIX}/bin/crew"
ln -s "../lib/crew/crew" "${CREW_PREFIX}/bin/"

# prepare sparse checkout .rb packages directory and do it
cd "${CREW_LIB_PATH}"
rm -rf .git
git init
git remote add -f origin "https://github.com/${OWNER}/${REPO}.git"
git config core.sparsecheckout true
echo packages >> .git/info/sparse-checkout
echo lib >> .git/info/sparse-checkout
echo crew >> .git/info/sparse-checkout
git fetch origin "${BRANCH}"
git reset --hard origin/"${BRANCH}"

# install a base set of essential packages
yes | crew install buildessential less most

echo
if [[ "${CREW_PREFIX}" != "/usr/local" ]]; then
  echo "Since you have installed Chromebrew in a directory other than '/usr/local',"
  echo "you need to run these commands to complete your installation:"
  echo "echo 'export CREW_PREFIX=${CREW_PREFIX}' >> ~/.bashrc"
  echo "echo 'export PATH=\"\${CREW_PREFIX}/bin:\${CREW_PREFIX}/sbin:\${PATH}\"' >> ~/.bashrc"
  echo "echo 'export LD_LIBRARY_PATH=${CREW_PREFIX}/lib${LIB_SUFFIX}' >> ~/.bashrc"
  echo 'source ~/.bashrc'
  echo
fi
echo "To set the default PAGER environment variable to use less:"
echo "echo \"export PAGER='less'\" >> ~/.bashrc && . ~/.bashrc"
echo
echo "Alternatively, you could use most.  Why settle for less, right?"
echo "echo \"export PAGER='most'\" >> ~/.bashrc && . ~/.bashrc"
echo
echo "Below are some text editor suggestions."
echo
echo "To install 'nano', execute:"
echo "crew install nano"
echo
echo "Or, to get an updated version of 'vim', execute:"
echo "crew install vim"
echo
echo "You may wish to set the EDITOR environment variable for an editor default."
echo
echo "For example, to set 'nano' as the default editor, execute:"
echo "echo \"export EDITOR='nano'\" >> ~/.bashrc && . ~/.bashrc"
echo
echo "To set 'vim' as the default editor, execute:"
echo "echo \"export EDITOR='vim'\" >> ~/.bashrc && . ~/.bashrc"
echo
echo "Chromebrew installed successfully and package lists updated."
