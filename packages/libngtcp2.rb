# Adapted from Arch Linux libngtcp2 PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/libngtcp2/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Libngtcp2 < CMake
  description 'Implementation of IETF QUIC protocol'
  homepage 'https://github.com/ngtcp2/ngtcp2'
  version '1.19.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ngtcp2/ngtcp2.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ac69bc21fba18b099638d7373ccbb365623607bf2685270842d0a89a26f37117',
     armv7l: 'ac69bc21fba18b099638d7373ccbb365623607bf2685270842d0a89a26f37117',
       i686: '0e5996796be3853c798953acf4b42a4aeb1375a7231857299f82025d79d1418d',
     x86_64: '147c76874741ed2d9e3f6d7f52602781e2e6a0c92f56bfdb71a9d8896e892091'
  })

  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'openssl' # R

  cmake_options '-DENABLE_GNUTLS=ON \
                 -DENABLE_LIB_ONLY=ON'
end
