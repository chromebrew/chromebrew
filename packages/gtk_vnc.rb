require 'package'

class Gtk_vnc < Package
  description 'VNC viewer widget for GTK'
  homepage 'https://wiki.gnome.org/Projects/gtk-vnc'
  version '1.0.0'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/gtk-vnc/1.0/gtk-vnc-1.0.0.tar.xz'
  source_sha256 'a81a1f1a79ad4618027628ffac27d3391524c063d9411c7a36a5ec3380e6c080'

  depends_on 'pygtk'
  depends_on 'libcyrussasl'
  depends_on 'glib'
  depends_on 'libgcrypt'
  depends_on 'gobject_introspection'

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} _build"
    system 'ninja -v -C _build'
  end
  
  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end
