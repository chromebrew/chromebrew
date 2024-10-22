require 'buildsystems/autotools'

class Clutter < Autotools
  description 'OpenGL based interactive canvas library'
  homepage 'https://www.clutter-project.org'
  version '1.26.4'
  license 'LGPL-2.1+ and FDL-1.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/clutter/1.26/clutter-1.26.4.tar.xz'
  source_sha256 '8b48fac159843f556d0a6be3dbfc6b083fc6d9c58a20a49a6b4919ab4263c4e6'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'a4d7168cb8e718e98ea86fe78993270536b07dd5c362de4961e16161ca61d3ea',
     armv7l: 'a4d7168cb8e718e98ea86fe78993270536b07dd5c362de4961e16161ca61d3ea',
     x86_64: '1fc7d581d9c66bf0d415cddf76e561428d8610513d41c89ed130a84e3acc605c'
  })

  depends_on 'at_spi2_core'
  depends_on 'pango'
  depends_on 'libxi'
  depends_on 'libxcomposite'
  depends_on 'json_glib'
  depends_on 'libgudev'
  depends_on 'libxkbcommon'
  depends_on 'cogl'
  depends_on 'libinput'
  depends_on 'libevdev'
  depends_on 'eudev'
  depends_on 'pygtk'
  depends_on 'glib'
  depends_on 'xdg_base'

  def self.patch
    downloader 'https://raw.githubusercontent.com/void-linux/void-packages/master/srcpkgs/clutter/patches/clutter-x11-startup-error.patch', '8370bf0cf624c638edbd309d7dfc3922d726242312d7f217facff69135f56187'
    system 'patch -Np1 -i clutter-x11-startup-error.patch'
  end

  configure_options '--enable-evdev \
    --enable-evdev-input \
    --enable-wayland-backend \
    --enable-egl-backend \
    --enable-wayland-compositor \
    --enable-gdk-backend'
end
