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

GREEN='\e[1;32m';
RED='\e[1;31m';
BLUE='\e[1;34m';
YELLOW='\e[1;33m';
RESET='\e[0m'

if [ "${EUID}" == "0" ]; then
  echo -e "${RED}Chromebrew should not be installed or run as root.${RESET}"
  exit 1;
fi

case "${ARCH}" in
"i686"|"x86_64"|"armv7l"|"aarch64")
  LIB_SUFFIX=
  [ "${ARCH}" == "x86_64" ] && LIB_SUFFIX='64'
  ;;
*)
  echo -e "${RED}Your device is not supported by Chromebrew yet :/${RESET}"
  exit 1;;
esac

# This will allow things to work without sudo
sudo chown -R "$(id -u)":"$(id -g)" "${CREW_PREFIX}"
# Delete 'var' symlink on Cloudready platform
if [[ $(grep neverware /etc/lsb-release) != "" ]]; then
  sudo unlink /usr/local/var
  sudo unlink /usr/local/local
fi

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
"armv7l"|"aarch64")
  if ! type "xz" > /dev/null; then
    urls+=('https://github.com/snailium/chrome-cross/releases/download/v1.8.1/xz-5.2.3-chromeos-armv7l.tar.gz')
    sha256s+=('4dc9f086ee7613ab0145ec0ed5ac804c80c620c92f515cb62bae8d3c508cbfe7')
  fi
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/gcc10-10.2.1-0f64-chromeos-armv7l.tar.xz')
  sha256s+=('dc0760c6fc123a48a72a6f5492f56d2be4273c29be3dfce6e7b202521c659365')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.8-chromeos-armv7l.tar.xz')
  sha256s+=('636a5bb46059311e280f1828aa032e2d2bad83905b124549159b73e279856688')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/c_ares-1.15.0-chromeos-armv7l.tar.xz')
  sha256s+=('fb85ed9ab22dc4ba7533b67365b56d9ee666580472898432adf3d27d2a20fe3e')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libcyrussasl-2.1.27-1-chromeos-armv7l.tar.xz')
  sha256s+=('281ac03fa4841ff2bd2395e960a9803791fac3ccfa0bf70ec7b8f79088c25817')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-3-chromeos-armv7l.tar.xz')
  sha256s+=('653edc555a8a094bcee3bbd3ee8b4a88200c4f4e285df132bdaff4e3af6088cb')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libidn2-2.3.0-chromeos-armv7l.tar.xz')
  sha256s+=('7614e912f8122d6a2a3b779f4c16f0e74029dd1213ea9d38ed7b6ee6d19f3de6')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libmetalink-0.1.3-1-chromeos-armv7l.tar.xz')
  sha256s+=('25b93f3304ee1cf1a06c582de5c053436322b08fb27a576d132130bf73ef436b')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libnghttp2-1.38.0-chromeos-armv7l.tar.xz')
  sha256s+=('7375e44ec6c77c7afc760eaa4310d9974e0640cb46053c330b32c0e87bee73f4')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libpsl-0.20.2-chromeos-armv7l.tar.xz')
  sha256s+=('f6dab3749e5e195e417775c03870738aef36454f5124e59708c70a006b417b9c')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.9.0-1-chromeos-armv7l.tar.xz')
  sha256s+=('da6c1206dbf05ca327afb69311f4938ec09c2d2552edc1f12b78fa5048550bff')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libtirpc-1.0.2-0-chromeos-armv7l.tar.xz')
  sha256s+=('f2af84d80968a7b7271d7ed00e9fa771157530a237282c9c0cea0eea39fea167')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libunistring-0.9.10-chromeos-armv7l.tar.xz')
  sha256s+=('bd3254d74558de91f176d933d0e4c71eb34b82e245abfbbce9fbee675e89e6fc')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.55-chromeos-armv7l.tar.xz')
  sha256s+=('74dc2829acce8fdcbe7311e891cce3289023a78bca8989bec31af67094d9108b')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-c5f04a58f-chromeos-armv7l.tar.xz')
  sha256s+=('9e8f50f34f570d8bd6fb161fd96dc4c3384259e07eeebf03cc975b4eb9d21306')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/zstd-1.4.7-chromeos-armv7l.tar.xz')
  sha256s+=('4a917969893ff2d985aa498d989219b2c569dd01ff1b198d3e6bd2a770b7d34c')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.2-20201205-chromeos-armv7l.tar.xz')
  sha256s+=('780763658f32364cdc24bef4fb8efcb14d2beba989c7c0a894bf73f3e4fccc9b')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ruby-3.0.0-chromeos-armv7l.tar.xz')
  sha256s+=('81509c5d3585f1a0c3c7d616d9f9a0d0192c6e3276c3ddea23c3905e78e56bfc')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libressl-3.2.3-chromeos-armv7l.tar.xz')
  sha256s+=('59a8e3c3cf6bd97210f04882c2b0ce94566311f360536d1174d7e04e8f9884ab')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/openssl-1.1.1i-chromeos-armv7l.tar.xz')
  sha256s+=('c3033ec7b37b5d451f528df4361a348a3dde750d71a131551039bed8880b5bb0')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/curl-7.74.0-1-chromeos-armv7l.tar.xz')
  sha256s+=('f54a7ff2c3521535af5873b061d26514005e3e080e5b444888e25dce95981201')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/git-2.30.0-chromeos-armv7l.tar.xz')
  sha256s+=('530242b602699db7a4f649c47ec44e81586128629b24b3e7fb7e1a9f877e8353')
  ;;
"i686")
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/gcc10-10.2.1-0f64-chromeos-i686.tar.xz')
  sha256s+=('52850f19acb5c7def3b7116a5873a5c68c4f9a7fa254b5198deacff36f1e15aa')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.8-chromeos-i686.tar.xz')
  sha256s+=('c16396d2d9a4a000b360fd6f096e4f0053abafb7bf1f8c84766527ea7a4b074f')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/c_ares-1.15.0-chromeos-i686.tar.xz')
  sha256s+=('00ea353730432d9b86c9ddbe05774c2fdcc13dd3cc820c31871410b6d43178f1')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libcyrussasl-2.1.27-1-chromeos-i686.tar.xz')
  sha256s+=('dbce3fbbf6efedd4c9266c14163022ca9a1da22386f55eeffe6074c341a5bac0')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-3-chromeos-i686.tar.xz')
  sha256s+=('2000fe80a1a2c85c117c0375a8826a3e0a9c7cb5353398847d5e04154c989f19')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libidn2-2.3.0-chromeos-i686.tar.xz')
  sha256s+=('eed21b95d8c8d236acfc87e40cf6aa605a6ceb6894b2c0f331e8955e2897a617')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libmetalink-0.1.3-1-chromeos-i686.tar.xz')
  sha256s+=('d10d7a95750b93be70f457d6c5db8935e30f85a726bf154d2953d075bd28d216')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libnghttp2-1.38.0-chromeos-i686.tar.xz')
  sha256s+=('cc5a56e8d3731aab1f8ff2a983e42d147e5a7234206d961e39b69d24d7cc3ffd')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libpsl-0.20.2-chromeos-i686.tar.xz')
  sha256s+=('51e81940423ac5bf3de3a931f697d1b0962a74be326f7cf0685f0328d97b7dab')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.9.0-1-chromeos-i686.tar.xz')
  sha256s+=('aaf97c46b8e2f4fdd5b603e27735898d1aa166d20ee79387b0040f6160c12ba6')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libtirpc-1.0.2-0-chromeos-i686.tar.xz')
  sha256s+=('3f484468cba8c5e69bff19eaa5c326dbb7e2e44d7e41c1c7ce3f570d0a7eb526')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libunistring-0.9.10-chromeos-i686.tar.xz')
  sha256s+=('88cb3cbfdf6c108045cf63d5aa70b2d036fceacc93f0ead76858381db4268c76')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.55-chromeos-i686.tar.xz')
  sha256s+=('9015aa6b9ac67d7ad468ca39785a178a53a4aa71542b09529ab0708541086ecf')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-c5f04a58f-chromeos-i686.tar.xz')
  sha256s+=('3f28349cce85d7cc73208f7bd921543baea29dd1994e068ecf3597119b761a18')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/zstd-1.4.7-chromeos-i686.tar.xz')
  sha256s+=('192b17e599990e94d2d8343095c90be85e0013fe92c8933c6795c51f8ba39d89')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.2-20201205-chromeos-i686.tar.xz')
  sha256s+=('3119323613fefd0c8c4d6f0ec6d55d2ae3ec6390aeb19eb01ca47bff4903322f')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ruby-3.0.0-chromeos-i686.tar.xz')
  sha256s+=('6a624ec30b5b6f32a842ec9f686278ce239d729f9736bf1b5d74ac08a716e0ef')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libressl-3.2.3-chromeos-i686.tar.xz')
  sha256s+=('d6962728e73894df3382ad17035b838f213f246edb6dc4aa54522c3bc5c59dd8')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/openssl-1.1.1i-chromeos-i686.tar.xz')
  sha256s+=('a1435f3a49db9dd3f07f3558cfffdbb0f724b15b1dba430ce3ad028b5d861366')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/curl-7.74.0-1-chromeos-i686.tar.xz')
  sha256s+=('ba7b7abeda8592135d2ea851f906636716b1f1d577fdcc75ad68bd6f0b67e5e0')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/git-2.30.0-chromeos-i686.tar.xz')
  sha256s+=('fa19e5276870d4347259daf6b8c4c001eafdaabb0c02b7846014558cf6ca90a5')
  ;;
"x86_64")
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/gcc10-10.2.1-0f64-chromeos-x86_64.tar.xz')
  sha256s+=('438ae78481cbbfcc38c6d917498f6b6f0681627a798b263bb9b8ef222ee38b35')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.8-chromeos-x86_64.tar.xz')
  sha256s+=('921fc1be57c195176d500f82bf96a52566824e62036c329ced629a0177c7c9d1')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/c_ares-1.15.0-chromeos-x86_64.tar.xz')
  sha256s+=('6587740ad61b5d0a74973235d6e6c01a4e6ea1f5510ee8103ff6e1d2ad045b41')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libcyrussasl-2.1.27-1-chromeos-x86_64.tar.xz')
  sha256s+=('46241ea5cf5e0181649e91edb183128669d5ab5bc13a938493ba1158a5189743')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-3-chromeos-x86_64.tar.xz')
  sha256s+=('52e602f63df955c451b36ff0b204331ed5c336d384f6484b2f7d5ef7a43f2a6d')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libidn2-2.3.0-chromeos-x86_64.tar.xz')
  sha256s+=('06c9f3803f02ce792550a39a1de3253b74ca6622b2543f843727f31dc4aa0f46')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libmetalink-0.1.3-1-chromeos-x86_64.tar.xz')
  sha256s+=('6e1e4b07e44e4b8cf1c436a6594f333bf339803c4c04a6c5a4f1762e00409479')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libnghttp2-1.38.0-chromeos-x86_64.tar.xz')
  sha256s+=('32428353d0b390ca68f1737ebaead7e5cd5ade1676c7d62896de0553bd58fa39')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libpsl-0.20.2-chromeos-x86_64.tar.xz')
  sha256s+=('f7f422c26f3d5b3cf690a6f9db6245f32ec7700d1db8e2b33eac212ca00c422e')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.9.0-1-chromeos-x86_64.tar.xz')
  sha256s+=('658605c62a5444a0665b4ef72f3d705512c4ca72a58505e40fbe1718db3ed7bd')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libtirpc-1.0.2-0-chromeos-x86_64.tar.xz')
  sha256s+=('6d4a7b558189ac4b78c24f6d5aa5904ed2dfe960ff3a6b1a4019294e2c051fc7')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libunistring-0.9.10-chromeos-x86_64.tar.xz')
  sha256s+=('d0fccb9b680e38517ce95483fcbac289ba835aa79e5c106bc21ec8de7872a13b')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.55-chromeos-x86_64.tar.xz')
  sha256s+=('9a98e25d5591422be9810c8fc61a58914dacaca6a99bee842ed2347a3364ca57')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-c5f04a58f-chromeos-x86_64.tar.xz')
  sha256s+=('015f35c6556f9fa4100093e0cb44581ad0725a25391b301ce8972e5a090c8cec')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/zstd-1.4.7-chromeos-x86_64.tar.xz')
  sha256s+=('017e2d9e5fa613bb50385f6b49bb9642f7b3e6f10453e46b89ea3e4701a39ae7')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.2-20201205-chromeos-x86_64.tar.xz')
  sha256s+=('d342c29d70e7bb4405555954ee376ff72782b419025b673ee750fe7d0c9efa1f')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ruby-3.0.0-chromeos-x86_64.tar.xz')
  sha256s+=('64ab9f4df6ab0185f7f74a0deb6a809d5ba910128f730522f21079062985108f')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libressl-3.2.3-chromeos-x86_64.tar.xz')
  sha256s+=('be499bd46626d26ed6c333dc1a74df423537053e6afbf2a14e542c5ceec796ef')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/openssl-1.1.1i-chromeos-x86_64.tar.xz')
  sha256s+=('52a43bc84d243218a2bf98c8895b1e366887a7e5308e711a3145ffe7879fe9e0')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/curl-7.74.0-1-chromeos-x86_64.tar.xz')
  sha256s+=('7696a5014d09eaff0864ee36fe4a7f8032c99e7eeb56baf0e04a87427e0114c6')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/git-2.30.0-chromeos-x86_64.tar.xz')
  sha256s+=('70adb89d9f1e1a250cc84f0e1b3e98d7ed5c82ceb413f4ae451ef9cd748b9398')
  ;;
esac

# functions to maintain packages
function download_check () {
    cd "${CREW_BREW_DIR}"

    #download
    echo -e "${BLUE}Downloading ${1}...${RESET}"
    curl '-#' -C - -L --ssl "${2}" -o "${3}"

    #verify
    echo -e "${BLUE}Verifying ${1}...${RESET}"
    echo -e "${GREEN}$(echo "${4}" "${3}" | sha256sum -c -)${RESET}"
    case "${?}" in
    0) ;;
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
  echo -e "${YELLOW}Creating new device.json...${RESET}"
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
  echo -e "${YELLOW}
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
${RESET}"
echo -e "${GREEN}Chromebrew installed successfully and package lists updated.${RESET}"
