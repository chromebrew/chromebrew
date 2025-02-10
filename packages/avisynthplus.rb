require 'buildsystems/cmake'

class Avisynthplus < CMake
  description 'An improved version of the AviSynth frameserver'
  homepage 'https://avs-plus.net/'
  version '3.7.3'
  license 'GPL-2 and GPL-2-with-linking-exception'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/AviSynth/AviSynthPlus.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b9e247846b433bd2e1767f268bf34a22860e0a18a29e45528aabf8b32725f6e2',
     armv7l: 'b9e247846b433bd2e1767f268bf34a22860e0a18a29e45528aabf8b32725f6e2',
     x86_64: '2e7cd1267ae94d155abc1e9890f484a08a8eeb0ea75473d4875431316ae23471'
  })

  depends_on 'devil' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  git_fetchtags

  cmake_options "-DCMAKE_BUILD_TYPE:STRING='None'"
end
