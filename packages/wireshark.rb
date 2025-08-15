# Adapted from Arch Linux wireshark PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/wireshark/trunk/PKGBUILD

require 'buildsystems/cmake'

class Wireshark < CMake
  description 'Network traffic and protocol analyzer/sniffer'
  homepage 'https://www.wireshark.org/'
  version '4.4.8'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/wireshark/wireshark.git'
  git_hashtag "wireshark-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a1e344cc6dd4f1309ff47d336ac4d55712494a439d3bc9186a2bb1c0fbb12006',
     armv7l: 'a1e344cc6dd4f1309ff47d336ac4d55712494a439d3bc9186a2bb1c0fbb12006',
       i686: '84a7c6dbc42cf8d1bca86ecdbc252df7b8dea8baf707b50b4ab2f9c687df44d9',
     x86_64: '393ee933daca02a43ac2ead192eabdcf2c4848a9c09058cc01a5afe77405233e'
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
