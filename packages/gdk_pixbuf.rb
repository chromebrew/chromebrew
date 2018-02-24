require 'package'

class Gdk_pixbuf < Package
  description 'GdkPixbuf is a library for image loading and manipulation.'
  homepage 'https://developer.gnome.org/gdk-pixbuf'
  version '2.36.7-0'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/2.36/gdk-pixbuf-2.36.7.tar.xz'
  source_sha256 '1b6e5eef09d98f05f383014ecd3503e25dfb03d7e5b5f5904e5a65b049a6a4d8'

  binary_url ({
  })
  binary_sha256 ({
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
