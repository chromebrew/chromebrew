# Adapted from Arch Linux wireshark PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/wireshark/trunk/PKGBUILD

require 'buildsystems/cmake'

class Wireshark < CMake
  description 'Network traffic and protocol analyzer/sniffer'
  homepage 'https://www.wireshark.org/'
  version '4.2.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/wireshark/wireshark.git'
  git_hashtag "wireshark-#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wireshark/4.2.0_armv7l/wireshark-4.2.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wireshark/4.2.0_armv7l/wireshark-4.2.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wireshark/4.2.0_i686/wireshark-4.2.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wireshark/4.2.0_x86_64/wireshark-4.2.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '54abe57326dc705ae7a3a28a7e92e5d576aa6ec91944255287f99c71ca835911',
     armv7l: '54abe57326dc705ae7a3a28a7e92e5d576aa6ec91944255287f99c71ca835911',
       i686: '19c3478e380880a5e7069a9f9072820025d641e707e8000f360e59efe75a43a0',
     x86_64: '04fc54e9aa11ce00e7513997a78377ff56702f9bb1c8313c0b8bdbef6e4f1ef4'
  })

  depends_on 'brotli' # R
  depends_on 'c_ares' # R
  depends_on 'e2fsprogs' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gnutls' # R
  depends_on 'krb5' # R
  depends_on 'libcap' # R
  depends_on 'libgcrypt' # R
  depends_on 'libgpgerror' # R
  depends_on 'libmaxminddb' # R
  depends_on 'libnghttp2' # R
  depends_on 'libnl3' # R
  depends_on 'libopencoreamr' # R
  depends_on 'libpcap' # R
  depends_on 'libsmi' # R
  depends_on 'libssh' # R
  depends_on 'libxml2' # R
  depends_on 'lz4' # R
  depends_on 'minizip' # R
  depends_on 'opus' # R
  depends_on 'pcre2' # R
  depends_on 'qt5_base' unless ARCH == 'i686'
  depends_on 'qt5_multimedia' unless ARCH == 'i686'
  depends_on 'qt5_svg' unless ARCH == 'i686'
  depends_on 'qt5_tools' unless ARCH == 'i686'
  depends_on 'ruby_asciidoctor' => :build
  depends_on 'sbc' # R
  depends_on 'snappy' # R
  depends_on 'speexdsp' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  git_fetchtags

  pre_cmake_options 'WIRESHARK_BUILD_WITH_QT5=1'
  cmake_options "-DENABLE_LTO=true \
    -DBUILD_wireshark=#{ARCH == 'i686' ? 'false' : 'true'}"
end
