require 'buildsystems/meson'

class Gobject_introspection < Meson
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/Projects/GObjectIntrospection'
  version "1.86.0-1-#{CREW_PY_VER}"
  license 'LGPL-2+ and GPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gobject-introspection.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0ef77fbbf1a6d5f0b602da23e4d1b0beb90fa02173a5947a7235c16090742bbc',
     armv7l: '0ef77fbbf1a6d5f0b602da23e4d1b0beb90fa02173a5947a7235c16090742bbc',
       i686: '5de31fe6e3b237581940dcddcce91e08b0180391d6c9e2d9e9b68cbd958e755d',
     x86_64: '59ebd671fe4da9355b6c5baba84014fd2f7f45d3cc4b2746e0a48e2a9487f160'
  })

  # Note that this build does not work on i686 if glib is installed.
  depends_on 'gcc_lib' # R
  depends_on 'glib' => :library
  depends_on 'glib_stub' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libffi' => :library
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' # R
end
