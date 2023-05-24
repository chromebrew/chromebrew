require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '8.1.1'
  license 'curl'
  compatibility 'all'
  source_url 'https://curl.se/download/curl-8.1.1.tar.xz'
  source_sha256 '08a948e061929645597c1ef7194e07b308b22084ff03fa7400b465e6c05149e5'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.1.1_armv7l/curl-8.1.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.1.1_armv7l/curl-8.1.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.1.1_i686/curl-8.1.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.1.1_x86_64/curl-8.1.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2aac2181915719a3d8e37fe31ce07fa8899a27123f35737005f3fc9c86230b6b',
     armv7l: '2aac2181915719a3d8e37fe31ce07fa8899a27123f35737005f3fc9c86230b6b',
       i686: '5f45857e77f5722e0457b25f7cc8db859e2a9d7ab70aae849ff5810f2db4dcae',
     x86_64: 'b216c350e6f6c64c9580fab5db321733dd1f4d86c94733162bba9c6de0f6d69c'
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
