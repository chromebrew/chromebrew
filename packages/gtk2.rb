require 'package'

class Gtk2 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://www.gtk.org/'
  version '2.24.32'
  source_url 'https://download.gnome.org/sources/gtk+/2.24/gtk+-2.24.32.tar.xz'
  source_sha256 'b6c8a93ddda5eabe3bfee1eb39636c9a03d2a56c7b62828b359bf197943c582e'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gtk_doc'
  depends_on 'atk'
  depends_on 'pango'
  depends_on 'gdk_pixbuf'
  depends_on 'cups'
  depends_on 'six' => :build

  def self.build
    system "./configure",
           "--with-gdktarget=x11",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
