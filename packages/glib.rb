require 'buildsystems/meson'

class Glib < Meson
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.90.0'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a073ae862169932843d1c153c7794fdfb3b339691dc558df371147e9b193afb5',
     armv7l: 'a073ae862169932843d1c153c7794fdfb3b339691dc558df371147e9b193afb5',
       i686: '24871a3e313c8a57a0bec5374fb6ae0b6ff0f54feb69af70d29fc2ac70229d23',
     x86_64: '597e31725e5c242aca36e08fec8fe2e9e7def927f97675847896478d9a56bf2d'
  })

  depends_on 'elfutils' => :executable
  depends_on 'gcc_lib' => :library
  depends_on 'glib_stub' => :build
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
