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
    aarch64: '8570203a9c1b5987518e7e1e899913d624088fe44e5a19786afef062636e09b1',
     armv7l: '8570203a9c1b5987518e7e1e899913d624088fe44e5a19786afef062636e09b1',
       i686: '2ab9b11462515926edd8cd6653ef58a30fc67b9297c7dc24e5a3f7636f90fa08',
     x86_64: 'e3e1101d5533fc7c499a91edb2900162b42124e1a074d24a8fd2525096838f48'
  })

  depends_on 'abseil_cpp' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'zlib' => :library

  cmake_options '-Dprotobuf_BUILD_SHARED_LIBS=ON \
      -Dprotobuf_BUILD_TESTS=OFF'
end
