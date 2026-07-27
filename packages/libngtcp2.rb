# Adapted from Arch Linux libngtcp2 PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/libngtcp2/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Libngtcp2 < CMake
  description 'Implementation of IETF QUIC protocol'
  homepage 'https://github.com/ngtcp2/ngtcp2'
  version '1.25.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ngtcp2/ngtcp2.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b948ab733993c8086ebe073b9c1b973f2db965446444b11cea47cf2e6c084d4a',
     armv7l: 'b948ab733993c8086ebe073b9c1b973f2db965446444b11cea47cf2e6c084d4a',
       i686: 'f2bb85640c9f24cc2a6ede23d1ec5217eacefbb6ab101f0e0ca330e0294da827',
     x86_64: '7461f04c70810683c949d26ebf43e824a14f429ff72c4f0abfeedbc672c7159e'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gnutls' => :library
  depends_on 'openssl' => :library

  cmake_options '-DENABLE_GNUTLS=ON \
                 -DENABLE_LIB_ONLY=ON'
end
