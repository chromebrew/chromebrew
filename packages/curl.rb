require 'buildsystems/autotools'

class Curl < Autotools
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '8.11.0'
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{version}.tar.xz"
  source_sha256 'db59cf0d671ca6e7f5c2c5ec177084a33a79e04c97e71cf183a5cdea235054eb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '727abcee508de3e90555fbc5860df10ffa335cf311ee01b91d7141cb57344004',
     armv7l: '727abcee508de3e90555fbc5860df10ffa335cf311ee01b91d7141cb57344004',
       i686: 'e74ffa56345eaf157ac5c772a90791f37bc000cbfb86ae132198ac284e041ed0',
     x86_64: '7ad1b05d1122945ce58ef893a85101a1ece1a7ee02969f0652f209f5a086b38d'
  })

  depends_on 'brotli' # R
  depends_on 'ca_certificates' => :build
  depends_on 'c_ares' # R
  depends_on 'glibc' # R
  depends_on 'libcyrussasl' # R
  depends_on 'libidn2' # R
  depends_on 'libnghttp2' # R
  depends_on 'libpsl' # R
  depends_on 'libssh' # R
  depends_on 'libunistring' # R
  depends_on 'openldap' # R
  depends_on 'openssl' # R
  depends_on 'python3' => :build
  depends_on 'rust' => :build
  depends_on 'valgrind' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  configure_options "--disable-maintainer-mode \
      --enable-ares \
      --enable-ipv6 \
      --enable-ldap \
      --enable-unix-sockets \
      --with-ca-bundle=#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt \
      --with-ca-fallback \
      --with-ca-path=#{CREW_PREFIX}/etc/ssl/certs \
      --with-libssh \
      --with-openssl \
      --without-gnutls \
      --without-librtmp"
end
