require 'buildsystems/cmake'

class Abseil_cpp < CMake
  description 'Abseil Common Libraries C++'
  homepage 'https://abseil.io/'
  version '20260107.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/abseil/abseil-cpp.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a86425c2cfe0b491c408400e1fd6d8801a1a041ccd83598c98dc8b63075cd701',
     armv7l: 'a86425c2cfe0b491c408400e1fd6d8801a1a041ccd83598c98dc8b63075cd701',
       i686: '9d9bc900239d9d1755f1bef55c9622c8db0cfd89056a4d28bb46f020dfc5fb6f',
     x86_64: 'f95c1a5898d0e7a8a5eb8fe93434a7edae83abc7cdbb3ad2f9f55bd2d3a7d21b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
