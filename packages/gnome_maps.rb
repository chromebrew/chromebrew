require 'package'

class Gnome_maps < Package
  description 'A simple GNOME maps application'
  homepage 'https://wiki.gnome.org/Apps/Maps'
  @_ver = '40.rc'
  version @_ver
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gnome-maps/-/archive/v#{@_ver}/gnome-maps-v#{@_ver}.tar.bz2"
  source_sha256 'db00e0c8e5ce3c3fb3801ecf522f76751cc1f0b1d5007c6169207260143f163b'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_maps-40.rc-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_maps-40.rc-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_maps-40.rc-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_maps-40.rc-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a2c42ed9bb3ae39df2987dd0985ba16081b7d46f402bbd0dd18ac3310a5f6557',
     armv7l: 'a2c42ed9bb3ae39df2987dd0985ba16081b7d46f402bbd0dd18ac3310a5f6557',
       i686: 'af96f8c19eb879b2809c309c4e5fdb3bba73bf6ba4cbee3976b47c4e97c752c5',
     x86_64: '1f29fa5107fa2c36dae1d4ffa58b1ace0b76d3dafd0bd51595ac92078e39be9a'
  })

  depends_on 'geocode_glib'
  depends_on 'geoclue'
  depends_on 'gjs'
  depends_on 'gtk3'
  depends_on 'gtk4'
  depends_on 'libchamplain'
  depends_on 'libgee'
  depends_on 'libhandy'
  depends_on 'folks'
  depends_on 'gfbgraph'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'yelp_tools' => ':build'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    builddir"
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
