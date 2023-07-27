require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '8.2.1'
  license 'curl'
  compatibility 'all'
  source_url 'https://curl.se/download/curl-8.2.1.tar.xz'
  source_sha256 'dd322f6bd0a20e6cebdfd388f69e98c3d183bed792cf4713c8a7ef498cba4894'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.2.1_armv7l/curl-8.2.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.2.1_armv7l/curl-8.2.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.2.1_i686/curl-8.2.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.2.1_x86_64/curl-8.2.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5367dd8f8b4a18217e8aabd731232398519a985629256d51e3cc86d36671c995',
     armv7l: '5367dd8f8b4a18217e8aabd731232398519a985629256d51e3cc86d36671c995',
       i686: '8ee2d0983014c888263c19e55e4a3019202fe147f697ec617173fe944b632c57',
     x86_64: '86d80829dd1b7124ebaa3c457c5157d9a2dbf282714b9273c537985e6f4a2aad'
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
