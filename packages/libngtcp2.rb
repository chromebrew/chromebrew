# Adapted from Arch Linux libngtcp2 PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/libngtcp2/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Libngtcp2 < CMake
  description 'Implementation of IETF QUIC protocol'
  homepage 'https://github.com/ngtcp2/ngtcp2'
  version '1.26.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ngtcp2/ngtcp2.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c68a18fd99af1b4a2501c2c0efb631af3f6a820f1ec4dd579f8f1049a18f018c',
     armv7l: 'c68a18fd99af1b4a2501c2c0efb631af3f6a820f1ec4dd579f8f1049a18f018c',
       i686: '99d7af055d77dc6769aeda12efb1dabfe479121bccc3247d1d7b0f671bf7fffc',
     x86_64: '4e7b78bd43e827c2b9adf937386fdd234eb83f1ef6d9f271b913e050e35578df'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gnutls' => :library
  depends_on 'openssl' => :library

  cmake_options '-DENABLE_GNUTLS=ON \
                 -DENABLE_LIB_ONLY=ON'
end
