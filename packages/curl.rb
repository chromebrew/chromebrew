require 'buildsystems/autotools'

class Curl < Autotools
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '8.23.0'
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{version}.tar.xz"
  source_sha256 '8dadd7d2536a314f982ad05a651b713f426bf7d02cc2c76cffb9796f2218e6c5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6886697cbde4c887c629e36eda7328faa54886790e6461f58a18e149fa70a219',
     armv7l: '6886697cbde4c887c629e36eda7328faa54886790e6461f58a18e149fa70a219',
       i686: '22ab0d1c55c99668224239c175958f11a4264d48e6fd42be36b6d4effb7ae8d6',
     x86_64: '785be4376d37206c91c6a0c38e5fc2450038eda799f399f1edc40ae961c2d014'
  })

  depends_on 'brotli' => :library
  depends_on 'c_ares' => :library
  depends_on 'ca_certificates' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libcyrussasl' => :executable
  depends_on 'libcyrussasl' => :library
  depends_on 'libidn2' => :library
  depends_on 'libnghttp2' => :library
  depends_on 'libnghttp3' => :library
  depends_on 'libngtcp2' => :library
  depends_on 'libpsl' => :library
  depends_on 'libssh' => :library
  depends_on 'libunistring' => :executable
  depends_on 'libunistring' => :library
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
      --with-ca-embed=#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt \
      --with-ca-bundle=#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt \
      --with-ca-fallback \
      --with-ca-path=#{CREW_PREFIX}/etc/ssl/certs \
      --with-libssh \
      --with-ngtcp2 \
      --with-openssl \
      --without-gnutls \
      --without-librtmp"
end
