require 'package'

class Pygtk < Package
  description 'PyGTK is a Python package which provides bindings for GObject based libraries such as GTK+, GStreamer, WebKitGTK+, GLib, GIO and many more.'
  homepage 'http://www.pygtk.org/'
  version '2.24.0'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/pygtk/2.24/pygtk-2.24.0.tar.bz2'
  source_sha256 'cd1c1ea265bd63ff669e92a2d3c2a88eb26bcd9e5363e0f82c896e649f206912'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libglade'
  depends_on 'pygobject2'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
