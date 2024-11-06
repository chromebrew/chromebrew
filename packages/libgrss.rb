# Adapted from Arch Linux libgrss PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libgrss/trunk/PKGBUILD

require 'buildsystems/autotools'

class Libgrss < Autotools
  description 'Glib-based library to manage RSS and Atom feeds'
  homepage 'https://wiki.gnome.org/Projects/Libgrss'
  version '0.7.0-ce58'
  license 'LGPLv3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libgrss/-/archive/ce58490680db02913f221cccd73a816eefd2e1f7/libgrss-ce58490680db02913f221cccd73a816eefd2e1f7.tar.bz2'
  source_sha256 '88eab96df1b2004c08f3b14beca038d13306518f3df18745e27788287038ea31'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '3ec7ce667887023dd6766c726f8c054daafe58fe9003f4ac52203f73f956a743',
     armv7l: '3ec7ce667887023dd6766c726f8c054daafe58fe9003f4ac52203f73f956a743',
     x86_64: 'cf9f47cce02e43332117ce05f76c0c61aa7bf35154261e6d175fc4711024a3eb'
  })

  depends_on 'glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'libsoup'

  gnome
end
