# Adapted from Arch Linux libnghttp3 PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/libnghttp3/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Libnghttp3 < CMake
  description 'HTTP/3 library written in C'
  homepage 'https://github.com/ngtcp2/nghttp3'
  version '1.16.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ngtcp2/nghttp3.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '00fb397f432223b44a55199bd6999f9509e7b5f6a87b2900fdb1fe8844d5c296',
     armv7l: '00fb397f432223b44a55199bd6999f9509e7b5f6a87b2900fdb1fe8844d5c296',
       i686: '5d4dadf554caed6312ff225cd9071906433a453d83ac3a3ed4d2d364b29d3f4a',
     x86_64: '24473bb00886d715a7a5663db7c236dafdac02343228c121dfa3b6546b4310a8'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DENABLE_LIB_ONLY=ON'
end
