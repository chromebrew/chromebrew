require 'package'

class Gdk_pixbuf < Package
  description 'GdkPixbuf is a library for image loading and manipulation.'
  homepage 'https://developer.gnome.org/gdk-pixbuf'
  version '2.36.7-0'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/2.36/gdk-pixbuf-2.36.7.tar.xz'
  source_sha256 '1b6e5eef09d98f05f383014ecd3503e25dfb03d7e5b5f5904e5a65b049a6a4d8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.36.7-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.36.7-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.36.7-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.36.7-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd2489c5f1c2e8b7f20a6163c2fdfe83243b0b30ee2e87a00e29d5dc9dc993d2a',
     armv7l: 'd2489c5f1c2e8b7f20a6163c2fdfe83243b0b30ee2e87a00e29d5dc9dc993d2a',
       i686: 'eef448feb50a8d78e4d3b5f1584b829449b553d3216db5b84d2aa2eb68cdc92c',
     x86_64: '516686dc2e749e688425d10d732557bdbbaaed2ca35d715585faf675e4cd3bfc',
  })

  depends_on 'pango'
  depends_on 'gobject_introspection'
  depends_on 'libtiff'
  depends_on 'libjpeg'
  depends_on 'python27'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --with-x11"
    system "make"
  end

  def self.install
    system "pip install six" # for installation process
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "pip uninstall --yes six"
  end
  
  def self.postinstall
    # If the package is installed using a "DESTDIR" method, an important file was not installed and should be copied or generated.
    system "sudo gdk-pixbuf-query-loaders --update-cache"
  end
end
