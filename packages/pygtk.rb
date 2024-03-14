require 'package'

class Pygtk < Package
  description 'PyGTK is a Python package which provides bindings for GObject based libraries such as GTK+, GStreamer, WebKitGTK+, GLib, GIO and many more.'
  homepage 'http://www.pygtk.org/'
  version '2.24.0'
  license 'LGPL-2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/pygtk/2.24/pygtk-2.24.0.tar.bz2'
  source_sha256 'cd1c1ea265bd63ff669e92a2d3c2a88eb26bcd9e5363e0f82c896e649f206912'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '8860c0568f4a0c0ebc653d1225e4e110876462711df525ee2a9a59439d242030',
     armv7l: '8860c0568f4a0c0ebc653d1225e4e110876462711df525ee2a9a59439d242030',
     x86_64: '1cee38a4d4e85c1c17974b4939a48da261d785f00c5916a97405e48c4acb4f1c'
  })

  depends_on 'libglade'
  depends_on 'pygobject2'

  gnome

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
