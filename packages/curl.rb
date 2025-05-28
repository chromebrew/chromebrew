require 'buildsystems/autotools'

class Curl < Autotools
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '8.13.0'
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{version}.tar.xz"
  source_sha256 'db59cf0d671ca6e7f5c2c5ec177084a33a79e04c97e71cf183a5cdea235054eb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '11f665a402f54135cc15e450c58a06c7fa121dbea6d3f534b2da9a77b42362a5',
     armv7l: '11f665a402f54135cc15e450c58a06c7fa121dbea6d3f534b2da9a77b42362a5',
       i686: '9dff2655022ac59244256fb70ae9ba17302ac5bbff06284c9c3af3f85389bb0a',
     x86_64: 'ea62c232c4d23962d81c5c9f680137f6de9d3a4c3ebf674780e437619655513b'
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
  depends_on 'valgrind' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  autotools_configure_options "--disable-maintainer-mode \
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
