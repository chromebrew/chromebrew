require 'buildsystems/cmake'

class Snappy < CMake
  description 'Snappy, a fast compressor/decompressor.'
  homepage 'https://github.com/google/snappy'
  version '1.2.2'
  license 'GPL-2 and LGPL-2'
  compatibility 'all'
  source_url 'https://github.com/google/snappy.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '697cff1e0c956c29d65d690a5440aee2f38fe3d9d02bab13396cf3744cb04a66',
     armv7l: '697cff1e0c956c29d65d690a5440aee2f38fe3d9d02bab13396cf3744cb04a66',
       i686: 'b9cb1f83e790e0307cbe2e8d51474a76bfb5e77068f2bcc8ca3affbe4b0460c5',
     x86_64: 'da62465a10ede8e2ce13fc5e4228af137377ef7ebb6e4e219b3031ffe1578872'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'llvm_dev' => :build
  depends_on 'lzo' => :library

  cmake_options '-DBUILD_SHARED_LIBS=ON -DSNAPPY_BUILD_TESTS=OFF' # Tests don't work on ARM
end
