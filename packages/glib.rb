require 'buildsystems/meson'

class Glib < Meson
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://docs.gtk.org/glib/'
  version '2.85.2'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3db8cbdb2b4e7d3c03276a785d783b77fe36ebc216d425a66e9fa8eaf80cfc6c',
     armv7l: '3db8cbdb2b4e7d3c03276a785d783b77fe36ebc216d425a66e9fa8eaf80cfc6c',
       i686: 'ef996bd4c92fd368565c654fd86f014d590d7c52fc7d818de61d6984faaa4677',
     x86_64: '937e03ddaaee89539505f843f5bc36b57c0ad7a8611700aa58ecb8238d0e3db8'
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
