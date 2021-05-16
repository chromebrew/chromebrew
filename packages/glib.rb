require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  @_ver = '2.68.2'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.68.2_armv7l/glib-2.68.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.68.2_armv7l/glib-2.68.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.68.2_i686/glib-2.68.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.68.2_x86_64/glib-2.68.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '51cca2bdab9b0d8725010d9627e1af90553bd80627c7c0ca7822eb1d48977d5e',
     armv7l: '51cca2bdab9b0d8725010d9627e1af90553bd80627c7c0ca7822eb1d48977d5e',
       i686: '9edb7d402f59d21ed282bfd68b45c3bfe896a6edd0c6d5fed6b284e42532f8d3',
     x86_64: '3f6a6728ad5b7e8b048665e2258ea22cf9ee5fa5c60c7e57d8172ada16486932'
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
