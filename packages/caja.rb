# Adapted from Arch Linux caja PKGBUILD at:
# https://github.com/archlinux/svntogit-community/blob/packages/caja/trunk/PKGBUILD

require 'buildsystems/autotools'

class Caja < Autotools
  description 'Caja file manager for the MATE desktop'
  homepage 'https://mate-desktop.org'
  version '1.29.1'
  license 'GPL-2+ LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/mate-desktop/caja.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '00b8fe2fbc095dcd94935ad8313f6831e41e0c25f5fc47071fbfd85600b8625d',
     armv7l: '00b8fe2fbc095dcd94935ad8313f6831e41e0c25f5fc47071fbfd85600b8625d',
     x86_64: '3d7233582cfd6eecd16c6cea8a459430742a6b2c9017860f6171b55e71634112'
  })

  depends_on 'at_spi2_core' => :library
  depends_on 'autoconf_archive' => :build
  depends_on 'cairo' => :library
  depends_on 'dconf' => :executable
  depends_on 'exempi' => :executable
  depends_on 'expat' => :executable
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gtk3' => :library
  depends_on 'gtk_layer_shell' => :executable
  depends_on 'gvfs' => :build
  depends_on 'harfbuzz' => :library
  depends_on 'icu4c' => :build
  depends_on 'libbsd' => :executable
  depends_on 'libexif' => :executable
  depends_on 'libice' => :executable
  depends_on 'libmd' => :build
  depends_on 'libnotify' => :executable
  depends_on 'libsm' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxau' => :executable
  depends_on 'libxcb' => :executable
  depends_on 'libxdmcp' => :executable
  depends_on 'libxext' => :build
  depends_on 'libxml2' => :executable
  depends_on 'libxrandr' => :executable
  depends_on 'libxrender' => :build
  depends_on 'mate_common' => :build
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
