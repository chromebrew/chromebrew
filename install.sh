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
alias echo='echo -e'

if [ "${EUID}" == "0" ]; then
  echo "${RED}Chromebrew should not be installed or run as root."
  exit 1;
fi

case "${ARCH}" in
"i686"|"x86_64"|"armv7l"|"aarch64")
  LIB_SUFFIX=
  [ "${ARCH}" == "x86_64" ] && LIB_SUFFIX='64'
  ;;
*)
  echo "${RED}Your device is not supported by Chromebrew yet :/"
  exit 1;;
esac

# This will allow things to work without sudo
sudo chown -R "$(id -u)":"$(id -g)" "${CREW_PREFIX}"
# Delete 'var' symlink on Cloudready platform
if [[ $(grep neverware /etc/lsb-release) != "" ]]; then
  sudo rm -rf /usr/local/var
  sudo rm -rf /usr/local/local
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
"aarch64")
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/gcc10-10.2.0-chromeos-armv7l.tar.xz')
  sha256s+=('832a12c3db18537775d174c4188cf4bc14aeed72b243a1099e8f1715f6575dbc')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.8-chromeos-armv7l.tar.xz')
  sha256s+=('636a5bb46059311e280f1828aa032e2d2bad83905b124549159b73e279856688')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/c_ares-1.15.0-chromeos-armv7l.tar.xz')
  sha256s+=('fb85ed9ab22dc4ba7533b67365b56d9ee666580472898432adf3d27d2a20fe3e')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libcyrussasl-2.1.27-1-chromeos-armv7l.tar.xz')
  sha256s+=('281ac03fa4841ff2bd2395e960a9803791fac3ccfa0bf70ec7b8f79088c25817')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-3-chromeos-armv7l.tar.xz')
  sha256s+=('653edc555a8a094bcee3bbd3ee8b4a88200c4f4e285df132bdaff4e3af6088cb')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libidn2-2.0.5-chromeos-armv7l.tar.xz')
  sha256s+=('533ce10819b7a6e59302480c895d7da9f498a187218296c2debee09a85b7f87d')
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
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/zstd-1.4.5-chromeos-armv7l.tar.xz')
  sha256s+=('5cf9b496bf10ca56ab900bc0b2b82ed3e30493a1bbdc170a456ff73454531bfc')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ruby-2.7.2-chromeos-armv7l.tar.xz')
  sha256s+=('a435e6bf7965e1a82e8842e5ea66bdd670ec9b627d785bd720d3d2652fc89f6d')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/git-2.29.1-chromeos-armv7l.tar.xz')
  sha256s+=('34d1b4b333195d6aaf5856665dbd9a8b56152603e93fd85f36a1b9c69de8852a')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libressl-3.2.2-chromeos-armv7l.tar.xz')
  sha256s+=('36a493288d8d24cdb4c52866d37fcc47530417158717819443b4a087fd035d08')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/curl-7.74.0-chromeos-armv7l.tar.xz')
  sha256s+=('6c817cc8f2043982148a08713fd5439efc26e80f44788788b58bde6d5a86186c')
  ;;
"armv7l")
  if ! type "xz" > /dev/null; then
    urls+=('https://github.com/snailium/chrome-cross/releases/download/v1.8.1/xz-5.2.3-chromeos-armv7l.tar.gz')
    sha256s+=('4dc9f086ee7613ab0145ec0ed5ac804c80c620c92f515cb62bae8d3c508cbfe7')
  fi
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/gcc10-10.2.0-chromeos-armv7l.tar.xz')
  sha256s+=('832a12c3db18537775d174c4188cf4bc14aeed72b243a1099e8f1715f6575dbc')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.8-chromeos-armv7l.tar.xz')
  sha256s+=('636a5bb46059311e280f1828aa032e2d2bad83905b124549159b73e279856688')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/c_ares-1.15.0-chromeos-armv7l.tar.xz')
  sha256s+=('fb85ed9ab22dc4ba7533b67365b56d9ee666580472898432adf3d27d2a20fe3e')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libcyrussasl-2.1.27-1-chromeos-armv7l.tar.xz')
  sha256s+=('281ac03fa4841ff2bd2395e960a9803791fac3ccfa0bf70ec7b8f79088c25817')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-3-chromeos-armv7l.tar.xz')
  sha256s+=('653edc555a8a094bcee3bbd3ee8b4a88200c4f4e285df132bdaff4e3af6088cb')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libidn2-2.0.5-chromeos-armv7l.tar.xz')
  sha256s+=('533ce10819b7a6e59302480c895d7da9f498a187218296c2debee09a85b7f87d')
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
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/zstd-1.4.5-chromeos-armv7l.tar.xz')
  sha256s+=('5cf9b496bf10ca56ab900bc0b2b82ed3e30493a1bbdc170a456ff73454531bfc')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ruby-2.7.2-chromeos-armv7l.tar.xz')
  sha256s+=('a435e6bf7965e1a82e8842e5ea66bdd670ec9b627d785bd720d3d2652fc89f6d')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/git-2.29.1-chromeos-armv7l.tar.xz')
  sha256s+=('34d1b4b333195d6aaf5856665dbd9a8b56152603e93fd85f36a1b9c69de8852a')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libressl-3.2.2-chromeos-armv7l.tar.xz')
  sha256s+=('36a493288d8d24cdb4c52866d37fcc47530417158717819443b4a087fd035d08')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/curl-7.74.0-chromeos-armv7l.tar.xz')
  sha256s+=('6c817cc8f2043982148a08713fd5439efc26e80f44788788b58bde6d5a86186c')
  ;;
"i686")
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/gcc10-10.2.0-chromeos-i686.tar.xz')
  sha256s+=('c319f3a643f23b409fef6baffa91eea8afc43936d95ca467f0f26945cde6e5cf')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.8-chromeos-i686.tar.xz')
  sha256s+=('c16396d2d9a4a000b360fd6f096e4f0053abafb7bf1f8c84766527ea7a4b074f')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/c_ares-1.15.0-chromeos-i686.tar.xz')
  sha256s+=('00ea353730432d9b86c9ddbe05774c2fdcc13dd3cc820c31871410b6d43178f1')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libcyrussasl-2.1.27-1-chromeos-i686.tar.xz')
  sha256s+=('dbce3fbbf6efedd4c9266c14163022ca9a1da22386f55eeffe6074c341a5bac0')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-3-chromeos-i686.tar.xz')
  sha256s+=('2000fe80a1a2c85c117c0375a8826a3e0a9c7cb5353398847d5e04154c989f19')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libidn2-2.0.5-chromeos-i686.tar.xz')
  sha256s+=('d07969ea21a9f390afe961dcbb78f014c17cfd5bc3af6dbb4732e32004f61e6a')
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
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/zstd-1.4.5-chromeos-i686.tar.xz')
  sha256s+=('184413b92f95c5fad0ca8724f4fb231018c46f8b24b42d39a2f892f034548dc1')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ruby-2.7.2-chromeos-i686.tar.xz')
  sha256s+=('81865864d3ba93b6cbd5dc8e1b6cb51bd2ebe854f6c01e282c1b73f379fb7caf')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/git-2.29.1-chromeos-i686.tar.xz')
  sha256s+=('0246035512a9cd81206672ccb996b97a1252050e9473340278c324988ca90b6d')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libressl-3.2.2-chromeos-i686.tar.xz')
  sha256s+=('f900f8674e63a71e2206f8458d94c039e375af3be7027047818fd680fb78aa78')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/curl-7.74.0-chromeos-i686.tar.xz')
  sha256s+=('77b6af733566a22e9eb1187470190b9c48e2480dd13589efc452da589530630d')
  ;;
"x86_64")
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/gcc10-10.2.0-chromeos-x86_64.tar.xz')
  sha256s+=('fc3b15e4b499548131389f38b67cc4ab35e32a4fe9d21f96b108c7a3d20598de')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.8-chromeos-x86_64.tar.xz')
  sha256s+=('921fc1be57c195176d500f82bf96a52566824e62036c329ced629a0177c7c9d1')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/c_ares-1.15.0-chromeos-x86_64.tar.xz')
  sha256s+=('6587740ad61b5d0a74973235d6e6c01a4e6ea1f5510ee8103ff6e1d2ad045b41')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libcyrussasl-2.1.27-1-chromeos-x86_64.tar.xz')
  sha256s+=('46241ea5cf5e0181649e91edb183128669d5ab5bc13a938493ba1158a5189743')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-3-chromeos-x86_64.tar.xz')
  sha256s+=('52e602f63df955c451b36ff0b204331ed5c336d384f6484b2f7d5ef7a43f2a6d')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libidn2-2.0.5-chromeos-x86_64.tar.xz')
  sha256s+=('22b43990ca6ae415b9b7e206ed7d7b05df29b97411de55f33f11e834cf3b345c')
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
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/zstd-1.4.5-chromeos-x86_64.tar.xz')
  sha256s+=('a0fef2e2ed65835399ff8435bb806e74fe8b9e4e3019889a284bdd422fd1979a')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ruby-2.7.2-chromeos-x86_64.tar.xz')
  sha256s+=('658808516b7a2e58f8102fd131e765aaa79f2a7c906d0330b7e883fbdc12d1a9')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/git-2.29.1-chromeos-x86_64.tar.xz')
  sha256s+=('c86f8bfe92978f4b757dd78d02d8e29c65b54ffd00698f0227ce8793b1bc23c8')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libressl-3.2.2-chromeos-x86_64.tar.xz')
  sha256s+=('2995523debedf84f763b79fb73b7958656c6d8e1a20628220e4b3d45b3dfa25a')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/curl-7.74.0-chromeos-x86_64.tar.xz')
  sha256s+=('137ee2aadee4e1fad6a4f80b361bdbbb7181baea32cc0b8326aa693a1d3916d4')
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
      echo "${RED}Verification failed, something may be wrong with the download."
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
  echo "${BLUE}Creating new device.json..."
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
crew update

# install a base set of essential packages
yes | crew install buildessential less most

echo
if [[ "${CREW_PREFIX}" != "/usr/local" ]]; then
  echo "${YELLOW}Since you have installed Chromebrew in a directory other than '/usr/local',"
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
