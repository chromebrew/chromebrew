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
    aarch64: 'fb5f733356acdd57769af17d70d3369b2deb38ce130360ccbcd8a065ff61103e',
     armv7l: 'fb5f733356acdd57769af17d70d3369b2deb38ce130360ccbcd8a065ff61103e',
       i686: '316dddb6af3d89939333d256d97a256ce31947cda68ee55035b89901d9d49839',
     x86_64: '4891dfd90df0c29e0646e27aceba87b8932e4b4a817ec995a928c82bcca5d7c9'
  })

  depends_on 'glibc' # R
  run_tests

  cmake_options '-DUSE_SHARED_MBEDTLS_LIBRARY=ON'
end
