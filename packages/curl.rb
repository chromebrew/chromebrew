require 'buildsystems/autotools'

class Curl < Autotools
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '8.7.1'
  license 'curl'
  compatibility 'all'
  source_url 'https://curl.se/download/curl-8.7.1.tar.xz'
  source_sha256 '6fea2aac6a4610fbd0400afb0bcddbe7258a64c63f1f68e5855ebc0c659710cd'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8608a2184b91c1deac7b02c3da01561798ac239905260148adf449a155d4b749',
     armv7l: '8608a2184b91c1deac7b02c3da01561798ac239905260148adf449a155d4b749',
       i686: 'cc955a1acfc40dc50633f8d3cdb0af89d17eaf712aedfb3f0936faff162bd904',
     x86_64: '0c50d4f7f09818bc089f3dc4fe224c354d04f0116aedb0b7236e9a5eb1bb71f0'
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
