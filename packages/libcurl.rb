require 'package'

class Libcurl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = '7.82.0'
  version "#{@_ver}-1"
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{@_ver}.tar.xz"
  source_sha256 '0aaa12d7bd04b0966254f2703ce80dd5c38dbbd76af0297d3d690cdce58a583c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.82.0-1_armv7l/libcurl-7.82.0-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.82.0-1_armv7l/libcurl-7.82.0-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.82.0-1_i686/libcurl-7.82.0-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.82.0-1_x86_64/libcurl-7.82.0-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '99cb07b00694c2adce9a43517597c979bcad6cf7d6622d6cb8000a5da5ceee32',
     armv7l: '99cb07b00694c2adce9a43517597c979bcad6cf7d6622d6cb8000a5da5ceee32',
       i686: 'c1e5c9d7d7b2d8e22367c71de6ca7aef6ffd3e52d201c998488ca6c12b71ddae',
     x86_64: '88504cec88c61e0a7c95a8fb370078848825fa2349436525f3d6b53c7f1eeede'
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
  end
end
