require 'buildsystems/cmake'

class Abseil_cpp < CMake
  description 'Abseil Common Libraries C++'
  homepage 'https://abseil.io/'
  version '20260817.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/abseil/abseil-cpp.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a72018a6b0bf211b6cb363caaf6b672db15ece5d09631d45d240f1b82c21fce5',
     armv7l: 'a72018a6b0bf211b6cb363caaf6b672db15ece5d09631d45d240f1b82c21fce5',
       i686: 'bddc3a260d7426f0159da41a72979b2e0ffc59856c6be5b1b4f01e614b51a3aa',
     x86_64: 'be33a3a14b41cfc1830fb57fa2412174e0445e227535c0a3bc5fc2495ed0a41f'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
