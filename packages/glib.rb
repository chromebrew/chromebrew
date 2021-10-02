require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  @_ver = '2.70.0'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.70.0_armv7l/glib-2.70.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.70.0_armv7l/glib-2.70.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.70.0_i686/glib-2.70.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.70.0_x86_64/glib-2.70.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5a3b66e351b9bdf6ebb4ca0c23383cffb8c65bec2c69ed40361d3a790aa39e4c',
     armv7l: '5a3b66e351b9bdf6ebb4ca0c23383cffb8c65bec2c69ed40361d3a790aa39e4c',
       i686: 'aa7fb9b8a770208a1653692c4db68616bd35bfd5add16d121e7f63d6dbf40d5d',
     x86_64: '9f96829a225c86f284513766e9ea833d9fb78928f572a5bd78e12ff1932b957f'
  })

  depends_on 'shared_mime_info' # L
  depends_on 'py3_six' => :build
  depends_on 'py3_pygments' => :build
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

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
  end
end
