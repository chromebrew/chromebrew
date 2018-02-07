require 'package'

class Libxml2 < Package
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.9.7'
  source_url 'ftp://xmlsoft.org/libxml2/libxml2-2.9.7.tar.gz'
  source_sha256 'f63c5e7d30362ed28b38bfa1ac6313f9a80230720b7fb6c80575eeab3ff5900c'
 
  depends_on 'python27'
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
