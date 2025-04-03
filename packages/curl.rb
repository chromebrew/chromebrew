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
    aarch64: 'efe3ffc129b9d228367e723b6332c4b3f8afc983ec521bdfd2480a49e726f86f',
     armv7l: 'efe3ffc129b9d228367e723b6332c4b3f8afc983ec521bdfd2480a49e726f86f',
       i686: '9e8c806535e1afa86737f3f4ff4b7547c9a7b6d88d508e4fc672e70173541bfa',
     x86_64: '78107de10d329a4c0ea60b81ee0902568f5ef257208aee2cf780a12a167c6551'
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
