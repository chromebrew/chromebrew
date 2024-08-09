require 'buildsystems/cmake'

class Libmbedtls < CMake
  description 'An open source, portable, easy to use, readable and flexible SSL library'
  homepage 'https://www.trustedfirmware.org/projects/mbed-tls/'
  version '3.6.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/ARMmbed/mbedtls.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c96084c1a2d4b6781c349b1242a1cdeb156e789aebd74685ac1630bfc7fd68db',
     armv7l: 'c96084c1a2d4b6781c349b1242a1cdeb156e789aebd74685ac1630bfc7fd68db',
       i686: '026d9cffdfe2d199a6c291b2e4a3f1d441a0f10c04f068ad7f9533544d492051',
     x86_64: '45cab571d615d7efe2a550a6647bbef370ea53d7cde330f5cf604d13ba2d869e'
  })

  depends_on 'glibc' # R
  run_tests

  cmake_options '-DUSE_SHARED_MBEDTLS_LIBRARY=ON'
end
