# Adapted from Arch Linux libnghttp3 PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/libnghttp3/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Libnghttp3 < CMake
  description 'HTTP/3 library written in C'
  homepage 'https://github.com/ngtcp2/nghttp3'
  version '1.14.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ngtcp2/nghttp3.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3913edb2ccfc9f30999fd1310569ab7a3657504c4faf9d75cd9c9c986033c3be',
     armv7l: '3913edb2ccfc9f30999fd1310569ab7a3657504c4faf9d75cd9c9c986033c3be',
       i686: 'e25a068ec5d1d1874f2088bb24c5e912bb57970f6ede442dd7795b9c5b4bd6ef',
     x86_64: '712ae73912e36ad90be54d97e2e341b42b155163d5ab24bdbeb74d9eee66d4f8'
  })

  depends_on 'glibc' # R

  cmake_options '-DENABLE_LIB_ONLY=ON'
end
