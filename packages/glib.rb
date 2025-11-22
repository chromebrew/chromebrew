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
    aarch64: '078fc2e0cbec6f2a3ffabc7983decbd531fb2e89f15d89fedbd83a455573a19d',
     armv7l: '078fc2e0cbec6f2a3ffabc7983decbd531fb2e89f15d89fedbd83a455573a19d',
       i686: 'ea903993830032fc0afe98fe320e75fd5abb4d423f7d1a9e19d31db6301ec233',
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
