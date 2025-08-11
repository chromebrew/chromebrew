require 'buildsystems/autotools'

class Apr < Autotools
  description 'The mission of the Apache Portable Runtime (APR) project is to create and maintain software libraries that provide a predictable and consistent interface to underlying platform-specific implementations.  APR is the base portability library.'
  homepage 'https://apr.apache.org/'
  version '1.7.6'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://dlcdn.apache.org/apr/apr-#{version}.tar.bz2"
  source_sha256 'cd0f5d52b9ab1704c72160c5ee3ed5d3d4ca2df4a7f8ab564e3cb352b67232f2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '28bd15d172f57909efe2fade0c25af4316a44d3ea5b0d4df1f93ec608f534906',
     armv7l: '28bd15d172f57909efe2fade0c25af4316a44d3ea5b0d4df1f93ec608f534906',
       i686: '2037238577fa8a8d7e72b57279b32515d2671373192d47b0640eb0775cf59ae8',
     x86_64: '5b2e09195e72389434de99d622d80d15923c53834e4f2cfe0e58e1793e977a6a'
  })

  depends_on 'glibc' # R
  depends_on 'libxcrypt' # R
  depends_on 'util_linux' # R

  autotools_configure_options '--with-devrandom --without-sendfile --enable-layout=GNU'
end
