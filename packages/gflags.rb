require 'buildsystems/cmake'

class Gflags < CMake
  description 'C++ library that implements commandline flags processing'
  homepage 'https://gflags.github.io/gflags/'
  version '2.3.0'
  license 'BSD-3 Clause'
  compatibility 'all'
  source_url 'https://github.com/gflags/gflags.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3b9ae630e0eda5c6a270644f860cc6218ca6a21cb62f5795b51b5ddd745317a2',
     armv7l: '3b9ae630e0eda5c6a270644f860cc6218ca6a21cb62f5795b51b5ddd745317a2',
       i686: '32d97b57e7a03528de9e58208f3f4b58a0b33888f35689394893452c9cdf8f84',
     x86_64: '0802944972dfddee0cce69d5c6e011f946c4d2df73be827481dc3ec60f1d1ea5'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options "-DBUILD_SHARED_LIBS=ON -DLIBRARY_INSTALL_DIR=#{CREW_LIB_PREFIX}"
end
