require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = '7.76.1'
  version @_ver
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{@_ver}.tar.xz"
  source_sha256 '64bb5288c39f0840c07d077e30d9052e1cbb9fa6c2dc52523824cc859e679145'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/7.76.1_armv7l/curl-7.76.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/7.76.1_armv7l/curl-7.76.1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/7.76.1_i686/curl-7.76.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/7.76.1_x86_64/curl-7.76.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'ae48ef34d0a91114c532590f7f7c754bd3fa9bc7e6a96223b2864d167ba79c3a',
     armv7l: 'ae48ef34d0a91114c532590f7f7c754bd3fa9bc7e6a96223b2864d167ba79c3a',
       i686: '61f65c1c8d892c80d40908beadbd73de14a7c987593d93dad62c7c9555927bdf',
     x86_64: 'fbe7e0e7192e75ff64b24e71a8861b773c4d47ef668206f85fff6e8840d59f54'
  })

  depends_on 'brotli' # R
  depends_on 'ca_certificates' # L
  depends_on 'c_ares' # R
  depends_on 'groff' => :build
  depends_on 'libidn2' # R
  depends_on 'libmetalink' # R
  depends_on 'libnghttp2' # R
  depends_on 'libpsl' # R
  depends_on 'libtirpc' # ?
  depends_on 'libunbound' # ?
  depends_on 'openldap' # R
  depends_on 'openssl' # R
  depends_on 'rtmpdump' # R
  depends_on 'rust' => :build
  depends_on 'valgrind' => :build
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R


  def self.build
    raise StandardError, 'Please remove libiconv before building.' if File.exist?("#{CREW_LIB_PREFIX}/libcharset.so")

    system 'filefix'
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto' \
      LDFLAGS='-flto=auto'\
      ./configure #{CREW_OPTIONS} \
      --disable-maintainer-mode \
      --enable-ares \
      --with-ldap-lib=ldap \
      --with-lber-lib=lber \
      --with-libmetalink \
      --with-ca-path=#{CREW_PREFIX}/etc/ssl/certs \
      --with-ca-bundle=#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt \
      --with-ca-fallback"
    system 'make'
  end

  def self.check
    # Python package impacket needed for testing.
    # 1094 tests out of 1097 reported OK: 99% on 10/25/2020
    # The 3 tests that failed were FTP, SMB and GOPHER.
    system 'pip3 install impacket'
    system 'make check || true'
    system 'pip3 uninstall -y impacket'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
