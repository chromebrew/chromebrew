# Adapted from Arch Linux protobuf PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/protobuf/trunk/PKGBUILD

require 'buildsystems/cmake'

class Protobuf < CMake
  description 'Protocol Buffers - Googles data interchange format'
  homepage 'https://protobuf.dev'
  version '36.2'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/protocolbuffers/protobuf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7b3d2cf7aa68fa209900fae4c3fe32f300493cb562fb6d0b14a97ba8fd735532',
     armv7l: '7b3d2cf7aa68fa209900fae4c3fe32f300493cb562fb6d0b14a97ba8fd735532',
       i686: '38c4ca56ad2345a48a617689ebfe49a8af6031a2f24df76c5e84fe33e96095b9',
     x86_64: '2071749c3f03ca1d71d34a34f01a85d0dd3b7a6225c074cc5b87895e4868846a'
  })

  depends_on 'abseil_cpp' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'zlib' => :library

  cmake_options '-Dprotobuf_BUILD_SHARED_LIBS=ON \
      -Dprotobuf_BUILD_TESTS=OFF'
end
