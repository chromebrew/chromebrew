require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '8.2.0'
  license 'curl'
  compatibility 'all'
  source_url 'https://curl.se/download/curl-8.2.0.tar.xz'
  source_sha256 '2859ec79e2cd96e976a99493547359b8001af1d1e21f3a3a3b846544ef54500f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.2.0_armv7l/curl-8.2.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.2.0_armv7l/curl-8.2.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.2.0_i686/curl-8.2.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.2.0_x86_64/curl-8.2.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'cc133fc3dcda93f89262785621981e8133d24d81a19ef240078d98ea0dde0aeb',
     armv7l: 'cc133fc3dcda93f89262785621981e8133d24d81a19ef240078d98ea0dde0aeb',
       i686: '6394bcef2bfede5378f510ad9af029cde45eed7927d38d7f09a1ffc7f5ead812',
     x86_64: 'b2c5e1d3ebab0557a9f8c2f92d9a8608962e54b4fe40c25bbbd63df7a9f7027c'
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

  def self.build
    system '[ -x configure ] || autoreconf -fvi'
    system 'filefix'
    system "mold -run ./configure #{CREW_OPTIONS} \
      --disable-maintainer-mode \
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
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
