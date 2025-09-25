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
    aarch64: 'e614cbdbba9b8c2bd5a63122fe2662b961e4a05aaef1f8e78e191f6ff34d2169',
     armv7l: 'e614cbdbba9b8c2bd5a63122fe2662b961e4a05aaef1f8e78e191f6ff34d2169',
       i686: '6a353295c0aec7155d96c432d40408d146012f4c95c9357e67be5a2a4db79a65',
     x86_64: '91ae00d0036b90e0a8ab460b3a4d8172177d3ee063d27b35ed511981b84af0c3'
  })

  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'openssl' # R

  cmake_options '-DENABLE_GNUTLS=ON \
                 -DENABLE_LIB_ONLY=ON'
end
