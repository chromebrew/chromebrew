require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = "7.74.0"
  version @_ver + '-3'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{@_ver}.tar.xz"
  source_sha256 '999d5f2c403cf6e25d58319fdd596611e455dd195208746bc6e6d197a77e878b'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.74.0-3-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.74.0-3-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.74.0-3-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.74.0-3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '5012f55827b4a9214b1a769672c3218c5cd3cbb7915e91e563eae3aa13db73ce',
      armv7l: '5012f55827b4a9214b1a769672c3218c5cd3cbb7915e91e563eae3aa13db73ce',
        i686: '86b61da0ae5c15b4b96243943806669f75204b7aa5d8054650000a66648d0e67',
      x86_64: '5a12aacb4f66ae223d25cf21d8bc5b73236bec93f7346158d0224840704ed9fb',
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
  depends_on 'zstd'

  def self.build
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto' \
    ./configure #{CREW_OPTIONS} \
    --disable-maintainer-mode \
    --enable-ares \
    --with-ldap-lib=ldap \
    --with-lber-lib=lber \
    --with-libmetalink \
    --without-librtmp"
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
