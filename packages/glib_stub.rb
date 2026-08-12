require 'buildsystems/meson'
Package.load_package("#{__dir__}/glib.rb")

class Glib_stub < Meson
  description 'Glib stub built without gobject_introspection, needed as a build dep for gobject_instrospection'
  homepage 'https://developer.gnome.org/glib'
  version Glib.version
  version '2.88.3'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '56b17b33e97b3a487d547538247e20589f59331bf309b72b048b277b62f1ebdd',
     armv7l: '56b17b33e97b3a487d547538247e20589f59331bf309b72b048b277b62f1ebdd',
       i686: '700e7846686f08a678c15aa4c835e07313548d02e0513c6602617fe08508245f',
     x86_64: '7e47a90a4791957868ae58a87c4e9e98aee81435fcaa60b9e283ca8f0d02f6f2'
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
