# Adapted from Arch Linux libngtcp2 PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/libngtcp2/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Libngtcp2 < CMake
  description 'Implementation of IETF QUIC protocol'
  homepage 'https://github.com/ngtcp2/ngtcp2'
  version '1.21.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ngtcp2/ngtcp2.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '10503131c5fbfc3ccc1c392c0d90aedbc3db5ddfce8661e13ff53f04b900aaf7',
     armv7l: '10503131c5fbfc3ccc1c392c0d90aedbc3db5ddfce8661e13ff53f04b900aaf7',
       i686: 'c9a79f87566ef5e6c207aca696dd786347d616d7355e090b2fd843211db19f2f',
     x86_64: '2ab5cba3c0fab8401e062147d2efe6b564a5b46de4bf91053befd1ce91767acb'
  })

  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'openssl' # R

  cmake_options '-DENABLE_GNUTLS=ON \
                 -DENABLE_LIB_ONLY=ON'
end
