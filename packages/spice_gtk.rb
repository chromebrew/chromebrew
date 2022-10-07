# Adapted from Arch Linux spice-gtk PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/spice-gtk/trunk/PKGBUILD

require 'package'

class Spice_gtk < Package
  description 'GTK+ client library for SPICE'
  homepage 'https://www.spice-space.org/'
  version '0.41'
  license 'LGPL2.1'
  compatibility 'all'
  source_url 'https://www.spice-space.org/download/gtk/spice-gtk-0.41.tar.xz'
  source_sha256 'd8f8b5cbea9184702eeb8cc276a67d72acdb6e36e7c73349fb8445e5bca0969f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/spice_gtk/0.41_armv7l/spice_gtk-0.41-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/spice_gtk/0.41_armv7l/spice_gtk-0.41-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/spice_gtk/0.41_i686/spice_gtk-0.41-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/spice_gtk/0.41_x86_64/spice_gtk-0.41-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '39ef18a10e919005f06f06b45954c0c2fefe4418a93ffe2a5e4391a1b89d1f46',
     armv7l: '39ef18a10e919005f06f06b45954c0c2fefe4418a93ffe2a5e4391a1b89d1f46',
       i686: '1da2f0ee2d0e8070e1bdaafa0ddda94da3af4136ac19be6fb4132be809e51efd',
     x86_64: 'dda0b408267eee7047e5916f8ba3a14663d0dd1f0b1f1330c674208a970034fe'
  })

  depends_on 'gtk3'
  depends_on 'libcacard'
  depends_on 'libjpeg'
  depends_on 'opus'
  depends_on 'usbredir'
  depends_on 'gstreamer'
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
