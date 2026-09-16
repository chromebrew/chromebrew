require 'buildsystems/cmake'

class Libcpuid < CMake
  description 'libcpuid is a small C library for x86 CPU detection and feature extraction.'
  homepage 'https://libcpuid.sourceforge.net/'
  version '0.8.2'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/anrieff/libcpuid.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
       i686: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })

  depends_on 'glibc' # R

  run_tests
end
