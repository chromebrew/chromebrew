require 'buildsystems/autotools'

class Curl < Autotools
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '8.12.0'
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{version}.tar.xz"
  source_sha256 'db59cf0d671ca6e7f5c2c5ec177084a33a79e04c97e71cf183a5cdea235054eb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8647e8fb9fffb438d432e23aad432f7138658b6f150a5446c83c24e6bee816a1',
     armv7l: '8647e8fb9fffb438d432e23aad432f7138658b6f150a5446c83c24e6bee816a1',
       i686: 'ce575910204e257231d6e045d0e5633cf90bd00b34c575d2a0576c628234c956',
     x86_64: '2ac3615eec384ef6981ba103e337c033a28a95d6ade77c1fd6377fbe4bbc7341'
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
