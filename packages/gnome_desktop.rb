require 'package'

class Gnome_desktop < Package
  description 'Library with common API for various GNOME modules'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-desktop'
  @_ver = '40.rc'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'GPL-2+, LGPL-2+ and FDL-1.1+'
  compatibility 'all'
  source_url "https://download.gnome.org/core/#{@_ver_prelastdot}/#{@_ver}/sources/gnome-desktop-#{@_ver}.tar.xz"
  source_sha256 'bd5bc1ab9640301efc7cc1dbfc5965fcb7dcadabb6f6f395ae8b571aed84f448'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_desktop-40.rc-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_desktop-40.rc-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_desktop-40.rc-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_desktop-40.rc-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c01944da1742882b92b43878c1cd478862f0b2a38e7ded7389c2613b7fda65f5',
     armv7l: 'c01944da1742882b92b43878c1cd478862f0b2a38e7ded7389c2613b7fda65f5',
       i686: '0ac5ecf9d14c6186073929b637d076a10bb70691b298d629a2ef9c50a8954681',
     x86_64: '2a1f551996fc7540dfcba2e74229d7e20301af0c748f80b6f111fac6ee330757'
  })

  depends_on 'gsettings_desktop_schemas'
  depends_on 'gtk3'
  depends_on 'libxkbfile'
  depends_on 'xkeyboard_config'
  depends_on 'iso_codes'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
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
