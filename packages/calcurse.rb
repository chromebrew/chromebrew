require 'package'

class Calcurse < Package
  description 'calcurse is a calendar and scheduling application for the command line.'
  homepage 'http://calcurse.org/'
  version '4.3.0'
  compatibility 'all'
  source_url 'http://calcurse.org/files/calcurse-4.3.0.tar.gz'
  source_sha256 '31ecc3dc09e1e561502b4c94f965ed6b167c03e9418438c4a7ad5bad2c785f9a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/calcurse-4.3.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/calcurse-4.3.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/calcurse-4.3.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/calcurse-4.3.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '363f2ae61d62e02b29a9862e358f4fbc017e7274530bd044635239be27879728',
     armv7l: '363f2ae61d62e02b29a9862e358f4fbc017e7274530bd044635239be27879728',
       i686: 'c736c5903b65477ce0a0d6bc07c2556adf6c39b1b96c696bb55258c1beaa5a38',
     x86_64: 'a6768b3fd4ee770e9801500205a82601fbb37258a851183c46d58ec3dd52aedd',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
