require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.haxx.se/'
  version '7.73.0'
  compatibility 'all'
  source_url 'https://curl.haxx.se/download/curl-7.73.0.tar.xz'
  source_sha256 '7c4c7ca4ea88abe00fea4740dcf81075c031b1d0bb23aff2d5efde20a3c2408a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.73.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.73.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.73.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.73.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0f75d8a211f66cf27c0f9bfe35b10761f21c6f6d71665d10d5511c1c72017c58',
     armv7l: '0f75d8a211f66cf27c0f9bfe35b10761f21c6f6d71665d10d5511c1c72017c58',
       i686: '3109622744ec710f5f7d37678f108f382f481a7297fbecc01902fb5933a0cfa1',
     x86_64: 'ab8fc3bdc5f2495067b979105b21fc684952beb463a356051fb5736d70f5e1da',
  })

  depends_on 'groff' => :build
  depends_on 'brotli'
  depends_on 'c_ares'
  depends_on 'libiconv'
  depends_on 'libidn2'
  depends_on 'libmbedtls'
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
