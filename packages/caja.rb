# Adapted from Arch Linux caja PKGBUILD at:
# https://github.com/archlinux/svntogit-community/blob/packages/caja/trunk/PKGBUILD

require 'buildsystems/autotools'

class Caja < Autotools
  description 'Caja file manager for the MATE desktop'
  homepage 'https://mate-desktop.org'
  version '1.28.0'
  license 'GPL-2+ LGPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://pub.mate-desktop.org/releases/#{version.rpartition('.')[0]}/caja-#{version}.tar.xz"
  source_sha256 '1e3014ce1455817ec2ef74d09efdfb6835d8a372ed9a16efb5919ef7b821957a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0b9f66473078dd9f81b039fe44b5547f66f2404f0858e09cc46d5e1127f8a25d',
     armv7l: '0b9f66473078dd9f81b039fe44b5547f66f2404f0858e09cc46d5e1127f8a25d',
     x86_64: '74eff4aaec8f5d73efb4f4e8f25f8cfb9b3b2dcb919c2a3f1e6034868cca9708'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'dconf' # R
  depends_on 'exempi' # R
  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'gtk_layer_shell' # R
  depends_on 'gvfs' => :build
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'libbsd' # R
  depends_on 'libexif' # R
  depends_on 'libice' # R
  depends_on 'libmd' # R
  depends_on 'libnotify' # R
  depends_on 'libsm' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxext' # R
  depends_on 'libxml2' # R
  depends_on 'libxrandr' # R
  depends_on 'libxrender' # R
  depends_on 'mate_desktop' # R
  depends_on 'pango' # R
  depends_on 'util_linux' # R
  depends_on 'wayland' # R
  depends_on 'zlibpkg' # R

  configure_options '--enable-wayland'

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
  end
end
