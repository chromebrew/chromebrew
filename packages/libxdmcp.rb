require 'package'

class Libxdmcp < Package
  description 'The libXdmcp package contains a library implementing the X Display Manager Control Protocol.'
  homepage 'http://www.x.org'
  version '1.1.2'
  source_url 'https://www.x.org/pub/individual/lib/libXdmcp-1.1.2.tar.bz2'
  source_sha256 '81fe09867918fff258296e1e1e159f0dc639cb30d201c53519f25ab73af4e4e2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxdmcp-1.1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxdmcp-1.1.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxdmcp-1.1.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxdmcp-1.1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '795e6e9328928a824a725ad550aab351ab19812f3fd00344d74fca77a62a8a33',
     armv7l: '795e6e9328928a824a725ad550aab351ab19812f3fd00344d74fca77a62a8a33',
       i686: '76f300b165fa8d983ea60b3f37e7bec53fdbae45ae1937776de388883e7aac1e',
     x86_64: 'b486612a4ef87e4d1b13d0c914dd4df7a5e09d4e1267e3eec30e965372ae5830',
  })

  depends_on "util_macros" => :build
  depends_on "xproto" => :build


  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
