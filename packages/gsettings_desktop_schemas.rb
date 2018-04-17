require 'package'

class Gsettings_desktop_schemas < Package
  description 'Collection of GSettings schemas for GNOME desktop.'
  homepage 'https://git.gnome.org/browse/gsettings-desktop-schemas'
  version '3.28.0'
  source_url 'https://github.com/GNOME/gsettings-desktop-schemas/archive/3.28.0.tar.gz'
  source_sha256 '7e816d73a6a206c470adaf94a5a713e7f7d1b50f97615d017d19dfdd1e23394d'

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
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
    
    # The package is installed using a “DESTDIR” method, /usr/local/share/glib-2.0/schemas/gschemas.compiled was not updated/created.
    # Generate gschemas.compiled
    system "glib-compile-schemas #{CREW_DEST_PREFIX}/share/glib-2.0/schemas"
  end

end
