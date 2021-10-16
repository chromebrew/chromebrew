require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  @_ver = '2.70.0'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version "#{@_ver}-1"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.70.0_armv7l/glib-2.70.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.70.0_armv7l/glib-2.70.0-chromeos-armv7l.tpxz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.70.0-1_x86_64/glib-2.70.0-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5a3b66e351b9bdf6ebb4ca0c23383cffb8c65bec2c69ed40361d3a790aa39e4c',
     armv7l: '5a3b66e351b9bdf6ebb4ca0c23383cffb8c65bec2c69ed40361d3a790aa39e4c',
    x86_64: 'f387960239452bc78ae156eeec65d81d7435ca0d8620c135836b2a4ec339ceae'
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
