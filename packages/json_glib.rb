require 'package'

class Json_glib < Package
  description 'JSON-GLib implements a full suite of JSON-related tools using GLib and GObject.'
  homepage 'https://wiki.gnome.org/Projects/JsonGlib'
  version '1.4.2'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/json-glib/1.4/json-glib-1.4.2.tar.xz'
  source_sha256 '2d7709a44749c7318599a6829322e081915bdc73f5be5045882ed120bb686dc8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/json_glib-1.4.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/json_glib-1.4.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/json_glib-1.4.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/json_glib-1.4.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'beebd6ecd278f1c591eb95f23068c39ad83dddb9fc34cf420baea4d4c59a32ba',
     armv7l: 'beebd6ecd278f1c591eb95f23068c39ad83dddb9fc34cf420baea4d4c59a32ba',
       i686: 'ba63448663fd24715d510c689e41ffea14062108bfd0fc76399c15ad9c1a4dd2',
     x86_64: '5e79363b10f04e8b6240d69d323ea78595271cbaaac5df9acaf09f07f52e1939',
  })

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
