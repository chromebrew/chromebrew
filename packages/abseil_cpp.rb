require 'buildsystems/cmake'

class Abseil_cpp < CMake
  description 'Abseil Common Libraries C++'
  homepage 'https://abseil.io/'
  version '20250127.1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/abseil/abseil-cpp.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '38591a94d29aa2d9f3aaaff1e9aae3ae3365dfa528d190260049b8d497c4d5d3',
     armv7l: '38591a94d29aa2d9f3aaaff1e9aae3ae3365dfa528d190260049b8d497c4d5d3',
       i686: '999225ef6c27d49fb99fbb4617989147b8773fe3e05083327f06e14e86fc755a',
     x86_64: 'd7152997112ed202a94493f3148f588660154287b052ec1c02462840a1e8155a'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glibc_lib' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
