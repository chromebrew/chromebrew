require 'package'

class Gtk2 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://www.gtk.org/'
  version '2.24.32'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gtk+/2.24/gtk+-2.24.32.tar.xz'
  source_sha256 'b6c8a93ddda5eabe3bfee1eb39636c9a03d2a56c7b62828b359bf197943c582e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk2-2.24.32-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtk2-2.24.32-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtk2-2.24.32-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk2-2.24.32-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fd9c70546e81305d326c14ed732f2e97bfe0ecda086065a39412e64c1551e594',
     armv7l: 'fd9c70546e81305d326c14ed732f2e97bfe0ecda086065a39412e64c1551e594',
       i686: '59b2a8a87aba4fe3244514cc4c774a329b9d7305a337b28435206ed8f0f48625',
     x86_64: 'e20fa7809d9937517700809b7894dd295615b79b800daec2e011b0e49d83f1b6',
  })

  depends_on 'gtk_doc'
  depends_on 'atk'
  depends_on 'pango'
  depends_on 'gdk_pixbuf'
  depends_on 'cups'
  depends_on 'shared_mime_info'
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
