# Adapted from Arch Linux wireshark PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/wireshark/trunk/PKGBUILD

require 'buildsystems/cmake'

class Wireshark < CMake
  description 'Network traffic and protocol analyzer/sniffer'
  homepage 'https://www.wireshark.org/'
  version '4.4.9'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/wireshark/wireshark.git'
  git_hashtag "wireshark-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2d7c7e952bddde62f79e51841559421113504bd7141489f433ea7e46b664346d',
     armv7l: '2d7c7e952bddde62f79e51841559421113504bd7141489f433ea7e46b664346d',
       i686: 'b666f63531be99e1d7a4cbf305c4eb75859ae09bb7ffb08a3d0178a39986e31e',
     x86_64: '28a157411c42b12d2681cb0d5b04efd40b5e4a2c0fe174a0c888caa77b62e8be'
  })

  depends_on 'brotli' # R
  depends_on 'c_ares' # R
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'krb5' # R
  depends_on 'libcap' # R
  depends_on 'libgcrypt' # R
  depends_on 'libmaxminddb' # R
  depends_on 'libnghttp2' # R
  depends_on 'libnl3' # R
  depends_on 'libopencoreamr' # R
  depends_on 'libpcap' # R
  depends_on 'libsmi' # R
  depends_on 'libssh' # R
  depends_on 'libxml2' # R
  depends_on 'lz4' # R
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
  depends_on 'zlib' # R
  depends_on 'zlib_ng' # R
  depends_on 'zstd' # R

  git_fetchtags

  pre_cmake_options 'WIRESHARK_BUILD_WITH_QT5=1'
  cmake_options "-DENABLE_LTO=true \
    -DBUILD_wireshark=#{ARCH == 'i686' ? 'false' : 'true'} \
    -DUSE_qt6=OFF"
end
