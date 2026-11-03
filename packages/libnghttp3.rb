# Adapted from Arch Linux libnghttp3 PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/libnghttp3/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Libnghttp3 < CMake
  description 'HTTP/3 library written in C'
  homepage 'https://github.com/ngtcp2/nghttp3'
  version '1.19.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ngtcp2/nghttp3.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '43a1aabd0c85afba425942ba6ef7ca5dd90b4c68258d7c9af9eebef92cfd4a09',
     armv7l: '43a1aabd0c85afba425942ba6ef7ca5dd90b4c68258d7c9af9eebef92cfd4a09',
       i686: '75671e1df472a313ada228b8de494c33248581ec6e98b6fd24252cf7cda7f4ef',
     x86_64: '29dacdcd2352dd9dd490da2006fc5b341da22f161add18314dc05f737748915f'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DENABLE_LIB_ONLY=ON'
end
