require 'package'

class Json_glib < Package
  description 'Library providing GLib serialization and deserialization for the JSON format.'
  homepage 'https://wiki.gnome.org/Projects/JsonGlib'
  version '1.4.2'
  source_url 'https://download.gnome.org/sources/json-glib/1.4/json-glib-1.4.2.tar.xz'
  source_sha256 '2d7709a44749c7318599a6829322e081915bdc73f5be5045882ed120bb686dc8'

  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'gtk_doc'
  depends_on 'meson'
  depends_on 'docbook'
  depends_on 'libxslt'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "meson _build"
  end

  def self.install
    Dir.chdir("_build") do
     system "ninja install"
    end
  end
  
end
