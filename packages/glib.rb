require 'buildsystems/meson'

class Glib < Meson
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://docs.gtk.org/glib/'
  version '2.85.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '44772d6737d8ed76fcdbbdffd13cc86b6a3054bbc29c90b075365f07001c770f',
     armv7l: '44772d6737d8ed76fcdbbdffd13cc86b6a3054bbc29c90b075365f07001c770f',
       i686: 'bb44cd8cda14a0831bd8fc3c24600aa8cacf7e87cb65722be1717559af314d3c',
     x86_64: 'f6cdaabd743e0c520681b1c101bc39c106f0c316af1716dd0178503bcee195ef'
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
