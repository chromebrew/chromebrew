require 'buildsystems/meson'

class Glib < Meson
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.86.4'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '95f41d0f4200cf1b0bb12afeb17597cb79ccb49e25b6f02eb69c16262c3740c8',
     armv7l: '95f41d0f4200cf1b0bb12afeb17597cb79ccb49e25b6f02eb69c16262c3740c8',
       i686: '9f91995177a290de10b1606f9472dd526350a03756d3776abac7e041924eae6c',
     x86_64: 'cb4c184a5bcef8a12a8da961e73e67a601bdeddc8117da621b70aee6b6600a20'
  })

  depends_on 'elfutils' => :executable_only
  depends_on 'gcc_lib' # R
  depends_on 'glib_stub' => :build
  depends_on 'gobject_introspection' => :build unless ARCH == 'i686' # L
  depends_on 'libffi' # R
  depends_on 'pcre2' # R
  depends_on 'py3_pygments' => :build
  depends_on 'shared_mime_info' => :logical
  depends_on 'util_linux' # R
  depends_on 'zlib' # R

  conflicts_ok # Conflicts with glib_stub.
  gnome
  no_strip if %w[aarch64 armv7l].include? ARCH

  meson_options '-Dglib_debug=disabled \
    -Dselinux=disabled \
    -Dsysprof=disabled \
    -Dman-pages=disabled \
    -Dtests=false'
end
