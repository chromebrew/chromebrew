require 'buildsystems/autotools'

class Curl < Autotools
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '8.3.0'
  license 'curl'
  compatibility 'all'
  source_url 'https://curl.se/download/curl-8.3.0.tar.xz'
  source_sha256 '376d627767d6c4f05105ab6d497b0d9aba7111770dd9d995225478209c37ea63'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.3.0_armv7l/curl-8.3.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.3.0_armv7l/curl-8.3.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.3.0_i686/curl-8.3.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.3.0_x86_64/curl-8.3.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '12c66e1342454bdc628ee2f4858131e4bc0b66eec398331c4879a4ef14021c5b',
     armv7l: '12c66e1342454bdc628ee2f4858131e4bc0b66eec398331c4879a4ef14021c5b',
       i686: '301128e5ef2625f07485dd9f2a328469c77afc837416027c4a50c1c608d97f1c',
     x86_64: '74bfc11a9086d27128209330d17c96c5695d2e7872375900d831ff037fef90ab'
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
