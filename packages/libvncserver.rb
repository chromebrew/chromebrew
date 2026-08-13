require 'buildsystems/cmake'

class Libvncserver < CMake
  description 'LibVNCServer/LibVNCClient are cross-platform C libraries that allow you to easily implement VNC server or client functionality in your program.'
  homepage 'https://github.com/LibVNC/libvncserver'
  version '0.9.15'
  compatibility 'aarch64 armv7l x86_64'
  license 'GPL-2, GPL-2+, LGPL-2.1+, BSD and MIT'
  source_url "https://github.com/LibVNC/libvncserver/archive/LibVNCServer-#{version}.tar.gz"
  source_sha256 '62352c7795e231dfce044beb96156065a05a05c974e5de9e023d688d8ff675d7'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f0aef4f225d80e5cf9ebb48ac62070391a14376ef928c4d3361ddceb65907f31',
     armv7l: 'f0aef4f225d80e5cf9ebb48ac62070391a14376ef928c4d3361ddceb65907f31',
     x86_64: '7709996f8598bc549a11c12efa7893a56fa8edb1e5e99cbb168600ee8db15b1a'
  })

  depends_on 'ffmpeg' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gnutls' => :library
  depends_on 'gtk2' => :build
  depends_on 'libcyrussasl' => :library
  depends_on 'libgcrypt' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libpng' => :library
  depends_on 'lzo' => :library
  depends_on 'openssl' => :library
  depends_on 'zlib' => :library

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DWITH_SYSTEMD=OFF'
end
