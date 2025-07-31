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
    aarch64: 'bff19df2b2e30b26d075612c61fe87ed17f215f4ab3791423e9790b183540628',
     armv7l: 'bff19df2b2e30b26d075612c61fe87ed17f215f4ab3791423e9790b183540628',
       i686: '8d94ca964353e3b28f18964e2a5a1d0b3393b8058bfde3025706d311895308db',
     x86_64: 'b68a3863af660fd462fc1faedc086f85105f1c86d2fa4ce38add7d6cb374bd3f'
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
