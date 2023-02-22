require 'package'

class Libcurl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = '7.88.1'
  version @_ver
  license 'curl'
  compatibility 'all'
  source_url 'https://curl.se/download/curl-7.88.1.tar.xz'
  source_sha256 '1dae31b2a7c1fe269de99c0c31bb488346aab3459b5ffca909d6938249ae415f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.88.1_armv7l/libcurl-7.88.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.88.1_armv7l/libcurl-7.88.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.88.1_i686/libcurl-7.88.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.88.1_x86_64/libcurl-7.88.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ef8cafeffc06c09cc042cec8fb79a3dc75cca5ea6d39ce47a6f2e78f607bd211',
     armv7l: 'ef8cafeffc06c09cc042cec8fb79a3dc75cca5ea6d39ce47a6f2e78f607bd211',
       i686: 'df6c5eeeb071abf662514a5685ac611f9bba137d90975e3af8304d5b3a521993',
     x86_64: 'd95afcd1276483a4a384a3490fb0f841685b18bc406c3d6cd8ad202ecc26516d'
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

  no_patchelf

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
    system 'mold -run make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
