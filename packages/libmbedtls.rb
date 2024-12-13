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
    aarch64: 'f4f94256f39201657f86105891b4be02fa87efb92f1c25b36867a4057fe4462c',
     armv7l: 'f4f94256f39201657f86105891b4be02fa87efb92f1c25b36867a4057fe4462c',
       i686: 'ca6a29c8f2891016908c259751a504019cab5d52c01a95562b63da03617da72c',
     x86_64: '24aaf1c149f5f24d317f09a46d466c595e180efe1877b7e0d4e1dc30811f5722'
  })

  depends_on 'glibc' # R
  run_tests

  cmake_options '-DUSE_SHARED_MBEDTLS_LIBRARY=ON'
end
