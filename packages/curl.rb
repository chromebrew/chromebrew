require 'buildsystems/autotools'

class Curl < Autotools
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '8.17.0-1'
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{version.split('-').first}.tar.xz"
  source_sha256 '955f6e729ad6b3566260e8fef68620e76ba3c31acf0a18524416a185acf77992'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '59ca4a5f0a55d4b0854b94a9221b781c68bd39e762a6193459ddb392e37cfca7',
     armv7l: '59ca4a5f0a55d4b0854b94a9221b781c68bd39e762a6193459ddb392e37cfca7',
       i686: '48bcb46c76c33a7eec4b046e242ea4c0eda448ef8af2c94e3e3966cdc6fd3660',
     x86_64: 'e90d023bf210a57f7e7df6d4a2f6e1e7d7e8e9f12121426ea7f39c28b60caf53'
  })

  depends_on 'brotli' # R
  depends_on 'c_ares' # R
  depends_on 'ca_certificates' => :build
  depends_on 'glibc' # R
  depends_on 'libidn2' # R
  depends_on 'libnghttp2' # R
  depends_on 'libnghttp3' => :build
  depends_on 'libngtcp2' => :build
  depends_on 'libpsl' # R
  depends_on 'libssh' # R
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
      --with-ngtcp2 \
      --with-openssl \
      --without-gnutls \
      --without-librtmp"
end
