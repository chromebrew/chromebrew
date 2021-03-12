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

EARLY_PACKAGES=(gcc10 libiconv libssh2 ncurses ruby openssl git)

ARCH="$(uname -m)"
BREW=🍺

function puts() {
  reset='\e[0m'
  
  case ${2} in
  lightred)
    colorize='\e[1;31m';;
  lightgreen)
    colorize='\e[1;32m';;
  yellow)
    colorize='\e[1;33m';;
  orange)
    colorize='\e[0;33m';;
  lightblue)
    colorize='\e[1;34m';;
  cyan)
    colorize='\e[0;36m';;
  *)
    colorize=${2};;
  esac
  
  case ${3} in
  cover)
    colorize=${colorize}'\e[1A\e[K';;
  covercurrent)
    colorize=${colorize}'\r';;
  printf);;
  *)
    reset=${reset}'\n';;
  esac
  
  printf "${colorize}${1}${reset}"
}

function rootchecker() {
  if [ ${EUID} == 0 ]; then
    puts 'Chromebrew should not be installed or run as root.' yellow
    puts "Trying to switch to user ${USER}..." yellow
    su chronos - <<< "$(curl -L# ${URL}/install.sh)" ||\
      (puts "Failed to switch to user chronos or installation failed" lightred; exit 1)
  fi
} && rootchecker

case "${ARCH}" in
"i686"|"x86_64"|"armv7l"|"aarch64")
  LIB_SUFFIX=
  [ "${ARCH}" == "x86_64" ] && LIB_SUFFIX='64'
  ;;
*)
  puts 'Your device is not supported by Chromebrew yet :/' lightred
  exit 1;;
esac

# This will allow things to work without sudo
crew_folders="bin cache doc docbook etc include lib lib$LIB_SUFFIX libexec man sbin share tmp var"
for folder in $crew_folders
do
  if [ -d "${CREW_PREFIX}"/"${folder}" ]; then 
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
for dir in "${CREW_CONFIG_PATH}/meta" "${CREW_DEST_DIR}" "${CREW_PACKAGES_PATH}"; do
  if [ ! -d "${dir}" ]; then
    mkdir -p "${dir}"
  fi
done

# prepare url and sha256
urls=()
temp_url=
sha256s=()
temp_sha256=
k=0

case "${ARCH}" in
"armv7l"|"aarch64")
  if ! type "xz" > /dev/null; then
    temp_url='https://github.com/snailium/chrome-cross/releases/download/v1.8.1/xz-5.2.3-chromeos-armv7l.tar.gz'
    temp_sha256='4dc9f086ee7613ab0145ec0ed5ac804c80c620c92f515cb62bae8d3c508cbfe7'
    urls+=("$temp_url")
    sha256s+=("$temp_sha256")
  fi
  ;;
esac

for package in ${EARLY_PACKAGES[@]}; do
  pkgfile="$(curl -Lsf "${URL}"/packages/"$package".rb)"
  temp_url="$(echo "$pkgfile" | grep -m 3 "$ARCH": | head -n 1 | cut -d\' -f2 | tr -d \' | tr -d \" | sed 's/,//g')"
  temp_sha256="$(echo "$pkgfile" | grep -m 3 "$ARCH": | tail -n 1 | cut -d\' -f2 | tr -d \' | tr -d \" | sed 's/,//g')"
  urls+=("$temp_url")
  sha256s+=("$temp_sha256")
done

# functions to maintain packages
function download_check () {
    cd "${CREW_BREW_DIR}"

    #download
    puts "=> Downloading ${1}..." lightblue
    puts "=> ${BREW} ${2}" cyan
    $CURL '-#' -C - -L --ssl "${2}" -o "${3}"
    puts ' └─> Archive download' lightgreen cover

    #verify
    loading "$(puts "=> Verifying ${1}...  " lightblue)"
    puts    "\n └─> $(echo ${4} ${3} | sha256sum -c)" lightgreen
    case "${?}" in
    0) ;;
    *)
      puts 'Verification failed, something may be wrong with the download.' lightred
      exit 1;;
    esac
}

function extract_install () {
    # Start with a clean slate
    rm -rf "${CREW_DEST_DIR}"
    mkdir "${CREW_DEST_DIR}"
    cd "${CREW_DEST_DIR}"

    #extract and install
    puts "=> Extracting ${1} (this may take a while)...  " lightblue
    start=$(date +%s)
    tar xpf ../"${2}"

    puts "=> Installing ${1} (this may take a while)...  " lightblue
    tar cpf - ./*/* | (cd /; tar xp --keep-directory-symlink -f -)
    mv ./dlist "${CREW_CONFIG_PATH}/meta/${1}.directorylist"
    mv ./filelist "${CREW_CONFIG_PATH}/meta/${1}.filelist"
    puts " └─> Installed in $(($(date +%s)-${start})) seconds" orange
}

function update_device_json () {
  cd "${CREW_CONFIG_PATH}"

  if grep '"name": "'"${1}"'"' device.json > /dev/null; then
    puts "=> Updating version number of ${1} in device.json..."
    sed -i device.json -e '/"name": "'"${1}"'"/N;//s/"version": ".*"/"version": "'"${2}"'"/'
  elif grep '^    }$' device.json > /dev/null; then
    puts "=> Adding new information on ${1} to device.json..."
    sed -i device.json -e '/^    }$/s/$/,\
    {\
      "name": "'"${1}"'",\
      "version": "'"${2}"'"\
    }/'
  else
    puts "=> Adding new information on ${1} to device.json..."
    sed -i device.json -e '/^  "installed_packages": \[$/s/$/\
    {\
      "name": "'"${1}"'",\
      "version": "'"${2}"'"\
    }/'
  fi
  puts
}

# create the device.json file if it doesn't exist
cd "${CREW_CONFIG_PATH}"
if [ ! -f device.json ]; then
  puts 'Creating new device.json...' yellow
  echo '{' > device.json
  echo '  "architecture": "'"${ARCH}"'",' >> device.json
  echo '  "installed_packages": [' >> device.json
  echo '  ]' >> device.json
  echo '}' >> device.json
fi

# extract, install and register packages
for i in ${!urls[@]}; do
  tarfile="$(basename ${url})"
  name="${tarfile%%-*}"   # extract string before first '-'
  rest="${tarfile#*-}"    # extract string after first '-'
  version="$(echo ${rest} | sed -e 's/-chromeos.*$//')"
                        # extract string between first '-' and "-chromeos"

  download_check "${name}" "${urls[${i}]}" "${tarfile}" "${sha256s[${i}]}"
  extract_install "${name}" "${tarfile}"
  update_device_json "${name}" "${version}"
done

## workaround https://github.com/skycocker/chromebrew/issues/3305
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
crew update

# install a base set of essential packages
yes | crew install buildessential less most

echo
if [[ "${CREW_PREFIX}" != "/usr/local" ]]; then
  puts "
Since you have installed Chromebrew in a directory other than '/usr/local',
you need to run these commands to complete your installation:
" yellow

  puts "
echo 'export CREW_PREFIX=${CREW_PREFIX}' >> ~/.bashrc
echo 'export PATH=\"\${CREW_PREFIX}/bin:\${CREW_PREFIX}/sbin:\${PATH}\"' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=${CREW_PREFIX}/lib${LIB_SUFFIX}' >> ~/.bashrc
source ~/.bashrc
" lightblue
fi
puts "
To set the default PAGER environment variable to use less:
echo \"export PAGER='less'\" >> ~/.bashrc && . ~/.bashrc

Alternatively, you could use most.  Why settle for less, right?
echo \"export PAGER='most'\" >> ~/.bashrc && . ~/.bashrc

Below are some text editor suggestions.

To install 'nano', execute:
crew install nano

Or, to get an updated version of 'vim', execute:
crew install vim

You may wish to set the EDITOR environment variable for an editor default.

For example, to set 'nano' as the default editor, execute:
echo \"export EDITOR='nano'\" >> ~/.bashrc && . ~/.bashrc

To set 'vim' as the default editor, execute:
echo \"export EDITOR='vim'\" >> ~/.bashrc && . ~/.bashrc
" lightblue
puts 'Chromebrew installed successfully and package lists updated.' lightgreen
