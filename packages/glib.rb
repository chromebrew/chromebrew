require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  @_ver = '2.73.3'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.73.3_armv7l/glib-2.73.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.73.3_armv7l/glib-2.73.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.73.3_i686/glib-2.73.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.73.3_x86_64/glib-2.73.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e9f48baa0b5b5a7e26c66222c4ad2755dbc2c3ebd0c0a289bcf18692c6db66ce',
     armv7l: 'e9f48baa0b5b5a7e26c66222c4ad2755dbc2c3ebd0c0a289bcf18692c6db66ce',
       i686: '42375aaa9269c03b17cbb4be28e731e8715fdad2bcf8bbaa1d5173b735c2494a',
     x86_64: 'a6371052a98f6b20a9f00fb0ebe082d36d1933a18c258a4004f94d5052ec0284'
  })

  depends_on 'elfutils' # R
  depends_on 'libffi' # R
  depends_on 'pcre' # R
  depends_on 'py3_pygments' => :build
  depends_on 'py3_six' => :build
  depends_on 'shared_mime_info' # L
  depends_on 'util_linux' # R
  depends_on 'zlibpkg' # R
  no_env_options
  patchelf
  gnome

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
