require 'package'

class Libxml2 < Package
  description 'Libxml2 is the XML C parser and toolkit developed for the Gnome project.'
  homepage 'http://xmlsoft.org/'
  version '2.9.9'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.9.9/libxml2-v2.9.9.tar.bz2'
  source_sha256 'd598e907b5f3efa992b65094f7113d9d8cc87238f32e4e1ddf8beff01b60a653'

  binary_url ({
  })
  binary_sha256 ({
  })
 
  depends_on 'zlibpkg'

  def self.build
    system './autogen.sh'
    system "./configure",
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      "--enable-shared",
      "--disable-static",
      "--with-pic",
      "--without-python",   # libxml2-python built in another package (libxml2_python)
      "--without-lzma",
      "--with-zlib",
      "--with-icu",
      "--with-threads",
      "--with-history"
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
