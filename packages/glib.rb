require 'buildsystems/meson'

class Glib < Meson
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.86.2'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ad8ed940863a7d170fede7145bc849997568246d2e8be33a06413c3fec1f5fb9',
     armv7l: 'ad8ed940863a7d170fede7145bc849997568246d2e8be33a06413c3fec1f5fb9',
       i686: '7c1b690926ec8bd96ad15403acf4e838b9d7ae2f095ceaf7d64d0a524a1f360f',
     x86_64: '6fc27c85d461d1d1481b5ffcb0ea8157b83c396b8f69475eaa0a872a8e865883'
  })

  depends_on 'elfutils' # R
  depends_on 'gcc_lib' # R
  depends_on 'gobject_introspection' => :build unless ARCH == 'i686' # L
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
