require 'buildsystems/cmake'

class Abseil_cpp < CMake
  description 'Abseil Common Libraries C++'
  homepage 'https://abseil.io/'
  version '20250512.1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/abseil/abseil-cpp.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a4f109d7d7bc78f3663934357e9885bc7e1fd6dd3210a6f2f0191d9172c9b3af',
     armv7l: 'a4f109d7d7bc78f3663934357e9885bc7e1fd6dd3210a6f2f0191d9172c9b3af',
       i686: 'cb9e9f53f91259a35876156ddc1eea770814c3f0f5fb87e46f8cdeee3fc60a5b',
     x86_64: 'ba62e359590d23b9adce63d76e6ac338ec4fe436f7820df99bb388d1cdbfa1eb'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
