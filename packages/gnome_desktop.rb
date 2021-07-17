require 'package'

class Gnome_desktop < Package
  description 'Library with common API for various GNOME modules'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-desktop'
  @_ver = '40.3'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'GPL-2+, LGPL-2+ and FDL-1.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-desktop.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_desktop/40.3_armv7l/gnome_desktop-40.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_desktop/40.3_armv7l/gnome_desktop-40.3-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_desktop/40.3_x86_64/gnome_desktop-40.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '42015f607b49bda566fb307649835336bafafebf182d6a6938bee23489a8c0f9',
     armv7l: '42015f607b49bda566fb307649835336bafafebf182d6a6938bee23489a8c0f9',
     x86_64: 'c9dc4e63cc3c1e16a957e37064fd2efed590b96b5bb58b8fe3004ea2dcf825f2'
  })

  depends_on 'cairo'
  depends_on 'eudev'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'gsettings_desktop_schemas'
  depends_on 'gtk3'
  depends_on 'gtk_doc' => :build
  depends_on 'iso_codes'
  depends_on 'libjpeg'
  depends_on 'libxkbcommon'
  depends_on 'libxkbfile'
  depends_on 'xkeyboard_config'
  depends_on 'yelp_tools' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dsystemd=disabled \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
