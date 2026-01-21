# Adapted from Arch Linux libngtcp2 PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/libngtcp2/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Libngtcp2 < CMake
  description 'Implementation of IETF QUIC protocol'
  homepage 'https://github.com/ngtcp2/ngtcp2'
  version '1.20.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ngtcp2/ngtcp2.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7f16ebcfaa0f7e61521f6dde3c8a1ac039be7702df05f14fdffff78438fef85e',
     armv7l: '7f16ebcfaa0f7e61521f6dde3c8a1ac039be7702df05f14fdffff78438fef85e',
       i686: '9d99b6a0e7a8b605127d50b4f1efc717beb2cff297f05b3e57e49906332ecfc1',
     x86_64: '70306e5fa5c76f12deda789ed0f03648085f5844786696acedb703544cb74894'
  })

  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'openssl' # R

  cmake_options '-DENABLE_GNUTLS=ON \
                 -DENABLE_LIB_ONLY=ON'
end
