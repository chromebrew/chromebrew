require 'buildsystems/meson'
Package.load_package("#{__dir__}/glib.rb")

class Glib_stub < Meson
  description 'Glib stub built without gobject_introspection, needed as a build dep for gobject_instrospection'
  homepage 'https://developer.gnome.org/glib'
  version Glib.version
  version '2.90.2'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c11954557582c75ef4dd765a5e3fcc0683f0c5bc1962c73d46fcac8f9c103245',
     armv7l: 'c11954557582c75ef4dd765a5e3fcc0683f0c5bc1962c73d46fcac8f9c103245',
       i686: '78653ebc8c272387b0c59b4860315ff17642fee3e0da570837897340c5bd144e',
     x86_64: '8a44fcd5500ba8ac0a7b8118011c4a029f38e9b2d2218913c45e163116b1792c'
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
