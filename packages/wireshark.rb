# Adapted from Arch Linux wireshark PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/wireshark/trunk/PKGBUILD

require 'buildsystems/cmake'

class Wireshark < CMake
  description 'Network traffic and protocol analyzer/sniffer'
  homepage 'https://www.wireshark.org/'
  version '4.2.3'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/wireshark/wireshark.git'
  git_hashtag "wireshark-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7b8aa126fcb06deb4739b1a24bc7e1bf27c3b32cb9b45157198ea2f604cab53d',
     armv7l: '7b8aa126fcb06deb4739b1a24bc7e1bf27c3b32cb9b45157198ea2f604cab53d',
       i686: 'ddd5018c138d0fb411d99c857aecac9902bcee75ab398c6e6373da13abfd735d',
     x86_64: '40d21fcdfe0d7bac9c2db677054b94ca03ebf5f1b707ba93d58e2e88fe3d90d8'
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
