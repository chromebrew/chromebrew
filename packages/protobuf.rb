# Adapted from Arch Linux protobuf PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/protobuf/trunk/PKGBUILD

require 'buildsystems/cmake'

class Protobuf < CMake
  description 'Protocol Buffers - Googles data interchange format'
  homepage 'https://protobuf.dev'
  version '35.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/protocolbuffers/protobuf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a0625337f2e7b87d4e788d5fc01497f47b45cdc93548509d17517f767b9c027e',
     armv7l: 'a0625337f2e7b87d4e788d5fc01497f47b45cdc93548509d17517f767b9c027e',
       i686: '6f9ff99791e646b0ac6740330f30bdf42ed500a3a3eea5cc2b82234abd8e05ae',
     x86_64: '35fb6139efb5f82631ec075e1dd09ef20585927cd9fc9e7eced178738b0a1d11'
  })

  depends_on 'abseil_cpp' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'zlib' => :library

  cmake_options '-Dprotobuf_BUILD_SHARED_LIBS=ON \
      -Dprotobuf_BUILD_TESTS=OFF'
end
