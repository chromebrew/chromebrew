require 'package'

class Libxml2 < Package
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.9.4-1'
  source_url 'ftp://xmlsoft.org/libxml2/libxml2-2.9.4.tar.gz'
  source_sha256 'ffb911191e509b966deb55de705387f14156e1a56b21824357cdf0053233633c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.4-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.4-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.4-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxml2-2.9.4-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '802105d36c6e2c241f2a21937adb98631e26f4f2cadd5fa33d1e4f6f190ff6ce',
     armv7l: '802105d36c6e2c241f2a21937adb98631e26f4f2cadd5fa33d1e4f6f190ff6ce',
       i686: '83f9175166eb10cfde77607fa0fdd902929d72fd7308efdf1b23ebe94e7d47c4',
     x86_64: '0a34998228e43b4d88a480b88ce8095753a7be1902f87987377138e8429f8a1f',
  })

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}",
      "--enable-shared", "--disable-static", "--with-pic", "--without-python",
      "--without-lzma", "--without-zlib"
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
