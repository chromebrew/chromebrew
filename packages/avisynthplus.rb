require 'buildsystems/cmake'

class Avisynthplus < CMake
  description 'An improved version of the AviSynth frameserver'
  homepage 'https://avs-plus.net/'
  version '3.7.5'
  license 'GPL-2 and GPL-2-with-linking-exception'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/AviSynth/AviSynthPlus.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8239f7b0814733343fd22fd41de3407abe5fcb0b73eb2372612f298f3826f2ce',
     armv7l: '8239f7b0814733343fd22fd41de3407abe5fcb0b73eb2372612f298f3826f2ce',
     x86_64: 'a9bafe0da24f8f94d6edd1614d31bd5cf4ac25e194e81730dde09d5ba601df8d'
  })

  depends_on 'devil' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  git_fetchtags

  cmake_options "-DCMAKE_BUILD_TYPE:STRING='None'"
end
