require 'package'

class Sg3_utils < Package
  description 'The sg3_utils package contains utilities that send SCSI commands to devices.'
  homepage 'http://sg.danny.cz/sg/sg3_utils.html'
  version '1.44'
  compatibility 'all'
  source_url 'http://sg.danny.cz/sg/p/sg3_utils-1.44.tar.xz'
  source_sha256 'ca94ac106510742cd8ff5ead4a7e5c89d410653291401daf4632d2bef2a35b05'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sg3_utils-1.44-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sg3_utils-1.44-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sg3_utils-1.44-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sg3_utils-1.44-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ae79701d44c714506fc6e96380cfe9bc401f8207bd3cef75ad6d22af62a947ab',
     armv7l: 'ae79701d44c714506fc6e96380cfe9bc401f8207bd3cef75ad6d22af62a947ab',
       i686: '1862071fbf2c6e4b89b596c9f643534311b2906b038fb25502db2f95b546c26e',
     x86_64: 'bf5157d3ffb69c69cc71d4e6df55706cbc1cd31632159fe8fa2ca0298377a184',
  })

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
