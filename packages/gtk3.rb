require 'package'

class Gtk3 < Package
  description 'Gtk3 is a cross-platform widget toolkit for creating graphical user interfaces.'
  homepage 'https://developer.gnome.org/gtk3/3.0/'
  version '3.22.29'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/gtk+/3.22/gtk+-3.22.29.tar.xz'
  source_sha256 'a07d64b939fcc034a066b7723fdf9b24e92c9cfb6a8497593f3471fe56fbbbf8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.22.29-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.22.29-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.22.29-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.22.29-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '24f0c109b0d19262a38b8a9e361b2a6e6a17516d21fee207ae7cbf957c85bee5',
     armv7l: '24f0c109b0d19262a38b8a9e361b2a6e6a17516d21fee207ae7cbf957c85bee5',
       i686: 'f8569ad221aa63560fa9bfb1db99ec399156053a6e9bcf0efdcedcb6912be0a7',
     x86_64: '449303430fc73dfa177ef7880a02b3972cc65efbbda1256c598710330e9a6bf7',
  })

  depends_on 'gdk_pixbuf'
  depends_on 'libepoxy'
  depends_on 'graphene'
  depends_on 'libxkbcommon'
  depends_on 'at_spi2_atk'
  
  def self.build
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--enable-broadway-backend",
           "--enable-x11-backend",
           "--enable-wayland-backend"
    system "make"
  end

  def self.install
    system "pip install six"  # for installation process
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/glib-2.0/schemas"
    system "#{CREW_DEST_PREFIX}/bin/glib-compile-schemas #{CREW_DEST_PREFIX}/share/glib-2.0/schemas"    
    system "pip uninstall --yes six"
  end
  

end
