# Adapted from Arch Linux spice-gtk PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/spice-gtk/trunk/PKGBUILD

require 'package'

class Spice_gtk < Package
  description 'GTK+ client library for SPICE'
  homepage 'https://www.spice-space.org/'
  version '0.39'
  license 'LGPL2.1'
  compatibility 'all'
  source_url 'https://www.spice-space.org/download/gtk/spice-gtk-0.39.tar.xz'
  source_sha256 '23acbee197eaaec9bce6e6bfd885bd8f79708332639243ff04833020865713cd'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/spice_gtk/0.39_armv7l/spice_gtk-0.39-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/spice_gtk/0.39_armv7l/spice_gtk-0.39-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/spice_gtk/0.39_i686/spice_gtk-0.39-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/spice_gtk/0.39_x86_64/spice_gtk-0.39-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd26a23484818e6c52a82732768a6835e7327149d0ddfcdbb4822037f9be0eb13',
     armv7l: 'd26a23484818e6c52a82732768a6835e7327149d0ddfcdbb4822037f9be0eb13',
       i686: '9fb35919890630c353a4aed862a18bea37afbb4d8c81382d2f442790845b3794',
     x86_64: '27e17df368702ad0ab6ed295482c2be2c393f7be7998877b0379f85b211f6f37'
  })

  depends_on 'gtk3'
  depends_on 'libcacard'
  depends_on 'libjpeg'
  depends_on 'opus'
  depends_on 'usbredir'
  depends_on 'gst_plugins_base'
  depends_on 'gst_plugins_good'
  depends_on 'gobject_introspection' => :build
  depends_on 'py3_pygments' => :build
  depends_on 'py3_pygments' => :build
  depends_on 'spice_protocol' => :build
  depends_on 'usbutils' => :build
  depends_on 'vala' => :build

  def self.build
    system "meson \
      #{CREW_MESON_OPTIONS} \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
