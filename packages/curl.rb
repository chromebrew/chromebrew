require 'buildsystems/autotools'

class Curl < Autotools
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '8.4.0'
  license 'curl'
  compatibility 'all'
  source_url 'https://curl.se/download/curl-8.4.0.tar.xz'
  source_sha256 '16c62a9c4af0f703d28bda6d7bbf37ba47055ad3414d70dec63e2e6336f2a82d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.4.0_armv7l/curl-8.4.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.4.0_armv7l/curl-8.4.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.4.0_i686/curl-8.4.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.4.0_x86_64/curl-8.4.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7971313b11a2a2b9107a0a55449c8db7094b5021d0591002e29889d0ae0aca9d',
     armv7l: '7971313b11a2a2b9107a0a55449c8db7094b5021d0591002e29889d0ae0aca9d',
       i686: '531b2bfff2f68471fd93e7497e3736d82cec55da150a093ac3a04f1ed2d89d66',
     x86_64: '5758ac57c392aa7f8afef9a28b85960b75122cdfeeea4516b64b587eaf9fef51'
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
  depends_on 'zlibpkg' # R
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
