require 'buildsystems/autotools'

class Curl < Autotools
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '8.14.0'
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{version}.tar.xz"
  source_sha256 'b3634cfc538c72c9c6ca794ef4c73d7fdbd171e8dee2db837d83a5e45231002a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b5136f631f2f690688c4438946818936011b6ec6f1e7449a98a9f62225c6b468',
     armv7l: 'b5136f631f2f690688c4438946818936011b6ec6f1e7449a98a9f62225c6b468',
       i686: 'aeab345929d07dfd30c9eb8ff94ec1289d38f66816c46e025c9469ac6b6e3966',
     x86_64: '6002f088f0dbb50a523f8a4e6d0bd9f9e8c3c8986f6ffae3fb5bbae2bce34dfc'
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
