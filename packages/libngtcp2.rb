# Adapted from Arch Linux libngtcp2 PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/libngtcp2/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Libngtcp2 < CMake
  description 'Implementation of IETF QUIC protocol'
  homepage 'https://github.com/ngtcp2/ngtcp2'
  version '1.23.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ngtcp2/ngtcp2.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '84244b092b9452af73666e42286bdd841585dc080799fa78c5eb683c35631a6f',
     armv7l: '84244b092b9452af73666e42286bdd841585dc080799fa78c5eb683c35631a6f',
       i686: '0b850d6365bdaad8d4c1e42f8095f80323aba0d6cb9787dfd9c5e1f7953e700d',
     x86_64: 'e4d7648fa0895d9065d6f2df83a2e58e95a54b5f5b084d083c2d7cced114f970'
  })

  depends_on 'glibc' => :library
  depends_on 'gnutls' => :library
  depends_on 'openssl' => :library

  cmake_options '-DENABLE_GNUTLS=ON \
                 -DENABLE_LIB_ONLY=ON'
end
