require 'package'

class Gtk_doc < Package
  description 'GTK-Doc is a project which was started to generate API documentation from comments added to C code.'
  homepage 'https://www.gtk.org/gtk-doc'
  version '1.26'
  source_url 'https://github.com/GNOME/gtk-doc/archive/GTK_DOC_1_26.tar.gz'
  source_sha256 'f0bcb1ff8268136fdbf426d7862f4f092e70b24a73632cfe0a3d31ed0d924b5c'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'six'
  depends_on 'docbook_xsl'

  def self.build
    system "./autogen.sh --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --with-xml-catalog=#{CREW_PREFIX}/etc/xml/catalog"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
