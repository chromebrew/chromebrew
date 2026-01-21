# Adapted from Arch Linux libnghttp3 PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/libnghttp3/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Libnghttp3 < CMake
  description 'HTTP/3 library written in C'
  homepage 'https://github.com/ngtcp2/nghttp3'
  version '1.15.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ngtcp2/nghttp3.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ad3c8f414a89e649439c40ed63c2fdaae11661ae682a3c896e3ea9ed2a942685',
     armv7l: 'ad3c8f414a89e649439c40ed63c2fdaae11661ae682a3c896e3ea9ed2a942685',
       i686: 'bc80a5c0633ad52a977da4edef5ef53403a46b731ee801972a689d49089b95ee',
     x86_64: 'aa85bf3ee1aaf83522e145045f6960b32e6bf15ad53b855f7c515203bfbf9258'
  })

  depends_on 'glibc' # R

  cmake_options '-DENABLE_LIB_ONLY=ON'
end
