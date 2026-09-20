require 'buildsystems/cmake'

class Snappy < CMake
  description 'Snappy, a fast compressor/decompressor.'
  homepage 'https://github.com/google/snappy'
  version '1.3.1'
  license 'GPL-2 and LGPL-2'
  compatibility 'all'
  source_url 'https://github.com/google/snappy.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a2a4b52393f474df084a112bcac4c40a19b170c34b6f8b4cdc6e40fc7e62d4d5',
     armv7l: 'a2a4b52393f474df084a112bcac4c40a19b170c34b6f8b4cdc6e40fc7e62d4d5',
       i686: '7d6efa3cd11368767a3c8eff5c0d8f1051d135e4679f8b8f86359b41a817b224',
     x86_64: 'e5a1292cd7da7738852e2ca2261bfe3d898bf411593bf2f962d5728c824a91c1'
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
