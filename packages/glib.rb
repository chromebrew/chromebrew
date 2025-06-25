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
    aarch64: 'c995ef591d84df90ebb19a05d5a8ef44bb77a01f1779967916f1be06596a7342',
     armv7l: 'c995ef591d84df90ebb19a05d5a8ef44bb77a01f1779967916f1be06596a7342',
       i686: '1273f071eb338b5cd51446d6ba8787bb955b9a0e2769977dac386b4b188102ac',
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
