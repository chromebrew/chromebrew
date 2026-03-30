# Adapted from Arch Linux libngtcp2 PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/libngtcp2/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Libngtcp2 < CMake
  description 'Implementation of IETF QUIC protocol'
  homepage 'https://github.com/ngtcp2/ngtcp2'
  version '1.22.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ngtcp2/ngtcp2.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '49fa34e1fd0ff723b4a7a425e7819fc657098d464b985581fb0b29c7a92dddba',
     armv7l: '49fa34e1fd0ff723b4a7a425e7819fc657098d464b985581fb0b29c7a92dddba',
       i686: '9446d1a8914ee5ad3d729c751e606543fa1fb78d808f7acb51f19556fa96185a',
     x86_64: 'ba45841e77c88a2bb50f18d41a802e49d77e5e6d9338811c5e7a9b4542054cd1'
  })

  depends_on 'glibc' => :library
  depends_on 'gnutls' => :library
  depends_on 'openssl' => :library

  cmake_options '-DENABLE_GNUTLS=ON \
                 -DENABLE_LIB_ONLY=ON'
end
