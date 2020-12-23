require 'package'

class Gtk2 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://www.gtk.org/'
  version '2.24.33'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gtk+/2.24/gtk+-2.24.33.tar.xz'
  source_sha256 'ac2ac757f5942d318a311a54b0c80b5ef295f299c2a73c632f6bfb1ff49cc6da'


  depends_on 'gtk_doc'
  depends_on 'atk'
  depends_on 'pango'
  depends_on 'gdk_pixbuf'
  depends_on 'cups'
  depends_on 'shared_mime_info'
  depends_on 'six' => :build

  def self.build
    system "./configure #{CREW_OPTIONS} \
           --with-gdktarget=x11"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
