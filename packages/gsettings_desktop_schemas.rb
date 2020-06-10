require 'package'

class Gsettings_desktop_schemas < Package
  description 'Collection of GSettings schemas for GNOME desktop.'
  homepage 'https://git.gnome.org/browse/gsettings-desktop-schemas'
  version '3.28.0'
  compatibility 'all'
  source_url 'https://github.com/GNOME/gsettings-desktop-schemas/archive/3.28.0.tar.gz'
  source_sha256 '7e816d73a6a206c470adaf94a5a713e7f7d1b50f97615d017d19dfdd1e23394d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gsettings_desktop_schemas-3.28.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gsettings_desktop_schemas-3.28.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gsettings_desktop_schemas-3.28.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gsettings_desktop_schemas-3.28.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'de624dd7458ac173f505dca408ca47c02a78ab71aecdcd2246b7779f823f763e',
     armv7l: 'de624dd7458ac173f505dca408ca47c02a78ab71aecdcd2246b7779f823f763e',
       i686: '31c292efcca1f8aa253be2d85a5686d0c0e59e793dfd8505c9e71b661bcc5593',
     x86_64: 'ff3bcf36058e651fe7662433fb961d9c1dc1f8db5ab17c11788ee4c3c26c99f2',
  })

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
  end

  def self.postinstall
    # The package is installed using a “DESTDIR” method, #{CREW_PREFIX}/share/glib-2.0/schemas/gschemas.compiled was not updated/created.
    # Generate gschemas.compiled
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
  end

end
