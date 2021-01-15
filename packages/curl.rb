require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = "7.74.0"
  version @_ver + '-1'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{@_ver}.tar.xz"
  source_sha256 '999d5f2c403cf6e25d58319fdd596611e455dd195208746bc6e6d197a77e878b'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.74.0-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.74.0-1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.74.0-1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.74.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'f54a7ff2c3521535af5873b061d26514005e3e080e5b444888e25dce95981201',
      armv7l: 'f54a7ff2c3521535af5873b061d26514005e3e080e5b444888e25dce95981201',
        i686: 'ba7b7abeda8592135d2ea851f906636716b1f1d577fdcc75ad68bd6f0b67e5e0',
      x86_64: '7696a5014d09eaff0864ee36fe4a7f8032c99e7eeb56baf0e04a87427e0114c6',
  })

  depends_on 'groff' => :build
  depends_on 'brotli'
  depends_on 'c_ares'
  depends_on 'libiconv'
  depends_on 'libidn2'
  depends_on 'libmetalink'
  depends_on 'libnghttp2'
  depends_on 'libtirpc'
  depends_on 'libunbound'
  depends_on 'openldap'
  depends_on 'rtmpdump'
  depends_on 'zstd'

  def self.build
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto' \
    ./configure #{CREW_OPTIONS} \
    --disable-maintainer-mode \
    --enable-ares \
    --with-ldap-lib=#{CREW_LIB_PREFIX}/libldap.so \
    --with-lber-lib=#{CREW_LIB_PREFIX}/liblber.so"
    system 'make'
  end

  def self.check
    # Python package impacket needed for testing.
    # 1094 tests out of 1097 reported OK: 99% on 10/25/2020
    # The 3 tests that failed were FTP, SMB and GOPHER.
    #system 'pip install impacket'
    #system 'make', 'check'
    #system 'pip uninstall -y impacket'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
