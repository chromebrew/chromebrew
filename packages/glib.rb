require 'buildsystems/meson'

class Glib < Meson
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.88.3'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '765b9c91846ca8bd9d011aab18d085c0e762d5f2aa7ba5873bdb4a51827c875b',
     armv7l: '765b9c91846ca8bd9d011aab18d085c0e762d5f2aa7ba5873bdb4a51827c875b',
       i686: '2f496045a09a20a75ff7b431f41f7e0ef3218e1214489fbba211d983c6365598',
     x86_64: 'e99f4f9de168653f4746dfac327a6667821921693b1251227eae7eea49f29594'
  })

  depends_on 'elfutils' => :executable
  depends_on 'gcc_lib' => :library
  depends_on 'glib_stub' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'libffi' => :library
  depends_on 'pcre2' => :library
  depends_on 'py3_pygments' => :build
  depends_on 'shared_mime_info' => :logical
  depends_on 'util_linux' => :library
  depends_on 'zlib' => :library

  conflicts_ok # Conflicts with glib_stub.
  gnome
  no_strip if %w[aarch64 armv7l].include? ARCH

  meson_options '-Dglib_debug=disabled \
    -Dselinux=disabled \
    -Dsysprof=disabled \
    -Dman-pages=disabled \
    -Dtests=false'
end
