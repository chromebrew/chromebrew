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
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.8-chromeos-armv7l.tar.xz')
  sha256s+=('636a5bb46059311e280f1828aa032e2d2bad83905b124549159b73e279856688')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/c_ares-1.15.0-chromeos-armv7l.tar.xz')
  sha256s+=('fb85ed9ab22dc4ba7533b67365b56d9ee666580472898432adf3d27d2a20fe3e')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libcyrussasl-2.1.27-1-chromeos-armv7l.tar.xz')
  sha256s+=('281ac03fa4841ff2bd2395e960a9803791fac3ccfa0bf70ec7b8f79088c25817')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-chromeos-armv7l.tar.xz')
  sha256s+=('daee13f0eef96fb2d65a06d129f702cacbf8c70747d7f0dd2d27a9df977372b7')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libidn2-2.0.5-chromeos-armv7l.tar.xz')
  sha256s+=('533ce10819b7a6e59302480c895d7da9f498a187218296c2debee09a85b7f87d')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libmbedtls-2.16.8-chromeos-armv7l.tar.xz')
  sha256s+=('fa1207538c87a278987bd49aa789d9a064745eb17af6e0bca986cab290f7c8e4')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libmetalink-0.1.3-1-chromeos-armv7l.tar.xz')
  sha256s+=('25b93f3304ee1cf1a06c582de5c053436322b08fb27a576d132130bf73ef436b')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libnghttp2-1.38.0-chromeos-armv7l.tar.xz')
  sha256s+=('7375e44ec6c77c7afc760eaa4310d9974e0640cb46053c330b32c0e87bee73f4')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.9.0-chromeos-armv7l.tar.xz')
  sha256s+=('497e146e4d769aa85b0d547889784d7552e2aadbbaa448df5bbe9515cd94c182')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libtirpc-1.0.2-0-chromeos-armv7l.tar.xz')
  sha256s+=('f2af84d80968a7b7271d7ed00e9fa771157530a237282c9c0cea0eea39fea167')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libunistring-0.9.10-chromeos-armv7l.tar.xz')
  sha256s+=('bd3254d74558de91f176d933d0e4c71eb34b82e245abfbbce9fbee675e89e6fc')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.50-chromeos-armv7l.tar.xz')
  sha256s+=('0267ada9d7a13d09de9ca7503f1fe6623262de74dd364cb3998e6ae30d583808')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-c5f04a58-chromeos-armv7l.tar.xz')
  sha256s+=('31c1053a2ba5775de0ea099447af443bdcb8732a7851c581219c7bc9177cafe4')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ruby-2.7.2-chromeos-armv7l.tar.xz')
  sha256s+=('a435e6bf7965e1a82e8842e5ea66bdd670ec9b627d785bd720d3d2652fc89f6d')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/git-2.28.0-1-chromeos-armv7l.tar.xz')
  sha256s+=('f3a111e4f5ab2484b4eea1c32b68089256a7535b6ee9c495b45e776d3108c5e5')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/curl-7.72.0-1-chromeos-armv7l.tar.xz')
  sha256s+=('bf7579c54c6e06479f615d1abf87adf89fc39f3d2c404e2ab2cb95070ace6098')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libressl-3.1.4-chromeos-armv7l.tar.xz')
  sha256s+=('0b3da102fede122f12ec32a44cd3e543d72184cd90c9937f6fd32dea6d71c121')
  ;;
"armv7l")
  if ! type "xz" > /dev/null; then
    urls+=('https://github.com/snailium/chrome-cross/releases/download/v1.8.1/xz-5.2.3-chromeos-armv7l.tar.gz')
    sha256s+=('4dc9f086ee7613ab0145ec0ed5ac804c80c620c92f515cb62bae8d3c508cbfe7')
  fi
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/gcc8-8.3.0-chromeos-armv7l.tar.xz')
  sha256s+=('fbd8a589befb3d10400af6e4975d02a6940bab4907628f8fc0d6913ea89f70ae')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.8-chromeos-armv7l.tar.xz')
  sha256s+=('636a5bb46059311e280f1828aa032e2d2bad83905b124549159b73e279856688')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/c_ares-1.15.0-chromeos-armv7l.tar.xz')
  sha256s+=('fb85ed9ab22dc4ba7533b67365b56d9ee666580472898432adf3d27d2a20fe3e')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libcyrussasl-2.1.27-1-chromeos-armv7l.tar.xz')
  sha256s+=('281ac03fa4841ff2bd2395e960a9803791fac3ccfa0bf70ec7b8f79088c25817')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-chromeos-armv7l.tar.xz')
  sha256s+=('daee13f0eef96fb2d65a06d129f702cacbf8c70747d7f0dd2d27a9df977372b7')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libidn2-2.0.5-chromeos-armv7l.tar.xz')
  sha256s+=('533ce10819b7a6e59302480c895d7da9f498a187218296c2debee09a85b7f87d')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libmbedtls-2.16.8-chromeos-armv7l.tar.xz')
  sha256s+=('fa1207538c87a278987bd49aa789d9a064745eb17af6e0bca986cab290f7c8e4')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libmetalink-0.1.3-1-chromeos-armv7l.tar.xz')
  sha256s+=('25b93f3304ee1cf1a06c582de5c053436322b08fb27a576d132130bf73ef436b')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libnghttp2-1.38.0-chromeos-armv7l.tar.xz')
  sha256s+=('7375e44ec6c77c7afc760eaa4310d9974e0640cb46053c330b32c0e87bee73f4')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.9.0-chromeos-armv7l.tar.xz')
  sha256s+=('497e146e4d769aa85b0d547889784d7552e2aadbbaa448df5bbe9515cd94c182')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libtirpc-1.0.2-0-chromeos-armv7l.tar.xz')
  sha256s+=('f2af84d80968a7b7271d7ed00e9fa771157530a237282c9c0cea0eea39fea167')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libunistring-0.9.10-chromeos-armv7l.tar.xz')
  sha256s+=('bd3254d74558de91f176d933d0e4c71eb34b82e245abfbbce9fbee675e89e6fc')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.50-chromeos-armv7l.tar.xz')
  sha256s+=('0267ada9d7a13d09de9ca7503f1fe6623262de74dd364cb3998e6ae30d583808')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-c5f04a58-chromeos-armv7l.tar.xz')
  sha256s+=('31c1053a2ba5775de0ea099447af443bdcb8732a7851c581219c7bc9177cafe4')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ruby-2.7.2-chromeos-armv7l.tar.xz')
  sha256s+=('a435e6bf7965e1a82e8842e5ea66bdd670ec9b627d785bd720d3d2652fc89f6d')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/git-2.28.0-1-chromeos-armv7l.tar.xz')
  sha256s+=('f3a111e4f5ab2484b4eea1c32b68089256a7535b6ee9c495b45e776d3108c5e5')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/curl-7.72.0-1-chromeos-armv7l.tar.xz')
  sha256s+=('bf7579c54c6e06479f615d1abf87adf89fc39f3d2c404e2ab2cb95070ace6098')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libressl-3.1.4-chromeos-armv7l.tar.xz')
  sha256s+=('0b3da102fede122f12ec32a44cd3e543d72184cd90c9937f6fd32dea6d71c121')
  ;;
"i686")
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/gcc8-8.3.0-chromeos-i686.tar.xz')
  sha256s+=('4d625e92969fde16c1a92601740e22c07331f8056452edf7cf0bf2c1c88aa152')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.8-chromeos-i686.tar.xz')
  sha256s+=('c16396d2d9a4a000b360fd6f096e4f0053abafb7bf1f8c84766527ea7a4b074f')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/c_ares-1.15.0-chromeos-i686.tar.xz')
  sha256s+=('00ea353730432d9b86c9ddbe05774c2fdcc13dd3cc820c31871410b6d43178f1')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libcyrussasl-2.1.27-1-chromeos-i686.tar.xz')
  sha256s+=('dbce3fbbf6efedd4c9266c14163022ca9a1da22386f55eeffe6074c341a5bac0')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-chromeos-i686.tar.xz')
  sha256s+=('a7afa407d80bc94038711a636f10cf9af7fae7fce5b68220f4d9c51eca44849e')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libidn2-2.0.5-chromeos-i686.tar.xz')
  sha256s+=('d07969ea21a9f390afe961dcbb78f014c17cfd5bc3af6dbb4732e32004f61e6a')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libmbedtls-2.16.8-chromeos-i686.tar.xz')
  sha256s+=('82f4fe07be9599125bbce078e3ff8a5c3f2c96691270abc60cf97fed79879e45')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libmetalink-0.1.3-1-chromeos-i686.tar.xz')
  sha256s+=('d10d7a95750b93be70f457d6c5db8935e30f85a726bf154d2953d075bd28d216')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libnghttp2-1.38.0-chromeos-i686.tar.xz')
  sha256s+=('cc5a56e8d3731aab1f8ff2a983e42d147e5a7234206d961e39b69d24d7cc3ffd')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.9.0-chromeos-i686.tar.xz')
  sha256s+=('dd2172bf82e3ffc1cfd06463108a36de55ba5e4bc2eb283852b54a737e087fe4')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libtirpc-1.0.2-0-chromeos-i686.tar.xz')
  sha256s+=('3f484468cba8c5e69bff19eaa5c326dbb7e2e44d7e41c1c7ce3f570d0a7eb526')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libunistring-0.9.10-chromeos-i686.tar.xz')
  sha256s+=('88cb3cbfdf6c108045cf63d5aa70b2d036fceacc93f0ead76858381db4268c76')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.50-chromeos-i686.tar.xz')
  sha256s+=('71df836d0590e3ab3c27b7bc0debac785b112615f2138a5e13e4d901b2b40413')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-c5f04a58-chromeos-i686.tar.xz')
  sha256s+=('f21b4f9f4c3978db0bb4e0814993b7af076e04c6b86d6a3b5fa548f6fa0cf9e6')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ruby-2.7.2-chromeos-i686.tar.xz')
  sha256s+=('81865864d3ba93b6cbd5dc8e1b6cb51bd2ebe854f6c01e282c1b73f379fb7caf')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/git-2.28.0-1-chromeos-i686.tar.xz')
  sha256s+=('62fa336fd068611c6b3bd0c7be3723dd71aada453470554d3aa63f84bae5377e')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/curl-7.72.0-1-chromeos-i686.tar.xz')
  sha256s+=('6fead78266081c9f909b0b5f5f58b0ad70c4acfc0d1fe691c9556b718aefe5f9')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libressl-3.1.4-chromeos-i686.tar.xz')
  sha256s+=('0e3e4d7be5575212286e5cc26c60b7473f448436abda50208a252afd53a1d694')
  ;;
"x86_64")
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/gcc8-8.3.0-chromeos-x86_64.tar.xz')
  sha256s+=('ae8c8c33e4090f7fdbd39b2364754dcfc5f6bdd9a74062fde3eeb6272562f48b')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.8-chromeos-x86_64.tar.xz')
  sha256s+=('921fc1be57c195176d500f82bf96a52566824e62036c329ced629a0177c7c9d1')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/c_ares-1.15.0-chromeos-x86_64.tar.xz')
  sha256s+=('6587740ad61b5d0a74973235d6e6c01a4e6ea1f5510ee8103ff6e1d2ad045b41')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libcyrussasl-2.1.27-1-chromeos-x86_64.tar.xz')
  sha256s+=('46241ea5cf5e0181649e91edb183128669d5ab5bc13a938493ba1158a5189743')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-chromeos-x86_64.tar.xz')
  sha256s+=('cc29b28830c4bc496b2ef495e9dd43d96e596f879d02d7176222575bb83b5088')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libidn2-2.0.5-chromeos-x86_64.tar.xz')
  sha256s+=('22b43990ca6ae415b9b7e206ed7d7b05df29b97411de55f33f11e834cf3b345c')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libmbedtls-2.16.8-chromeos-x86_64.tar.xz')
  sha256s+=('58e98d4edf8ff733228ff2499e7faf33bfc1d90bc6c834e8b1b78b7c369b85f1')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libmetalink-0.1.3-1-chromeos-x86_64.tar.xz')
  sha256s+=('6e1e4b07e44e4b8cf1c436a6594f333bf339803c4c04a6c5a4f1762e00409479')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libnghttp2-1.38.0-chromeos-x86_64.tar.xz')
  sha256s+=('32428353d0b390ca68f1737ebaead7e5cd5ade1676c7d62896de0553bd58fa39')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.9.0-chromeos-x86_64.tar.xz')
  sha256s+=('d02623da747ecc95acdba69a056220ef579b01dae82a0cbfec2aa96c2ea8e914')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libtirpc-1.0.2-0-chromeos-x86_64.tar.xz')
  sha256s+=('6d4a7b558189ac4b78c24f6d5aa5904ed2dfe960ff3a6b1a4019294e2c051fc7')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libunistring-0.9.10-chromeos-x86_64.tar.xz')
  sha256s+=('d0fccb9b680e38517ce95483fcbac289ba835aa79e5c106bc21ec8de7872a13b')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.50-chromeos-x86_64.tar.xz')
  sha256s+=('1c71f56cdecc230eaa5a5188b4141d71e84e61c77033b7c9f7aa5a0c60799049')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-c5f04a58-chromeos-x86_64.tar.xz')
  sha256s+=('74ec242f369bdf542f725a7675a11be49d8ee898f6f2b963b406b4004d45effe')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ruby-2.7.2-chromeos-x86_64.tar.xz')
  sha256s+=('658808516b7a2e58f8102fd131e765aaa79f2a7c906d0330b7e883fbdc12d1a9')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/git-2.28.0-1-chromeos-x86_64.tar.xz')
  sha256s+=('33cc1be6a9dca5a8baacc85a9a083949ea650bea37f45c13f14ee879f8afe73d')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/curl-7.72.0-1-chromeos-x86_64.tar.xz')
  sha256s+=('99097864dbb9b36941387cde22ccfff3ce6e3f5e8f79f7975dfedb9c875f6a7e')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libressl-3.1.4-chromeos-x86_64.tar.xz')
  sha256s+=('5744988a28dc957ddabd49244c203a4cc43cba5332459669a9a5928628e841e4')
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
crew update

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
