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
    aarch64: '39944f81637d5dd147e8146208216fdad0e63b58b90b224ae20d78682341699e',
     armv7l: '39944f81637d5dd147e8146208216fdad0e63b58b90b224ae20d78682341699e',
       i686: '2ee2644f6bf541a4596de2c3591acb591f2a181526641e7aa344911f54b2577d',
     x86_64: 'b8082671c88e336bff4922e51422f2ce5e861a9a63056b2b9296ae3dbc404024'
  })

  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'openssl' # R

  cmake_options '-DENABLE_GNUTLS=ON \
                 -DENABLE_LIB_ONLY=ON'
end
