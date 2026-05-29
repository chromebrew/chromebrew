# Adapted from Arch Linux wireshark PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/wireshark/trunk/PKGBUILD

require 'buildsystems/cmake'

class Wireshark < CMake
  description 'Network traffic and protocol analyzer/sniffer'
  homepage 'https://www.wireshark.org/'
  version '4.6.6'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/wireshark/wireshark.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ffba04ac791f0a7b4996dab77c4e2eb3d2a2684c909f4d3bda4d20b678468f12',
     armv7l: 'ffba04ac791f0a7b4996dab77c4e2eb3d2a2684c909f4d3bda4d20b678468f12',
     x86_64: 'b7903b1831d30ba4a5a8e0dc6fe4b0582b8b9e0055b8ca35d054331a21bee5eb'
  })

  depends_on 'brotli' => :library
  depends_on 'c_ares' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gnutls' => :library
  depends_on 'krb5' => :library
  depends_on 'libcap' => :executable
  depends_on 'libgcrypt' => :library
  depends_on 'libmaxminddb' => :executable
  depends_on 'libnghttp2' => :library
  depends_on 'libnghttp3' => :library
  depends_on 'libnl3' => :library
  depends_on 'libopencoreamr' => :library
  depends_on 'libpcap' => :executable
  depends_on 'libsmi' => :library
  depends_on 'libssh' => :library
  depends_on 'libxml2' => :library
  depends_on 'lz4' => :library
  depends_on 'opus' => :library
  depends_on 'pcre2' => :library
  depends_on 'qt5_base' => :build
  depends_on 'qt5_multimedia' => :build
  depends_on 'qt5_svg' => :build
  depends_on 'qt5_tools' => :build
  depends_on 'ruby_asciidoctor' => :build
  depends_on 'sbc' => :library
  depends_on 'snappy' => :library
  depends_on 'speexdsp' => :executable
  depends_on 'xxhash' => :library
  depends_on 'zlib' => :library
  depends_on 'zlib_ng' => :library
  depends_on 'zstd' => :library

  git_fetchtags

  pre_cmake_options 'WIRESHARK_BUILD_WITH_QT5=1'
  cmake_options "-DENABLE_LTO=true \
    -DBUILD_wireshark=true \
    -DUSE_qt6=OFF"
end
