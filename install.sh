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
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/gcc8-8.2.0-chromeos-armv7l.tar.xz')
  sha256s+=('536323fc5dd35e53665a19e65c636f288153efe4cdf31617c32103c64593b285')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.3-chromeos-armv7l.tar.xz')
  sha256s+=('5e485a0320b298e1f5c4ff50d98c6fe6d06ad9a38d9119d580a8b469418e1e6a')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.15-chromeos-armv7l.tar.xz')
  sha256s+=('047163a67f3ea9e143b465087d5ea4a3d17b963c8ad3579bc27a21934d4a17ab')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/git-2.20.1-chromeos-armv7l.tar.xz')
  sha256s+=('149a43937a9be2a8af9ebc1ab9b14fb90ff361acf1c9641959fa1c6731f842a7')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.8.0-chromeos-armv7l.tar.xz')
  sha256s+=('6fa84296583273dd9e749a2c54cb1cf688a7dab032e2528de5944a4d9777f037')
  ;;
"armv7l")
  if ! type "xz" > /dev/null; then
    urls+=('https://dl.bintray.com/chromebrew/chromebrew/xzutils-5.2.3-2-chromeos-armv7l.tar.xz')
    sha256s+=('839ead7097adee016986a9992d8cf8f4c91554ade2b6e111f7d0379c595be366')
  fi
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/gcc8-8.2.0-chromeos-armv7l.tar.xz')
  sha256s+=('536323fc5dd35e53665a19e65c636f288153efe4cdf31617c32103c64593b285')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.3-chromeos-armv7l.tar.xz')
  sha256s+=('5e485a0320b298e1f5c4ff50d98c6fe6d06ad9a38d9119d580a8b469418e1e6a')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.15-chromeos-armv7l.tar.xz')
  sha256s+=('047163a67f3ea9e143b465087d5ea4a3d17b963c8ad3579bc27a21934d4a17ab')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/git-2.20.1-chromeos-armv7l.tar.xz')
  sha256s+=('149a43937a9be2a8af9ebc1ab9b14fb90ff361acf1c9641959fa1c6731f842a7')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.8.0-chromeos-armv7l.tar.xz')
  sha256s+=('6fa84296583273dd9e749a2c54cb1cf688a7dab032e2528de5944a4d9777f037')
  ;;
"i686")
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/gcc8-8.2.0-chromeos-i686.tar.xz')
  sha256s+=('e37ca8d49198beaa9ba582fc25fa598ab3cd5ed7e46f96a03176fb9002cc6f7b')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.3-chromeos-i686.tar.xz')
  sha256s+=('6f4a5b96c31ef5ee4f09ac15da4c7a4a9d838ed5233038136ead1e155d17f342')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.15-chromeos-i686.tar.xz')
  sha256s+=('28de005b59407d5343775296814e10272c53aedd860e0208f396cc873045c095')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/git-2.20.1-chromeos-i686.tar.xz')
  sha256s+=('c1dc78e8f51c3ccba54fc6791b05e40002d85eeb7c1b011b0f456e53a64f9fa5')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.8.0-chromeos-i686.tar.xz')
  sha256s+=('771b2d30a49dd691db8456f773da404753d368f3c31d03c682c552ea0b5eb65e')
  ;;
"x86_64")
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/gcc8-8.2.0-chromeos-x86_64.tar.xz')
  sha256s+=('6d982f3c35acd3a738e176a3f3b8c4ea093c7be86882153a7711841cf0c80737')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.3-chromeos-x86_64.tar.xz')
  sha256s+=('352b78fc883cf8936136991fda9ca5d49e90b2951626158d6af8ef4b58d67f97')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.15-chromeos-x86_64.tar.xz')
  sha256s+=('8689ee2b4acc0440df6eec9eb0fb19aa8393b68bd64517cbca65d98041a2c7cc')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/git-2.20.1-chromeos-x86_64.tar.xz')
  sha256s+=('316842c20bf24202c794eb9c21e46d14bb95069d3667dc5d32e5058bdcdebd89')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.8.0-chromeos-x86_64.tar.xz')
  sha256s+=('6e026450389021c6267a9cc79b8722d15f48e2f8d812d5212501f686b4368e3c')
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
