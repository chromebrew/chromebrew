require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  @_ver = '2.69.0'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.69.0_armv7l/glib-2.69.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.69.0_armv7l/glib-2.69.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.69.0_i686/glib-2.69.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.69.0_x86_64/glib-2.69.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256({
    aarch64: '573261af071950bce6f0ed2022cff39ed9fe341a0fc623fda18dd12a246b1392',
     armv7l: '573261af071950bce6f0ed2022cff39ed9fe341a0fc623fda18dd12a246b1392',
       i686: '60f54d5bac8c668f5b932e021b17391560353e6ae8391fed00a6af740620eea5',
     x86_64: 'f2f4cce78c7cedfa0ab73438c83f6aed840b5bdd92b8d0dcb7dea3ef81bd785f',
  })

  depends_on 'pygments' => :build
  depends_on 'shared_mime_info' # L
  depends_on 'six' => :build
  depends_on 'util_linux' # R

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dselinux=disabled \
    -Dsysprof=disabled \
    -Dman=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
