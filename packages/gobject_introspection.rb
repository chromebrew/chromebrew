require 'package'

class Gobject_introspection < Package
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/action/show/Projects/GObjectIntrospection'
  version '1.56.0'
  source_url 'https://github.com/GNOME/gobject-introspection/archive/1.56.0.tar.gz'
  source_sha256 'dbf222ad56bc0f5a3b6cfc7be07b4b7c9a7e3a65761d5969b9fc800327c88312'

  depends_on 'glib'
  depends_on 'cairo'

  def self.build
    system "sh autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
