require 'package'

class Gsettings_desktop_schemas < Package
  description 'Collection of GSettings schemas for GNOME desktop.'
  homepage 'https://git.gnome.org/browse/gsettings-desktop-schemas'
  @_ver = '40.rc'
  version @_ver
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gsettings-desktop-schemas/-/archive/#{@_ver}/gsettings-desktop-schemas-#{@_ver}.tar.bz2"
  source_sha256 '555613c51b149053eba790a47b9f8cab1bb5a3a9263af0b6c3e1ac357b0913da'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gsettings_desktop_schemas-40.rc-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gsettings_desktop_schemas-40.rc-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gsettings_desktop_schemas-40.rc-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gsettings_desktop_schemas-40.rc-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '458fa293a11a0b1b0cdc98e801b9f18ea82e9f9311e1c1a09b7a867d1e777b06',
     armv7l: '458fa293a11a0b1b0cdc98e801b9f18ea82e9f9311e1c1a09b7a867d1e777b06',
       i686: '6f81026e2e2b32e5b1af8097d9d0ca3060629ba2056d5834db50bd8c309c3908',
     x86_64: '89c1ee720a176bf6ab96bcb783c0eba0da16ff82cfc4387b254c3420639dd1d3'
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
