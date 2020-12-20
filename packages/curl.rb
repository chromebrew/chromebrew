require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '7.74.0'
  compatibility 'all'
  source_url 'https://curl.se/download/curl-7.74.0.tar.xz'
  source_sha256 '999d5f2c403cf6e25d58319fdd596611e455dd195208746bc6e6d197a77e878b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.74.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.74.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.74.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.74.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6c817cc8f2043982148a08713fd5439efc26e80f44788788b58bde6d5a86186c',
     armv7l: '6c817cc8f2043982148a08713fd5439efc26e80f44788788b58bde6d5a86186c',
       i686: '77b6af733566a22e9eb1187470190b9c48e2480dd13589efc452da589530630d',
     x86_64: '137ee2aadee4e1fad6a4f80b361bdbbb7181baea32cc0b8326aa693a1d3916d4',
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
    system "./configure #{CREW_OPTIONS} --disable-maintainer-mode --enable-ares --with-ldap-lib=#{CREW_LIB_PREFIX}/libldap.so --with-lber-lib=#{CREW_LIB_PREFIX}/liblber.so"
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
