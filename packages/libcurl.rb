require 'package'

class Libcurl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = '7.79.1'
  version @_ver
  license 'curl'
  compatibility 'all'
  source_url "https://github.com/curl/curl/releases/download/curl-#{@_ver.gsub('.', '_')}/curl-#{@_ver}.tar.xz"
  source_sha256 '0606f74b1182ab732a17c11613cbbaf7084f2e6cca432642d0e3ad7c224c3689'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.79.1_armv7l/libcurl-7.79.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.79.1_armv7l/libcurl-7.79.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.79.1_i686/libcurl-7.79.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.79.1_x86_64/libcurl-7.79.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '497ca2518256983a3a011fa83de67f20202a1aa5cc6fdf88424b96df4cbe19ba',
     armv7l: '497ca2518256983a3a011fa83de67f20202a1aa5cc6fdf88424b96df4cbe19ba',
       i686: 'ab58dc20c50f2ad6dc00afc5b30c3eac2e4c8d5286efa70613821e46a6654d61',
     x86_64: 'e16d3d120bf089178f35f05636c9b79b5f5343d1e6b9a5a8edcc3c717213f26f'
  })

  depends_on 'brotli' => :build
  depends_on 'ca_certificates' => :build
  depends_on 'c_ares' # R
  depends_on 'libcyrussasl' # R
  depends_on 'libidn2' # R
  depends_on 'libnghttp2' # R
  depends_on 'libpsl' # R
  depends_on 'libssh' # R
  depends_on 'libunbound' # ?
  depends_on 'openldap' # R
  depends_on 'openssl' # R
  depends_on 'py3_pip' => :build
  depends_on 'rust' => :build
  depends_on 'valgrind' => :build
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  def self.build

    @libssh = '--with-libssh'
    case ARCH
    when 'i686'
      @libssh = '--without-libssh'
    end

    system '[ -x configure ] || autoreconf -fvi'
    system 'filefix'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
      --disable-maintainer-mode \
      --enable-ares \
      --enable-ipv6 \
      --enable-ldap \
      --enable-unix-sockets \
      --with-ca-bundle=#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt \
      --with-ca-fallback \
      --with-ca-path=#{CREW_PREFIX}/etc/ssl/certs \
      #{@libssh} \
      --with-openssl \
      --without-gnutls \
      --without-librtmp"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/curl", "#{CREW_DEST_PREFIX}/bin/curl.nonstatic"
  end
end
