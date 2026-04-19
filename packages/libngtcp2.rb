# Adapted from Arch Linux libngtcp2 PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/libngtcp2/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Libngtcp2 < CMake
  description 'Implementation of IETF QUIC protocol'
  homepage 'https://github.com/ngtcp2/ngtcp2'
  version '1.22.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ngtcp2/ngtcp2.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5523a6b9ee75eb6b470d7ce72182af81d94190ae2e4f97481775c0ecf292805a',
     armv7l: '5523a6b9ee75eb6b470d7ce72182af81d94190ae2e4f97481775c0ecf292805a',
       i686: '50288151d6f107ee0adcbc6d528ba6d5175198e7adc88ce60134505a4082ee74',
     x86_64: '40504529e94d38c167134ec2bf28ae04403046ee82ca7357bfbc216503e6aafd'
  })

  depends_on 'glibc' => :library
  depends_on 'gnutls' => :library
  depends_on 'openssl' => :library

  cmake_options '-DENABLE_GNUTLS=ON \
                 -DENABLE_LIB_ONLY=ON'
end
