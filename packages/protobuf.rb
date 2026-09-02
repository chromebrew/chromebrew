# Adapted from Arch Linux protobuf PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/protobuf/trunk/PKGBUILD

require 'buildsystems/cmake'

class Protobuf < CMake
  description 'Protocol Buffers - Googles data interchange format'
  homepage 'https://protobuf.dev'
  version '36.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/protocolbuffers/protobuf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0a5b24365d8248c78cb2ad4f2cc4c6128f506e3de4003136ede38ffb3a8fe857',
     armv7l: '0a5b24365d8248c78cb2ad4f2cc4c6128f506e3de4003136ede38ffb3a8fe857',
       i686: '60e56b70bbe957308eba34173f5027883362d610039f793f55936a395f97438b',
     x86_64: '27e0e59412af5e226f8eb43c4fe376da166e9950122a218558d4c961e23664dd'
  })

  depends_on 'abseil_cpp' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'zlib' => :library

  cmake_options '-Dprotobuf_BUILD_SHARED_LIBS=ON \
      -Dprotobuf_BUILD_TESTS=OFF'
end
