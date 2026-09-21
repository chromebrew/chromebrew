require 'buildsystems/autotools'

class Apr < Autotools
  description 'The mission of the Apache Portable Runtime (APR) project is to create and maintain software libraries that provide a predictable and consistent interface to underlying platform-specific implementations.  APR is the base portability library.'
  homepage 'https://apr.apache.org/'
  version '1.7.6'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://dlcdn.apache.org/apr/apr-#{version}.tar.bz2"
  source_sha256 '49030d92d2575da735791b496dc322f3ce5cff9494779ba8cc28c7f46c5deb32'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '53442ad137b59954d4001cb0c0fe83fe5843e2ec41b14947433ca8faca2031e0',
     armv7l: '53442ad137b59954d4001cb0c0fe83fe5843e2ec41b14947433ca8faca2031e0',
       i686: '06d7b88a5aea1c5f0dc189006056cae282d33f9ab037d748531d760a95b0bd70',
     x86_64: '1a528307e55d4bbbbd8d6c18a8c51c5f3419d1fe9262563a67bffc229ee71d4c'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libuuid' => :library
  depends_on 'libxcrypt' => :library
  depends_on 'util_linux' => :library

  autotools_configure_options '--with-devrandom --without-sendfile --enable-layout=GNU'
end
