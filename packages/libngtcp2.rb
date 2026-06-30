# Adapted from Arch Linux libngtcp2 PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/libngtcp2/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Libngtcp2 < CMake
  description 'Implementation of IETF QUIC protocol'
  homepage 'https://github.com/ngtcp2/ngtcp2'
  version '1.24.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ngtcp2/ngtcp2.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '661ff2b83052f1e76537a88c2411273cf15bd7011159c174eb88108a425806f3',
     armv7l: '661ff2b83052f1e76537a88c2411273cf15bd7011159c174eb88108a425806f3',
       i686: '7a62e18619d7b2a0d8ae8a45490ac359c411060f2f12bfd9226df22409647d7a',
     x86_64: '7bd541c80794a1258850721b86f090765c4a5965ad0e6036f03a08e3670946cc'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gnutls' => :library
  depends_on 'openssl' => :library

  cmake_options '-DENABLE_GNUTLS=ON \
                 -DENABLE_LIB_ONLY=ON'
end
