require 'buildsystems/meson'

class Glib < Meson
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://docs.gtk.org/glib/'
  version '2.85.0'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'db3148e9fe0cbdcdf5b979c2a18c560308db615454ee9997e12e906d6b6313c8',
     armv7l: 'db3148e9fe0cbdcdf5b979c2a18c560308db615454ee9997e12e906d6b6313c8',
       i686: '4f6e9b0d317e2750b8e5fc317ccdf79b1fe17688f33f1b0cf89c2514e42e6b0c',
     x86_64: '59356454a19aa10e23544575b38e112d9e5669452f9edd4098762ae9f813c7c2'
  })

  depends_on 'elfutils' # R
  depends_on 'gcc_lib' # R
  # depends_on 'gobject_introspection' unless ARCH == 'i686' # L
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
