require 'package'

class Attr < Package
  description 'Commands for Manipulating Filesystem Extended Attributes.'
  homepage 'http://savannah.nongnu.org/projects/attr'
  version '2.4.48'
  source_url 'http://download.savannah.gnu.org/releases/attr/attr-2.4.48.tar.gz'
  source_sha256 '5ead72b358ec709ed00bbf7a9eaef1654baad937c001c044fe8b74c57f5324e7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/attr-2.4.48-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/attr-2.4.48-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/attr-2.4.48-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/attr-2.4.48-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9ba6aafd2ac91a3b9534ed8780ad40b8f88d1b549281455fecefd700f7d8a734',
     armv7l: '9ba6aafd2ac91a3b9534ed8780ad40b8f88d1b549281455fecefd700f7d8a734',
       i686: 'db2b92875ead6a24c93708af44ca35aff9257269c33add3c94f04aa97b1dbf9b',
     x86_64: '876f464fc3b2185e2076569d06ccf5df957405ce78b92c49a779582d30ee75a4',
  })

  depends_on 'gettext'

  def self.build
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
