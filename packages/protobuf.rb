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
    aarch64: '3376c146408171779436809fb61633280e9c551dbe222dc2e21bb4d742957dc9',
     armv7l: '3376c146408171779436809fb61633280e9c551dbe222dc2e21bb4d742957dc9',
       i686: '45cd422ea011e3fc32215103a70ba7fc13ee1af79732f100d14886f58169ae38',
     x86_64: 'e7185a2d95141fcf4f0f83dd0aaea6d797ee843f8a336018f088020381822afc'
  })

  depends_on 'abseil_cpp' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'zlib' => :library

  cmake_options '-Dprotobuf_BUILD_SHARED_LIBS=ON \
      -Dprotobuf_BUILD_TESTS=OFF'
end
