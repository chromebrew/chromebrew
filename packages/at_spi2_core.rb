require 'buildsystems/meson'

class At_spi2_core < Meson
  description 'This is over DBus, tookit widgets provide their content to screen readers such as Orca'
  homepage 'https://www.freedesktop.org/wiki/'
  version '2.57.0'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/at-spi2-core.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7690c72fe7ceb15b0616fbfe04903118a8a69d15c9376c943c30801e0abab1e1',
     armv7l: '7690c72fe7ceb15b0616fbfe04903118a8a69d15c9376c943c30801e0abab1e1',
     x86_64: '202662f9d518dd14bf4b715aa4b7b880b72f4cd2a66d054fe4b84ce25c486c3f'
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
