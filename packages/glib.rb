require 'buildsystems/meson'

class Glib < Meson
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.88.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '334a16aea6f99b96138b4348f6f94e9e487905f260ce4d80e2e4ddc6fecc2ec5',
     armv7l: '334a16aea6f99b96138b4348f6f94e9e487905f260ce4d80e2e4ddc6fecc2ec5',
       i686: '8dfef4d2a2d0b347cf8b0b610c601708eb5b66575e82247b19c35b45d53a480f',
     x86_64: '52b9c401b249eed44ceaec1f8ce7b864818576bdbff1519094640d4bd43861f0'
  })

  depends_on 'elfutils' => :executable
  depends_on 'gcc_lib' # R
  depends_on 'glib_stub' => :build
  depends_on 'gobject_introspection' => :build unless ARCH == 'i686' # L
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
