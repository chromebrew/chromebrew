require 'buildsystems/meson'
Package.load_package("#{__dir__}/glib.rb")

class Glib_stub < Meson
  description 'Glib stub built without gobject_introspection, needed as a build dep for gobject_instrospection'
  homepage 'https://developer.gnome.org/glib'
  version Glib.version
  version '2.90.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '647abec95dab32e1cf5977977bb7f009a6991477d1ce526183420ca6635c7e3f',
     armv7l: '647abec95dab32e1cf5977977bb7f009a6991477d1ce526183420ca6635c7e3f',
       i686: '03c96727be3f701eba596ea11eba0a0eb42fa72423db8b76968e3d8c01609ed7',
     x86_64: 'bcd93862dc83a2ddae4c309c4ed16916d5e143619761f71158de10de6855c30e'
  })

  depends_on 'elfutils' => :executable
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libffi' => :library
  depends_on 'pcre2' => :library
  depends_on 'py3_pygments' => :build
  depends_on 'shared_mime_info' => :logical
  depends_on 'util_linux' => :library
  depends_on 'zlib' => :library

  conflicts_ok # Conflicts with glib.
  gnome
  no_strip if %w[aarch64 armv7l].include? ARCH

  meson_options '-Dglib_debug=disabled \
    -Dintrospection=disabled \
    -Dselinux=disabled \
    -Dsysprof=disabled \
    -Dman-pages=disabled \
    -Dtests=false'
end
