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
    aarch64: 'fad5a9ee1f6cc0ad4d24949333e0ecb2794da54278254468821961945aece430',
     armv7l: 'fad5a9ee1f6cc0ad4d24949333e0ecb2794da54278254468821961945aece430',
     x86_64: 'fc9def10843bd0f15796b4f7e7e3b4b163997972e154808b0dc4624613efb95a'
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
