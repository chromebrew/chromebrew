require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = '7.75.0'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{@_ver}.tar.xz"
  source_sha256 'fe0c49d8468249000bda75bcfdf9e30ff7e9a86d35f1a21f428d79c389d55675'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.75.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.75.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.75.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.75.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '5931c7a220565a764e6e07dd29ee9d3faeccfc5c8a8cd55c1e2f461ab2b91ce1',
     armv7l: '5931c7a220565a764e6e07dd29ee9d3faeccfc5c8a8cd55c1e2f461ab2b91ce1',
       i686: 'affda80ebef656f6def4997e7b444dfc587c9310affa23a2f7be7afc28b1e4d7',
     x86_64: '06153ae00ddc65055fe7b4aae6421101befbf611ce884ce0b794d080a585f088'
  })

  depends_on 'groff' => :build
  depends_on 'brotli'
  depends_on 'c_ares'
  depends_on 'libidn2'
  depends_on 'libmetalink'
  depends_on 'libnghttp2'
  depends_on 'libtirpc'
  depends_on 'libunbound'
  depends_on 'openldap'
  depends_on 'zstd'
  depends_on 'rtmpdump'
  depends_on 'ca_certificates'
  
  def self.build
    raise StandardError, 'Please remove libiconv before building.' if File.exist?("#{CREW_LIB_PREFIX}/libcharset.so")

    system './configure --help'
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
    # system 'pip3 install impacket'
    # system 'make check || true'
    # system 'pip3 uninstall -y impacket'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
