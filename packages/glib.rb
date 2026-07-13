require 'buildsystems/meson'

class Glib < Meson
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.88.2'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cae25b0de75010f8066b2e72e74e64582a437c2b42512ef5a9564288c3c50ea0',
     armv7l: 'cae25b0de75010f8066b2e72e74e64582a437c2b42512ef5a9564288c3c50ea0',
       i686: '0d33c7608d6a11419773518af9791fe81bdda464734c750168e662c694937d14',
     x86_64: '9c6d8526cce4a46e3638da954f568cda7bf3c0113b3afc3f69b02604073253cc'
  })

  depends_on 'elfutils' => :executable
  depends_on 'gcc_lib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'libffi' => :library
  depends_on 'pcre2' => :library
  depends_on 'py3_pygments' => :build
  depends_on 'shared_mime_info' => :logical
  depends_on 'util_linux' => :library
  depends_on 'zlib' => :library

  conflicts_ok # Conflicts with glib_stub.
  gnome
  no_strip if %w[aarch64 armv7l].include? ARCH

  meson_options '-Dglib_debug=disabled \
    -Dselinux=disabled \
    -Dsysprof=disabled \
    -Dman-pages=disabled \
    -Dtests=false'
end
