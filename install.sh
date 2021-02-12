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
crew_folders="bin cache doc docbook etc include lib lib$LIB_SUFFIX libexec man sbin share tmp var"
for folder in $crew_folders
do
  if [ -d "${CREW_PREFIX}"/"${folder}" ] || [ -L "${CREW_PREFIX}"/"${folder}" ]; then 
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
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/llvm-11.1.0-rc1-chromeos-armv7l.tar.xz')
  sha256s+=('5ecb72e60483b15c7588446a7ac424d64cdd3f21ca0fa5ffea4737a25dedca89')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.8-chromeos-armv7l.tar.xz')
  sha256s+=('636a5bb46059311e280f1828aa032e2d2bad83905b124549159b73e279856688')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/c_ares-1.15.0-chromeos-armv7l.tar.xz')
  sha256s+=('fb85ed9ab22dc4ba7533b67365b56d9ee666580472898432adf3d27d2a20fe3e')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libcyrussasl-2.1.27-1-chromeos-armv7l.tar.xz')
  sha256s+=('281ac03fa4841ff2bd2395e960a9803791fac3ccfa0bf70ec7b8f79088c25817')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-4-chromeos-armv7l.tar.xz')
  sha256s+=('3328a5694b7eb6d44bfad79129aacb36f564ed597f31aafb54615635d50e1560')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libidn2-2.3.0-chromeos-armv7l.tar.xz')
  sha256s+=('7614e912f8122d6a2a3b779f4c16f0e74029dd1213ea9d38ed7b6ee6d19f3de6')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libmetalink-0.1.3-1-chromeos-armv7l.tar.xz')
  sha256s+=('25b93f3304ee1cf1a06c582de5c053436322b08fb27a576d132130bf73ef436b')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libnghttp2-1.38.0-chromeos-armv7l.tar.xz')
  sha256s+=('7375e44ec6c77c7afc760eaa4310d9974e0640cb46053c330b32c0e87bee73f4')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libpsl-0.21.1-chromeos-armv7l.tar.xz')
  sha256s+=('9b8376e9c1b5e65363e0c4a7ad61721930e07dbaa032c76455723186d6268d47')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.9.0-3-chromeos-armv7l.tar.xz')
  sha256s+=('a8b26892821ee9fae80de1c93d3f33171826e81849977227654d0ab91067ec25')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libtirpc-1.3.1-chromeos-armv7l.tar.xz')
  sha256s+=('489870e43cd86ca9aa252f3639f54e8af9bc6b33e16ef96aa66f0114bef8ee90')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libunistring-0.9.10-chromeos-armv7l.tar.xz')
  sha256s+=('bd3254d74558de91f176d933d0e4c71eb34b82e245abfbbce9fbee675e89e6fc')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.57-chromeos-armv7l.tar.xz')
  sha256s+=('eafc72703f61b96747a8d37e6fcdac7d5d400832da9f9205936188dda6e57a46')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-c5f04a58f-1-chromeos-armv7l.tar.xz')
  sha256s+=('47e67bbdb93c72136630dfc35c37ddd7d37c242fbd3446f67ff40b52376fa3e6')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/zstd-1.4.7-chromeos-armv7l.tar.xz')
  sha256s+=('4a917969893ff2d985aa498d989219b2c569dd01ff1b198d3e6bd2a770b7d34c')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.2-20210206-1-chromeos-armv7l.tar.xz')
  sha256s+=('f87816a803fdbb6403ecb03ea4faec04da8c3a829a1455a2c9e0a0686818ebb6')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ca_certificates-20210119-chromeos-armv7l.tar.xz')
  sha256s+=('75d332ca6053e5e12d34eb5d72da6daab50d650f6733d1bd9668bed9af802e30')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ruby-3.0.0-2-chromeos-armv7l.tar.xz')
  sha256s+=('6e2d40ea5d1bafbe0b79e1a0ae644911f33a9ceb94716d3e4c05d91884850b28')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libffi-3.3-chromeos-armv7l.tar.xz')
  sha256s+=('22a2ec5efcbcf5b587f34f35489ee0976f5a1ed256f47a4ac87a240f804c0d02')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/openssl-1.1.1i-1-chromeos-armv7l.tar.xz')
  sha256s+=('6b4db90acb22c772dcb70d5688033b26230d3e10f2037ee56422f38b8fbd0029')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/nettle-3.7-1-chromeos-armv7l.tar.xz')
  sha256s+=('5b39e94078c6b414dbab4bc39d3930cea06cda4fae8ac00ae8070d398cc66427')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/curl-7.75.0-chromeos-armv7l.tar.xz')
  sha256s+=('6d0b932c52ecb2ca3dec9e6f713804d632e0744c243019c93fc92eabe5a01edd')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/git-2.30.0-2-chromeos-armv7l.tar.xz')
  sha256s+=('a11bad34ddd17924b226026eccabf449381cf6b069715b914ab7bd66b3190a36')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/icu4c-68.2-chromeos-armv7l.tar.xz')
  sha256s+=('35dfc0e95c0d6c09a323fd6ec393dc48e33940fc7815a4f51adff5a63f99416a')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libedit-20191231-3.1-chromeos-armv7l.tar.xz')
  sha256s+=('610986dcb014c2079b2b355628ee6f7b867076974cf751b891a926f0a0d9d5b8')
  ;;
"i686")
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/gcc10-10.2.1-0f64-chromeos-i686.tar.xz')
  sha256s+=('52850f19acb5c7def3b7116a5873a5c68c4f9a7fa254b5198deacff36f1e15aa')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/llvm-11.1.0-rc1-chromeos-i686.tar.xz')
  sha256s+=('5595ca097aa454bd54b8a336d467ee266f8afd4bd8100d1a3831e3face9b4f43')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.8-chromeos-i686.tar.xz')
  sha256s+=('c16396d2d9a4a000b360fd6f096e4f0053abafb7bf1f8c84766527ea7a4b074f')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/c_ares-1.15.0-chromeos-i686.tar.xz')
  sha256s+=('00ea353730432d9b86c9ddbe05774c2fdcc13dd3cc820c31871410b6d43178f1')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libcyrussasl-2.1.27-1-chromeos-i686.tar.xz')
  sha256s+=('dbce3fbbf6efedd4c9266c14163022ca9a1da22386f55eeffe6074c341a5bac0')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-4-chromeos-i686.tar.xz')
  sha256s+=('efb5c2b71144f1cd413360a87634cf4a81dbcad568186315fb3d127460b68e65')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libidn2-2.3.0-chromeos-i686.tar.xz')
  sha256s+=('eed21b95d8c8d236acfc87e40cf6aa605a6ceb6894b2c0f331e8955e2897a617')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libmetalink-0.1.3-1-chromeos-i686.tar.xz')
  sha256s+=('d10d7a95750b93be70f457d6c5db8935e30f85a726bf154d2953d075bd28d216')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libnghttp2-1.38.0-chromeos-i686.tar.xz')
  sha256s+=('cc5a56e8d3731aab1f8ff2a983e42d147e5a7234206d961e39b69d24d7cc3ffd')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libpsl-0.21.1-chromeos-i686.tar.xz')
  sha256s+=('c5d298373d73a26ecd8559254f00286f14e129a09dbe13f94252356a332fc172')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.9.0-3-chromeos-i686.tar.xz')
  sha256s+=('8004bd36ae1af0c9a2897881ad279f774b8dd72bf67b33f5e8ed7d792f36ba0b')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libtirpc-1.3.1-chromeos-i686.tar.xz')
  sha256s+=('987de099b04760d251425554071d505ec001818a152a782cd51b92ae6edf9dc5')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libunistring-0.9.10-chromeos-i686.tar.xz')
  sha256s+=('88cb3cbfdf6c108045cf63d5aa70b2d036fceacc93f0ead76858381db4268c76')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.57-chromeos-i686.tar.xz')
  sha256s+=('e981259b1c30688d15c3b8ca83ea87fe83bd41f1923322b274df04e6e10611f0')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-c5f04a58f-1-chromeos-i686.tar.xz')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libtirpc-1.3.1-chromeos-i686.tar.xz')
  sha256s+=('987de099b04760d251425554071d505ec001818a152a782cd51b92ae6edf9dc5')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libunistring-0.9.10-chromeos-i686.tar.xz')
  sha256s+=('88cb3cbfdf6c108045cf63d5aa70b2d036fceacc93f0ead76858381db4268c76')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.57-chromeos-i686.tar.xz')
  sha256s+=('e981259b1c30688d15c3b8ca83ea87fe83bd41f1923322b274df04e6e10611f0')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-c5f04a58f-1-chromeos-i686.tar.xz')
  sha256s+=('109fb6fa70409f8ba274fa452c2e04dc1ff3ba740f618525c188139c1ddce363')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/zstd-1.4.7-chromeos-i686.tar.xz')
  sha256s+=('192b17e599990e94d2d8343095c90be85e0013fe92c8933c6795c51f8ba39d89')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.2-20210206-1-chromeos-i686.tar.xz')
  sha256s+=('ad1fb3a7d832d4fcf4e695cd5f5f7e023581c2d0529a2bf9729acd2cd96e44cd')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ca_certificates-20210119-chromeos-i686.tar.xz')
  sha256s+=('e61ae07f85f64f0c53fa922714ac30579c77db5f2e9fa266e4e6059b502f5475')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ruby-3.0.0-2-chromeos-i686.tar.xz')
  sha256s+=('44422c2fbe7c1d4d8d0088d12c1691d33de19fbe10a1461d9b3ce8cf1e2e7e1e')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libffi-3.3-chromeos-i686.tar.xz')
  sha256s+=('8041e3401d2b9721a2dd87d31aff2b1b5380f7946c092d9a3c18f573ca6422f8')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/openssl-1.1.1i-1-chromeos-i686.tar.xz')
  sha256s+=('22aae2e468cab25f6258c07cce8afe586b906297d2af602762516c5fd1cd93b5')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/nettle-3.7-1-chromeos-i686.tar.xz')
  sha256s+=('22cc6881f5df8c0e0a6d77154156ab74efb3ec9866208cde5c71a5935bad839b')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/curl-7.75.0-chromeos-i686.tar.xz')
  sha256s+=('8944cd73ecbc7cbda1a3afc18aafdea28486baad7b7664d6b16c3ccc23ca2c07')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/git-2.30.0-2-chromeos-i686.tar.xz')
  sha256s+=('d09ad3f842c1fefba128e28252d383b69bc890627e7759abeb1d75b624bf4d84')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/icu4c-68.2-chromeos-i686.tar.xz')
  sha256s+=('1c45fb6c19db175fba61dd9925b648955c5081ad7dea31feb7b613b5ca0a97c9')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libedit-20191231-3.1-chromeos-i686.tar.xz')
  sha256s+=('dc3d211fd649803d0dd89c3f82163a8bf67eeebaea9629b14bd9e570ba545933')
  ;;
"x86_64")
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/gcc10-10.2.1-0f64-chromeos-x86_64.tar.xz')
  sha256s+=('438ae78481cbbfcc38c6d917498f6b6f0681627a798b263bb9b8ef222ee38b35')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/llvm-11.1.0-rc1-chromeos-x86_64.tar.xz')
  sha256s+=('031f6f3510ebbc5a1270fac07934d7efa9126c8e89f98695505b1376d6d233a5')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.8-chromeos-x86_64.tar.xz')
  sha256s+=('921fc1be57c195176d500f82bf96a52566824e62036c329ced629a0177c7c9d1')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/c_ares-1.15.0-chromeos-x86_64.tar.xz')
  sha256s+=('6587740ad61b5d0a74973235d6e6c01a4e6ea1f5510ee8103ff6e1d2ad045b41')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libcyrussasl-2.1.27-1-chromeos-x86_64.tar.xz')
  sha256s+=('46241ea5cf5e0181649e91edb183128669d5ab5bc13a938493ba1158a5189743')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-4-chromeos-x86_64.tar.xz')
  sha256s+=('378d0566c86141072f0b57f7aaf1e3bc7cac4c5dc88b4f9a441b5302fa549cc6')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libidn2-2.3.0-chromeos-x86_64.tar.xz')
  sha256s+=('06c9f3803f02ce792550a39a1de3253b74ca6622b2543f843727f31dc4aa0f46')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libmetalink-0.1.3-1-chromeos-x86_64.tar.xz')
  sha256s+=('6e1e4b07e44e4b8cf1c436a6594f333bf339803c4c04a6c5a4f1762e00409479')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libnghttp2-1.38.0-chromeos-x86_64.tar.xz')
  sha256s+=('32428353d0b390ca68f1737ebaead7e5cd5ade1676c7d62896de0553bd58fa39')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libpsl-0.21.1-chromeos-x86_64.tar.xz')
  sha256s+=('e8c7a5c5f46be4ff1158d5d643a3efa14fcf008f4f6af906703612b907c9e725')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.9.0-3-chromeos-x86_64.tar.xz')
  sha256s+=('aa7e4634d65400f17ab064ce8b9cd43703d3dd9393426e1155ea8627876cda8b')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libtirpc-1.3.1-chromeos-x86_64.tar.xz')
  sha256s+=('982db8c305a1c2859ab9954a18e03e5500a277fa00717e7646bf69b95a744213')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libunistring-0.9.10-chromeos-x86_64.tar.xz')
  sha256s+=('d0fccb9b680e38517ce95483fcbac289ba835aa79e5c106bc21ec8de7872a13b')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/openldap-2.4.57-chromeos-x86_64.tar.xz')
  sha256s+=('e0ca5de88bd9808f8e30beb0861bec2da9c3686b538f4563603b19fbd50b6278')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-c5f04a58f-1-chromeos-x86_64.tar.xz')
  sha256s+=('0212408c6faad92b5909d77188d8c27e68ce955f61dcb5597603303e31e601ce')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/zstd-1.4.7-chromeos-x86_64.tar.xz')
  sha256s+=('017e2d9e5fa613bb50385f6b49bb9642f7b3e6f10453e46b89ea3e4701a39ae7')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.2-20210206-1-chromeos-x86_64.tar.xz')
  sha256s+=('d81416072e4e4454b585495db8b7e0767867c851e512afd4655fa8174d244c02')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ca_certificates-20210119-chromeos-x86_64.tar.xz')
  sha256s+=('7a782fdba9f89b077004dab99c15367bb999ed1b19485e32a22be2e79c4f3ac3')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ruby-3.0.0-2-chromeos-x86_64.tar.xz')
  sha256s+=('20d4d18d1a184a088abb5547bc94e7f6189229565157bb35c5691cf0f1264f9f')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libffi-3.3-chromeos-x86_64.tar.xz')
  sha256s+=('aecc094eb0e5b961106ee3d4086f120a30555cb82b3b8263107d9cab4e6c278f')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/openssl-1.1.1i-1-chromeos-x86_64.tar.xz')
  sha256s+=('c5d19a3cab5f38898f4875ca2be57c3a8fb23c73726dd14e29f7bed02d252eb0')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/nettle-3.7-1-chromeos-x86_64.tar.xz')
  sha256s+=('713dbccd1a267bac1cd71856ab6f68dd897ae32a005d2c9439f9d31d31597481')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/curl-7.75.0-chromeos-x86_64.tar.xz')
  sha256s+=('a511db565f40b830a623a173739d29a3c935ea2698ebb407b65a630d1e279b17')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/git-2.30.0-2-chromeos-x86_64.tar.xz')
  sha256s+=('3a63be93d3bbc46811a7f8b81a8e4b08c03ff82facf36419030ac214b60e4e6b')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/icu4c-68.2-chromeos-x86_64.tar.xz')
  sha256s+=('290087e9c03a94eaf5d33a82b76dc3b5bb11be1dff5a6e57aa190ec5439bcfb2')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libedit-20191231-3.1-chromeos-x86_64.tar.xz')
  sha256s+=('834915020f3fd98b0e3ca8609ae0b915b47ca77ea5877fa7b758a85571401e8e')
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
