# Adapted from Arch Linux protobuf PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/protobuf/trunk/PKGBUILD

require 'buildsystems/cmake'

class Protobuf < CMake
  description 'Protocol Buffers - Googles data interchange format'
  homepage 'https://protobuf.dev'
  version '34.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/protocolbuffers/protobuf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd1b61b0a83915ba73db53ed4d5502c6cf9cc4d830d224cf095a978fe26b1edcc',
     armv7l: 'd1b61b0a83915ba73db53ed4d5502c6cf9cc4d830d224cf095a978fe26b1edcc',
       i686: 'a174175902325e6d5e0f075eefdc952ecb5572aa77c9942d6709a92ac5e55bdb',
     x86_64: '4ccf08220f92413e8e38b415e6ba457fc7c290e50588707b8cc03683920b56bb'
  })

  depends_on 'abseil_cpp' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'zlib' => :library

  cmake_options '-Dprotobuf_BUILD_SHARED_LIBS=ON \
      -Dprotobuf_BUILD_TESTS=OFF'
end
