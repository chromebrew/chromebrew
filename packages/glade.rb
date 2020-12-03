require 'package'

class Glade < Package
  description 'User Interface Builder for GTK+ applications'
  version '3.38.2'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/glade/3.38/glade-3.38.2.tar.xz'
  source_sha256 '98fc87647d88505c97dd2f30f2db2d3e9527515b3af11694787d62a8d28fbab7'

  depends_on 'gtk3'
  depends_on 'libxml2'
  depends_on 'gobject_introspection'
  depends_on 'pygobject'

  def self.build
  system "meson setup #{CREW_MESON_OPTIONS} -Dgtk_doc=false -Dman=false build"
  system "meson configure build"
  system "ninja -C build"
  end
  
  def self.install
  system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
