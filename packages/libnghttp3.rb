# Adapted from Arch Linux libnghttp3 PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/libnghttp3/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Libnghttp3 < CMake
  description 'HTTP/3 library written in C'
  homepage 'https://github.com/ngtcp2/nghttp3'
  version '1.11.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ngtcp2/nghttp3.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6e6a7234d009a57ac34176442bc96e1bb9849da3e48e00705edfc08098675871',
     armv7l: '6e6a7234d009a57ac34176442bc96e1bb9849da3e48e00705edfc08098675871',
       i686: '1c021e05149f9f58b57ddab0b872cb61d2468147ea771d3dc4f9ce17d048c6d3',
     x86_64: '7c8cde6fbcc3e33ce7c3dfcfff6d028eef2df5a92c56d80e560fa6277747e880'
  })

  depends_on 'glibc' # R

  cmake_options '-DENABLE_LIB_ONLY=ON'
end
