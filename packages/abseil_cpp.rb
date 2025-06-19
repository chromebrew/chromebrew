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
    aarch64: '484170c836b77904163c18df167bcdec8e8e6d85d3991a605ad38c4b4f26e88d',
     armv7l: '484170c836b77904163c18df167bcdec8e8e6d85d3991a605ad38c4b4f26e88d',
       i686: 'cb9e9f53f91259a35876156ddc1eea770814c3f0f5fb87e46f8cdeee3fc60a5b',
     x86_64: '65473b684dbcb845954e67589124787303d5e977dc892bf2b0b1a2237b558731'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
