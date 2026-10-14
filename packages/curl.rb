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
    aarch64: 'b6706f1913bce2cc66b09a58495feccd09be5579a55a557db287ca0c806e7628',
     armv7l: 'b6706f1913bce2cc66b09a58495feccd09be5579a55a557db287ca0c806e7628',
       i686: 'b8825eba5f4c86f94fdb7e4d94ec2e66b65356af0ed7162cde177f0ade9d2d79',
     x86_64: '383b66e71d67736006316e743189f109550ae279d80681923fe5019b3489bb2e'
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
      --with-ca-bundle=#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt \
      --with-ca-fallback \
      --with-ca-path=#{CREW_PREFIX}/etc/ssl/certs \
      --with-libssh \
      --with-ngtcp2 \
      --with-openssl \
      --without-gnutls \
      --without-librtmp"
end
