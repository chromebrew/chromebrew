require 'buildsystems/cmake'

class Snappy < CMake
  description 'Snappy, a fast compressor/decompressor.'
  homepage 'https://github.com/google/snappy'
  version '1.3.0'
  license 'GPL-2 and LGPL-2'
  compatibility 'all'
  source_url 'https://github.com/google/snappy.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4d78506c356fb0909e939c5708a49a8027e567abd83bbb0847ad0620e8078af9',
     armv7l: '4d78506c356fb0909e939c5708a49a8027e567abd83bbb0847ad0620e8078af9',
       i686: 'd5f36003b8aa32ab3bdaefdd7943221e189703a2e708cbb1afaf4579fa24ac29',
     x86_64: 'cb44d8aae7101bfb6b3c5c0e5b1618626f5ff580703072c820450de8e287e35b'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'llvm_dev' => :build
  depends_on 'lzo' => :library

  cmake_options ' \
    -DBUILD_SHARED_LIBS=ON \
    -DBENCHMARK_ENABLE_INSTALL=OFF \
    -DSNAPPY_BUILD_TESTS=OFF' # Tests don't work on ARM
end
