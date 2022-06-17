require 'package'

class Libcurl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = '7.83.1'
  version "#{@_ver}-1"
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{@_ver}.tar.xz"
  source_sha256 '2cb9c2356e7263a1272fd1435ef7cdebf2cd21400ec287b068396deb705c22c4'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.83.1-1_armv7l/libcurl-7.83.1-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.83.1-1_armv7l/libcurl-7.83.1-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.83.1-1_i686/libcurl-7.83.1-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.83.1-1_x86_64/libcurl-7.83.1-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0d429af3793082e7de32b9c97d757ae06f95471068d3ad97feefa4d94f604fec',
     armv7l: '0d429af3793082e7de32b9c97d757ae06f95471068d3ad97feefa4d94f604fec',
       i686: '981d06377897832d8dc880e53c2e7cab1d33c3440730c2483bb166dc1b44f5c7',
     x86_64: 'e7b175aeeb4e47f1652e47e11feb56f2d049a44550ff53ce43779b6ad75a368e'
  })

  depends_on 'brotli' # R
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
    libssh_opt = (ARCH == 'i686') ? '--without-libssh' : '--with-libssh'

    system '[ -x configure ] || autoreconf -fvi'
    system 'filefix'

    system <<~BUILD
      ./configure #{CREW_OPTIONS} \
        --disable-maintainer-mode \
        --enable-ares \
        --enable-ipv6 \
        --enable-ldap \
        --enable-unix-sockets \
        --with-ca-bundle=#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt \
        --with-ca-fallback \
        --with-ca-path=#{CREW_PREFIX}/etc/ssl/certs \
        #{libssh_opt} \
        --with-openssl \
        --without-gnutls \
        --without-librtmp
    BUILD

    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
