require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  @_ver = '2.68.3'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.68.3_armv7l/glib-2.68.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.68.3_armv7l/glib-2.68.3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.68.3_i686/glib-2.68.3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.68.3_x86_64/glib-2.68.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '640d0eecf23f8772e38ac490b9c491eb59899d9a1dc50b346e499877363fc629',
     armv7l: '640d0eecf23f8772e38ac490b9c491eb59899d9a1dc50b346e499877363fc629',
       i686: '95880703d43a11a6df0d22b7ad1f94272690f1ada158d69506cf9629ac929877',
     x86_64: 'b0e7d349295d9ba8b01347f0198ab327345f5b8e2c8ad3fab6b6ee584fe03971'
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
