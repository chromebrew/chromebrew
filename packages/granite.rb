require 'buildsystems/meson'

class Granite < Meson
  description 'Library that extends GTK with common widgets and utilities'
  homepage 'https://github.com/elementary/granite'
  version '6.2.0'
  license 'LGPL-3.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/elementary/granite.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6d9ff541ccd52c404af93fa0126073e4eefcecd7a05cef32d15661c699dde3e5',
     armv7l: '6d9ff541ccd52c404af93fa0126073e4eefcecd7a05cef32d15661c699dde3e5',
     x86_64: '30a4237114c1f8d37d1c86b31a5b62ae3abdaa72890b740bb4dea7049b60e42b'
  })

  gnome

  depends_on 'mesonbuild' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection'
  depends_on 'gsettings_desktop_schemas' # R
  depends_on 'gtk3' # R
  depends_on 'libgee' # R
  depends_on 'sassc'
  depends_on 'vala'
end
