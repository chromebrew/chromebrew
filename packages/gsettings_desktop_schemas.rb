require 'package'

class Gsettings_desktop_schemas < Package
  description 'Collection of GSettings schemas for GNOME desktop.'
  homepage 'https://git.gnome.org/browse/gsettings-desktop-schemas'
  version '40.beta'
  compatibility 'all'
  source_url 'https://github.com/GNOME/gsettings-desktop-schemas/archive/40.beta.tar.gz'
  source_sha256 '885170738e15afe1a4dc60b2b9c006fce37e2b220f26ecf35f13fec8ef84657e'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gsettings_desktop_schemas-40.beta-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gsettings_desktop_schemas-40.beta-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gsettings_desktop_schemas-40.beta-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gsettings_desktop_schemas-40.beta-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'eae7ad09c2366645c76c215ed299ee7094de9312ba0cde263ad2f55c9a2a3dda',
     armv7l: 'eae7ad09c2366645c76c215ed299ee7094de9312ba0cde263ad2f55c9a2a3dda',
       i686: '3dcde7b6d32af1899840ced478120c06fe681274d618fa933fbc32c088468e1b',
     x86_64: '2707ac29a96c529759e7ac6a46725f1b474c0aca2c5dcab59372ec9d8429e16d'
  })

  depends_on 'gnome_common'
  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'gtk4'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
  end
end
