require 'buildsystems/meson'
Package.load_package("#{__dir__}/glib.rb")

class Glib_stub < Meson
  description 'Glib stub built without gobject_introspection, needed as a build dep for gobject_instrospection'
  homepage 'https://developer.gnome.org/glib'
  version Glib.version
  version '2.90.0'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '48440f4633b40f8d3d6da77449c28c4ade96c59cbea2b2a084a9056bab7a2624',
     armv7l: '48440f4633b40f8d3d6da77449c28c4ade96c59cbea2b2a084a9056bab7a2624',
       i686: '6d53923c0f428f66b996a588ec5b6fbb08594118ca93c2d286234f325b341921',
     x86_64: '9318e7aea91f0f6fbf116fb88b3b8599357584407b9317027af01e705dbb66ba'
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
