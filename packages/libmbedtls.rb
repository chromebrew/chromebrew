require 'buildsystems/cmake'

class Libmbedtls < CMake
  description 'An open source, portable, easy to use, readable and flexible SSL library'
  homepage 'https://www.trustedfirmware.org/projects/mbed-tls/'
  version '3.6.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/ARMmbed/mbedtls.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fb5f733356acdd57769af17d70d3369b2deb38ce130360ccbcd8a065ff61103e',
     armv7l: 'fb5f733356acdd57769af17d70d3369b2deb38ce130360ccbcd8a065ff61103e',
       i686: 'ca6a29c8f2891016908c259751a504019cab5d52c01a95562b63da03617da72c',
     x86_64: '24aaf1c149f5f24d317f09a46d466c595e180efe1877b7e0d4e1dc30811f5722'
  })

  depends_on 'glibc' # R
  run_tests

  cmake_options '-DUSE_SHARED_MBEDTLS_LIBRARY=ON'
end
