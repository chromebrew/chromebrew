require 'package'

class Gtk2 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://www.gtk.org/'
  version '2.24.33'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gtk+/2.24/gtk+-2.24.33.tar.xz'
  source_sha256 'ac2ac757f5942d318a311a54b0c80b5ef295f299c2a73c632f6bfb1ff49cc6da'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk2-2.24.33-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtk2-2.24.33-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtk2-2.24.33-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk2-2.24.33-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b259d923928b1ff1ecf0eaaa91bbb9ff201b66b5cc7418d83a19a39b975c8554',
     armv7l: 'b259d923928b1ff1ecf0eaaa91bbb9ff201b66b5cc7418d83a19a39b975c8554',
       i686: '680a403e558776af399bff35d9febe5d1c05b95b3905f936fe2b8e170d6d037d',
     x86_64: '10ec206de2a847f749ad271e97b473c8159395fc64751fe3b26058ca1ef6e75e',
  })

  depends_on 'gtk_doc'
  depends_on 'atk'
  depends_on 'pango'
  depends_on 'gdk_pixbuf'
  depends_on 'cups'
  depends_on 'shared_mime_info'
  depends_on 'six' => :build

  def self.build
    system "./configure #{CREW_OPTIONS} --with-gdktarget=x11"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
