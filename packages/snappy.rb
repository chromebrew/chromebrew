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
    aarch64: 'fbc02c16f466c8b04025f55c72716d97318de888dfab1151dad3476e3f7dc3a8',
     armv7l: 'fbc02c16f466c8b04025f55c72716d97318de888dfab1151dad3476e3f7dc3a8',
       i686: '2c21491abf010a76bdff7092a0071ff16bb116007581e14058e1e75ef04f2972',
     x86_64: '6a1897e565809ec90eccc647c30486b16bf22b130c5d2f67dd8d6e9941f417b9'
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
