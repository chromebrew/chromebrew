require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = '8.0.1'
  version @_ver
  license 'curl'
  compatibility 'all'
  source_url 'https://curl.se/download/curl-8.0.1.tar.xz'
  source_sha256 '0a381cd82f4d00a9a334438b8ca239afea5bfefcfa9a1025f2bf118e79e0b5f0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.0.1_armv7l/curl-8.0.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.0.1_armv7l/curl-8.0.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.0.1_i686/curl-8.0.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.0.1_x86_64/curl-8.0.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'aa1584ebca641a8fa7513f81cfa59bf5d6382be85f56c4cd4ffacf4bd0490375',
     armv7l: 'aa1584ebca641a8fa7513f81cfa59bf5d6382be85f56c4cd4ffacf4bd0490375',
       i686: '23894ab8f2afcf3c1d01b23f596ce45dd4119a45d1c3449d36a29b30398b3e87',
     x86_64: '3af563e88ba9335a871cab2620f0c8703bd35275ef1ff717dd01e7b6a0d37dc2'
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
    system "mold -run make -j #{CREW_NPROC}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
