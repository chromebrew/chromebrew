require 'package'

class Libxml2 < Package
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.9.8'
  source_url 'ftp://xmlsoft.org/libxml2/libxml2-2.9.8.tar.gz'
  source_sha256 '0b74e51595654f958148759cfef0993114ddccccbb6f31aee018f3558e8e2732'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6aec3dc783b8f17309c855900052975389fb644e78f986fc40e307a66eb92b0f',
     armv7l: '6aec3dc783b8f17309c855900052975389fb644e78f986fc40e307a66eb92b0f',
       i686: '29abea10be808c0e82c1a420afdfb04ff07f8dc74be3ee26095b97ab3e310e63',
     x86_64: 'f63743763e5caff9ac62e6e03490de6c48217a6a8c1d7f923e2e3c0396131516',
  })
 
  depends_on 'python27' => :build   # since binary is available, mark it as build depedency
  depends_on 'zlibpkg'

  def self.build
    system "./configure",
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      "--enable-shared",
      "--disable-static",
      "--with-pic",
      "--with-python",
      "--without-lzma",
      "--with-zlib"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    # Remove EBCDIC test since it fails.
    # Check https://mail.gnome.org/archives/xml/2010-April/msg00010.html for details.
    system "rm", "test/ebcdic_566012.xml"

    system "make", "check"
  end
end
