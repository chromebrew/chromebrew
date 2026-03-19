require 'buildsystems/meson'

class Glib < Meson
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.88.0'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c3d5dc2da1a4c24ce1af08ce304adb3e4fa9a8514fc215cc82b66c942fb2a351',
     armv7l: 'c3d5dc2da1a4c24ce1af08ce304adb3e4fa9a8514fc215cc82b66c942fb2a351',
       i686: '88b35f0a6f47847c4069539241e35f732e7c1867f9f3f68e3d23741ea20471e1',
     x86_64: '8010ed726613dfd4c70f3af030e6ea42a701abeb232081555d35e2a8ceda95f9'
  })

  depends_on 'elfutils' => :executable
  depends_on 'gcc_lib' # R
  depends_on 'glib_stub' => :build
  depends_on 'gobject_introspection' => :build unless ARCH == 'i686' # L
  depends_on 'libffi' # R
  depends_on 'pcre2' # R
  depends_on 'py3_pygments' => :build
  depends_on 'shared_mime_info' => :logical
  depends_on 'util_linux' # R
  depends_on 'zlib' # R

  conflicts_ok # Conflicts with glib_stub.
  gnome
  no_strip if %w[aarch64 armv7l].include? ARCH

  meson_options '-Dglib_debug=disabled \
    -Dselinux=disabled \
    -Dsysprof=disabled \
    -Dman-pages=disabled \
    -Dtests=false'
end
