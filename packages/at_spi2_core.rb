require 'buildsystems/meson'

class At_spi2_core < Meson
  description 'This is over DBus, tookit widgets provide their content to screen readers such as Orca'
  homepage 'https://www.freedesktop.org/wiki/'
  version '2.57.1'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/at-spi2-core.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fd7bce5f199b338dbad5988d16e2ea8b5884c678bdbf3bc380abcd96dbc51d78',
     armv7l: 'fd7bce5f199b338dbad5988d16e2ea8b5884c678bdbf3bc380abcd96dbc51d78',
     x86_64: '67d1e7d13034729dd04e71b6cf4072a377b6c6f428453420951c98aa63c8291e'
  })

  depends_on 'dbus' # R
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'libx11' # R
  depends_on 'libxcb' => :build
  depends_on 'libxext' => :build
  depends_on 'libxfixes' => :build
  depends_on 'libxi' # R
  depends_on 'libxtst' # R

  gnome
end
