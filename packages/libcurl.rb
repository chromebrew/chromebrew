require 'package'

class Libcurl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = '7.82.0'
  version @_ver
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{@_ver}.tar.xz"
  source_sha256 '0aaa12d7bd04b0966254f2703ce80dd5c38dbbd76af0297d3d690cdce58a583c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.82.0_armv7l/libcurl-7.82.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.82.0_armv7l/libcurl-7.82.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.82.0_i686/libcurl-7.82.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.82.0_x86_64/libcurl-7.82.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4c93987529a02ef14f2febd2554ad0f8720605a12d4d3ed76c904b2386b2cc5a',
     armv7l: '4c93987529a02ef14f2febd2554ad0f8720605a12d4d3ed76c904b2386b2cc5a',
       i686: '4bf55e9a5cfd3eaf2114198969a5a536f74dd348c4398968128b36c52153b588',
     x86_64: 'b43580537b314e0aad5aa99de45928618b302c9879c89cd18d13165a22fd6c96'
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
  end
end
