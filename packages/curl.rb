require 'buildsystems/autotools'

class Curl < Autotools
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '8.20.0'
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{version}.tar.xz"
  source_sha256 '63fe2dc148ba0ceae89922ef838f7e5c946272c2e78b7c59fab4b79d3ce2b896'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '20dabf4158711bc0bb8120ce447acb67feb971ca6670373e49bddacc64e23eb7',
     armv7l: '20dabf4158711bc0bb8120ce447acb67feb971ca6670373e49bddacc64e23eb7',
       i686: 'a8b5ec4aeb04594cc19fde7c3b3cbb27a0f71957cc33542c0875aba31ddd358a',
     x86_64: '154ab653b496e9cf11f3fd5391236e0ae33f9cc7e4589d6fcf4990c51c5e83f9'
  })

  depends_on 'brotli' => :library
  depends_on 'c_ares' => :library
  depends_on 'ca_certificates' => :build
  depends_on 'glibc' => :library
  depends_on 'libidn2' => :library
  depends_on 'libnghttp2' => :library
  depends_on 'libnghttp3' => :library
  depends_on 'libngtcp2' => :library
  depends_on 'libpsl' => :library
  depends_on 'libssh' => :library
  depends_on 'openldap' => :library
  depends_on 'openssl' => :library
  depends_on 'python3' => :build
  depends_on 'valgrind' => :build
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  autotools_configure_options "--disable-maintainer-mode \
      --enable-ares \
      --enable-ipv6 \
      --enable-ldap \
      --enable-unix-sockets \
      --with-ca-bundle=#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt \
      --with-ca-fallback \
      --with-ca-path=#{CREW_PREFIX}/etc/ssl/certs \
      --with-libssh \
      --with-ngtcp2 \
      --with-openssl \
      --without-gnutls \
      --without-librtmp"
end
