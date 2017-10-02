require 'package'

class Libxml2 < Package
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.9.5'
  source_url 'ftp://xmlsoft.org/libxml2/libxml2-2.9.5.tar.gz'
  source_sha256 '4031c1ecee9ce7ba4f313e91ef6284164885cdb69937a123f6a83bb6a72dcd38'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure",
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      "--enable-shared",
      "--disable-static",
      "--with-pic",
      "--without-python",
      "--without-lzma",
      "--without-zlib"
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
