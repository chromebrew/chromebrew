# Adapted from Arch Linux caja PKGBUILD at:
# https://github.com/archlinux/svntogit-community/blob/packages/caja/trunk/PKGBUILD

require 'buildsystems/autotools'

class Caja < Autotools
  description 'Caja file manager for the MATE desktop'
  homepage 'https://mate-desktop.org'
  version "1.28.0-#{CREW_ICU_VER}"
  license 'GPL-2+ LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://pub.mate-desktop.org/releases/#{version.split('-').first.rpartition('.')[0]}/caja-#{version.split('-').first}.tar.xz"
  source_sha256 '1e3014ce1455817ec2ef74d09efdfb6835d8a372ed9a16efb5919ef7b821957a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '683e4d0d2992542c7b4d1cd1bd15fe2f84e2832db20248a40906c7d1527a937f',
     armv7l: '683e4d0d2992542c7b4d1cd1bd15fe2f84e2832db20248a40906c7d1527a937f',
     x86_64: '2615f0ab25ba7382df367595dcf44822f8827bde3d5790a7e84fa3dca15f0cee'
  })

  depends_on 'at_spi2_core' => :library
  depends_on 'cairo' => :library
  depends_on 'dconf' => :executable
  depends_on 'exempi' => :executable
  depends_on 'expat' => :executable
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gtk3' => :library
  depends_on 'gtk_layer_shell' => :executable
  depends_on 'gvfs' => :build
  depends_on 'harfbuzz' => :library
  depends_on 'icu4c' # R
  depends_on 'libbsd' => :executable
  depends_on 'libexif' => :executable
  depends_on 'libice' => :executable
  depends_on 'libmd' # R
  depends_on 'libnotify' => :executable
  depends_on 'libsm' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxau' => :executable
  depends_on 'libxcb' => :executable
  depends_on 'libxdmcp' => :executable
  depends_on 'libxext' # R
  depends_on 'libxml2' => :executable
  depends_on 'libxrandr' => :executable
  depends_on 'libxrender' # R
  depends_on 'mate_desktop' => :executable
  depends_on 'pango' => :library
  depends_on 'util_linux' => :executable
  depends_on 'wayland' => :executable
  depends_on 'zlib' => :library

  gnome

  autotools_configure_options '--enable-wayland'

  def self.prebuild
    ConvenienceFunctions.libtoolize('libuuid', 'util_linux')
  end
end
