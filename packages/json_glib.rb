require 'package'

class Json_glib < Package
  description 'JSON-GLib implements a full suite of JSON-related tools using GLib and GObject.'
  homepage 'https://wiki.gnome.org/Projects/JsonGlib'
  version '1.4.2'
  source_url 'https://download.gnome.org/sources/json-glib/1.4/json-glib-1.4.2.tar.xz'
  source_sha256 '2d7709a44749c7318599a6829322e081915bdc73f5be5045882ed120bb686dc8'

  depends_on 'meson'
  depends_on 'gtk_doc'
  depends_on 'glib'
  depends_on 'gobject_introspection'

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} _build"
    system "ninja -C _build"
  end

  def self.check
    system "meson test -C _build"
  end
  
  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end
