require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = '8.0.0'
  version @_ver
  license 'curl'
  compatibility 'all'
  source_url 'https://curl.se/download/curl-8.0.0.tar.xz'
  source_sha256 '759690f9a375a720f8bcce9f953897b0d93f31eed9649b74f846d54bbf63bbcc'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.0.0_armv7l/curl-8.0.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.0.0_armv7l/curl-8.0.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.0.0_i686/curl-8.0.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.0.0_x86_64/curl-8.0.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '79a56ed3f978bec472728175d47b00e270e5c8b38993164748d888dfd29597e4',
     armv7l: '79a56ed3f978bec472728175d47b00e270e5c8b38993164748d888dfd29597e4',
       i686: '8eb3b5c56c9de42061fc8c6233b21afb77ffdcf286bab8458e2d6842a31f8799',
     x86_64: '6cda779e85064dae2dbfa9d997d5a056bc8385998b049c28d264d877a3919caa'
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
  conflicts_ok

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
