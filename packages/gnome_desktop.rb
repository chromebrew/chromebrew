require 'package'

class Gnome_desktop < Package
  description 'Library with common API for various GNOME modules'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-desktop'
  @_ver = '40.0'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version "#{@_ver}-1"
  license 'GPL-2+, LGPL-2+ and FDL-1.1+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gnome-desktop/-/archive/#{@_ver}/gnome-desktop-#{@_ver}.tar.bz2"
  source_sha256 'b993bb587326e405796ffe15335eba6923cfec4bee454e738a748e98476c320a'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/gnome_desktop-40.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/gnome_desktop-40.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/gnome_desktop-40.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/gnome_desktop-40.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'aa5626a827b0dc651edc6187b5f9bda067191aaa003961b051d763939488c800',
     armv7l: 'aa5626a827b0dc651edc6187b5f9bda067191aaa003961b051d763939488c800',
       i686: '2ec196505f5a9d53833d44af523f7cc1383883ec8de1cc49ee9c0010a0cac8c5',
     x86_64: '36359861c63f4272417bc9ab23b4eeeba0c301a167268cbca4e7a8c940f53e04'
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
