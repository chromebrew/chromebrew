require 'buildsystems/meson'

class Glib < Meson
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://docs.gtk.org/glib/'
  version '2.83.0'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '186348cf9750baa59c2b1f2c3f155c0c3900d32b3bd14a5adacd21c6b1dbc0ac',
     armv7l: '186348cf9750baa59c2b1f2c3f155c0c3900d32b3bd14a5adacd21c6b1dbc0ac',
       i686: 'd68bb861283879804bedcdd5722bbd7fc3db8906a6d4305587cd2d524e338b2a',
     x86_64: 'ea5490b2e0564b5e14f161f165d11315137d2e01ea9daafb396c11ea10de2b83'
  })

  depends_on 'elfutils' # R
  depends_on 'gcc_lib' # R
  depends_on 'gobject_introspection' unless ARCH == 'i686' # L
  depends_on 'libffi' # R
  depends_on 'pcre2' # R
  depends_on 'py3_pygments' => :build
  depends_on 'shared_mime_info' # L
  depends_on 'util_linux' # R
  depends_on 'zlib' # R

  gnome
  no_strip if %w[aarch64 armv7l].include? ARCH

  meson_options '-Dselinux=disabled \
    -Dsysprof=disabled \
    -Dman-pages=disabled \
    -Dtests=false'
end
