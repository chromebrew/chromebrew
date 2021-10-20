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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.70.0-1_armv7l/glib-2.70.0-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.70.0-1_armv7l/glib-2.70.0-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.70.0-1_i686/glib-2.70.0-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.70.0-1_x86_64/glib-2.70.0-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '1ee370c35e2e73717605624b05642d84f1956520a7e5a20c5c33d6f000e51c90',
     armv7l: '1ee370c35e2e73717605624b05642d84f1956520a7e5a20c5c33d6f000e51c90',
       i686: '1e79e14c7a331589849c1afc28989b9a792dac68a9cec6b1b07b99541a33a8c6',
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
