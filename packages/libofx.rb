require 'package'

class Libofx < Package
  description 'The LibOFX library is a parser and an API designed to allow applications to very easily support OFX command responses, usually provided by financial institutions for statement downloads.'
  homepage 'http://libofx.sourceforge.net/'
  version '0.9.13'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/libofx/libofx/libofx-0.9.13.tar.gz'
  source_sha256 '57eaf97cddbaf82c24f26b8f5cf8b2fbfd4969c74500a2c9acc9082b83bcc0e4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libofx-0.9.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libofx-0.9.13-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libofx-0.9.13-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libofx-0.9.13-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'da3d2fafad2db44785980c516084f122b882d2816c58f52f927942efa49d808b',
     armv7l: 'da3d2fafad2db44785980c516084f122b882d2816c58f52f927942efa49d808b',
       i686: '6b54a1337966f6dfb027ffd92e131716cadcbdf83e1a6e43c7fb6135d518be88',
     x86_64: '346cf61d1a88a8307ff8371826cd63a11b9d37c895c0b2cbaded10cc25e6446d',
  })

  depends_on 'opensp'
  depends_on 'gengetopt'

  def self.build
    system 'filefix'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--with-opensp-libs=#{CREW_LIB_PREFIX}",
           "--with-opensp-includes=#{CREW_PREFIX}/include/OpenSP"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
