require 'buildsystems/autotools'

class Curl < Autotools
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '8.9.0'
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{version}.tar.xz"
  source_sha256 'ff09b2791ca56d25fd5c3f3a4927dce7c8a9dc4182200c487ca889fba1fdd412'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '36b8f3b94164194710978266294875a01e3288e4491daa2277d7ed9be1da5e24',
     armv7l: '36b8f3b94164194710978266294875a01e3288e4491daa2277d7ed9be1da5e24',
       i686: '416d675866cd8bd791d75600af188a960481a5ff29fd23e30bd20164e2fa54c6',
     x86_64: '314eb42861a405eaf15223136fe56fd67243779dd945005a5e12532d8dfec37f'
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
