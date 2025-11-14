# Adapted from Arch Linux libngtcp2 PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/libngtcp2/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Libngtcp2 < CMake
  description 'Implementation of IETF QUIC protocol'
  homepage 'https://github.com/ngtcp2/ngtcp2'
  version '1.17.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ngtcp2/ngtcp2.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '33cd334939c5c03230468b0a9c542ddc0bbabd2d7679078d95334c6ddef92228',
     armv7l: '33cd334939c5c03230468b0a9c542ddc0bbabd2d7679078d95334c6ddef92228',
       i686: 'b5f41bef0676f0dbc3eb49dd757b563b2ee8a376dcaf0fc9bd80dcaeee0608f8',
     x86_64: '17ba79d8e56fb1a109bc3cbb74fcdcaac51a9b8bfe7c948e0852999eebec240f'
  })

  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'openssl' # R

  cmake_options '-DENABLE_GNUTLS=ON \
                 -DENABLE_LIB_ONLY=ON'
end
