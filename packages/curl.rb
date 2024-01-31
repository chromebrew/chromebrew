require 'buildsystems/autotools'

class Curl < Autotools
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '8.6.0'
  license 'curl'
  compatibility 'all'
  source_url 'https://curl.se/download/curl-8.6.0.tar.xz'
  source_sha256 '3ccd55d91af9516539df80625f818c734dc6f2ecf9bada33c76765e99121db15'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd1a078e93174aa297e38dce941da921196b1f2faaa147070219dd651f01b6169',
     armv7l: 'd1a078e93174aa297e38dce941da921196b1f2faaa147070219dd651f01b6169',
       i686: 'f852dabf7c008cd142b381a0a2083c93fdd645c4154fea44fa9b1deebccf9f6b',
     x86_64: '27ac18f099c383d91ec5ab0c008ed4ee1651cf40dbe37bf3390afd733d8f9228'
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
