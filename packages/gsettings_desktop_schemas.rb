require 'package'

class Gsettings_desktop_schemas < Package
  description 'Collection of GSettings schemas for GNOME desktop.'
  homepage 'https://git.gnome.org/browse/gsettings-desktop-schemas'
  version '3.38.0'
  compatibility 'all'
  source_url 'https://github.com/GNOME/gsettings-desktop-schemas/archive/3.38.0.tar.gz'
  source_sha256 'b808bd285ac7176f2e9e3a8763c3913121ab9f109d2988c70e3f1f8e742a630d'

  depends_on 'gnome_common'
  depends_on 'glib'
  depends_on 'gobject_introspection'

  def self.build
    system "sed -i -r 's:\"(/system):\"/org/gnome\1:g' schemas/*.in"
    system "./autogen.sh"
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
  end

end
