require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  @_ver = '2.70.1'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.70.1_armv7l/glib-2.70.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.70.1_armv7l/glib-2.70.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.70.1_i686/glib-2.70.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.70.1_x86_64/glib-2.70.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '35ff6b5b193f8cdee2860fa3a4ea0e4d1883ed8b4aa8b92133668b00e81befdb',
     armv7l: '35ff6b5b193f8cdee2860fa3a4ea0e4d1883ed8b4aa8b92133668b00e81befdb',
       i686: '36dc278935817052f3c82942f09e1acd5d3235249b45362d035fb4c98c480b9d',
     x86_64: '7592825461594bd7884ea2f245cd877bda9958c49f4c00441f3b3ce774eb5de4'
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
