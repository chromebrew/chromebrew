require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '8.1.0'
  license 'curl'
  compatibility 'all'
  source_url 'https://curl.se/download/curl-8.1.0.tar.xz'
  source_sha256 '6bd80ad4f07187015911216ee7185b90d285ac5162aed1bded144f9f93232a3c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.1.0_armv7l/curl-8.1.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.1.0_armv7l/curl-8.1.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.1.0_i686/curl-8.1.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.1.0_x86_64/curl-8.1.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f885a04d65edb7cf5b9836f98627eaf6a8a4cb51cf7fd9a13073ab07b1e12395',
     armv7l: 'f885a04d65edb7cf5b9836f98627eaf6a8a4cb51cf7fd9a13073ab07b1e12395',
       i686: 'ebe6900aec552db457844ba4a472282b0f1cbd798c0a3c3883e82763ea7462c3',
     x86_64: '38158df637e4cc252e9209646d0d875be3142e94d8b9bfe7f7996959df3a0fdf'
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
