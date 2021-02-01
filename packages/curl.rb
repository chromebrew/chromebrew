require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = "7.74.0"
  version @_ver + '-2'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{@_ver}.tar.xz"
  source_sha256 '999d5f2c403cf6e25d58319fdd596611e455dd195208746bc6e6d197a77e878b'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.74.0-2-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.74.0-2-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.74.0-2-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.74.0-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '48caa978643acd326ffdf3e3f4bc502d48c8aafc73b1e39e47d710174fad2145',
      armv7l: '48caa978643acd326ffdf3e3f4bc502d48c8aafc73b1e39e47d710174fad2145',
        i686: 'fed721a267a16a27df602b6116d0be04423bb58194d567dbf42727e6d61afdf2',
      x86_64: 'e8a8120132ce90acda8cc2b9f87c609dd4eca1851a8ef990b2d99eebf84372b1',
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
