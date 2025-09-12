# Adapted from Arch Linux libngtcp2 PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/libngtcp2/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Libngtcp2 < CMake
  description 'Implementation of IETF QUIC protocol'
  homepage 'https://github.com/ngtcp2/ngtcp2'
  version '1.15.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ngtcp2/ngtcp2.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '90403f60545cd79ac583afa0cd242b4f0a336a9ed6457bf058a0cddcbfb151c1',
     armv7l: '90403f60545cd79ac583afa0cd242b4f0a336a9ed6457bf058a0cddcbfb151c1',
       i686: 'a005276c8bedf7f54ccbf3cd63b67524e97022d5a5eb23f1a911dabff52ce575',
     x86_64: '8448ad32f77ba4d2ff1ef33e5d579ec2ae1d716eff778ce3701f8198486f5221'
  })

  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'openssl' # R

  cmake_options '-DENABLE_GNUTLS=ON \
                 -DENABLE_LIB_ONLY=ON'
end
