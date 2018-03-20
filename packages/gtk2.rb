require 'package'

class Gtk2 < Package
  description 'Gtk+ 2.24 graphical user interface library. https://www.gtk.org/'
  homepage 'https://ftp.gnome.org/pub/gnome/sources/gtk+/2.24/'
  version '2.24.32'
  source_url 'https://download.gnome.org/sources/gtk+/2.24/gtk+-2.24.32.tar.xz'
  source_sha256 'b6c8a93ddda5eabe3bfee1eb39636c9a03d2a56c7b62828b359bf197943c582e'

  binary_url ({
  })
  binary_sha256 ({
  })
  
  depends_on 'docbook_xml'
  depends_on 'docbook_xsl'
  depends_on 'gtk_doc'
  depends_on 'atk'
  depends_on 'pango'
  depends_on 'cairo'
  depends_on 'gdk_pixbuf'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "pip install six"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
    system "pip uninstall --yes six"
  end
  
end
