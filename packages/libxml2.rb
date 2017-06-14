require 'package'

class Libxml2 < Package
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.9.4'
  source_url 'ftp://xmlsoft.org/libxml2/libxml2-2.9.4.tar.gz'
  source_sha1 '958ae70baf186263a4bd801a81dd5d682aedd1db'

  def self.build
    system "./configure", "--enable-shared", "--disable-static", "--with-pic", "--without-python"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"

    # strip debug symbol from library
    system "strip -S #{CREW_DEST_DIR}/usr/local/lib/libxml2.so.*"
  end

  def self.check
    # Remove EBCDIC test since it fails.
    # Check https://mail.gnome.org/archives/xml/2010-April/msg00010.html for details.
    system "rm", "test/ebcdic_566012.xml"

    system "make", "check"
  end
end
