# Adapted from Arch Linux libnghttp3 PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/libnghttp3/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Libnghttp3 < CMake
  description 'HTTP/3 library written in C'
  homepage 'https://github.com/ngtcp2/nghttp3'
  version '1.17.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ngtcp2/nghttp3.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '615806c1cc1dbdf27d32805ec69367f680cd04e772b6c2c491349dd238b8c422',
     armv7l: '615806c1cc1dbdf27d32805ec69367f680cd04e772b6c2c491349dd238b8c422',
       i686: '232bc7dc3d5ad979f9b31bc029c1843a72420f38416fedb9f9d89fe17abe9965',
     x86_64: 'c42bc6af7104b8a3d8101e177634b568185996f0cbdaf43c87d5b2ba71b7e6cb'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DENABLE_LIB_ONLY=ON'
end
