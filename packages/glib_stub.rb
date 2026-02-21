require 'buildsystems/meson'
Package.load_package("#{__dir__}/glib.rb")

class Glib_stub < Meson
  description 'Glib stub built without gobject_introspection, needed as a build dep for gobject_instrospection'
  homepage 'https://developer.gnome.org/glib'
  version Glib.version
  version '2.86.4'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ba1df16740f4842b26d8c205b3a15b4f0167d0a437e6e9e393346363768aaaf8',
     armv7l: 'ba1df16740f4842b26d8c205b3a15b4f0167d0a437e6e9e393346363768aaaf8',
       i686: '875a214c4ba41a05653b510dc1b96b0f25213dafcd37511dcd6a05672089aaa4',
     x86_64: 'd98bea7dcc189f77a4445ffebe7c7f44daa4638d55ea75837eea9d64935420fa'
  })

  depends_on 'elfutils' => :executable_only
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'pcre2' # R
  depends_on 'py3_pygments' => :build
  depends_on 'shared_mime_info' => :logical
  depends_on 'util_linux' # R
  depends_on 'zlib' # R

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
