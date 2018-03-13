require 'package'

class Gentoo_file_manager < Package
  description 'Graphical file manager for Unix-like systems, using GTK+.'
  homepage 'http://gentoo.sourceforge.net/'
  version '0.20.7'
  source_url 'https://sourceforge.net/projects/gentoo/files/gentoo/0.20.7/gentoo-0.20.7.tar.gz'
  source_sha256 '9a50a139509a2f7e4540c8a093105bd8dd432596c9903db24891fbacf28ab1aa'

  depends_on 'gtk3'
  depends_on 'pango'
  depends_on 'cairo'
  depends_on 'atk'
  depends_on 'gobject_introspection'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end
