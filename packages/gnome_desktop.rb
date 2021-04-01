require 'package'

class Gnome_desktop < Package
  description 'Library with common API for various GNOME modules'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-desktop'
  @_ver = '40.0'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'GPL-2+, LGPL-2+ and FDL-1.1+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gnome-desktop/-/archive/#{@_ver}/gnome-desktop-#{@_ver}.tar.bz2"
  source_sha256 'b993bb587326e405796ffe15335eba6923cfec4bee454e738a748e98476c320a'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_desktop-40.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_desktop-40.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_desktop-40.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_desktop-40.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '22a1ccea4001e03618acbc0cfb6db38a7aa3994cab0f5b1a06b830eb6ffda2b9',
     armv7l: '22a1ccea4001e03618acbc0cfb6db38a7aa3994cab0f5b1a06b830eb6ffda2b9',
       i686: '86e673834524d756ae3f655819025d31aeba84d713f3c26b0546f511761eed92',
     x86_64: 'ea296854348498177dc068c611418b5bfe580153c440b3ca6173793bfac028c0'
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
  depends_on 'libxkbcommon'
  depends_on 'libxkbfile'
  depends_on 'xkeyboard_config'
  depends_on 'yelp_tools' => :build

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Dsystemd=disabled \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
