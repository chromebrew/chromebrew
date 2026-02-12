require 'buildsystems/cmake'

class Abseil_cpp < CMake
  description 'Abseil Common Libraries C++'
  homepage 'https://abseil.io/'
  version '20260107.1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/abseil/abseil-cpp.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cdcd076ce54bd07dbc52a2cc138ed14646fd93e8f7a1f4f88a8d0fc4ef51fced',
     armv7l: 'cdcd076ce54bd07dbc52a2cc138ed14646fd93e8f7a1f4f88a8d0fc4ef51fced',
       i686: '7c2d3bbe606941acbf0980f1ffa493ea93684a47e403a3588845884818050804',
     x86_64: '548b1c0158896314545442212543cf304fc582e27fe3eb60f54c8695035f8791'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
