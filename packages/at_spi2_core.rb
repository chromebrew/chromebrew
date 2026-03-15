require 'buildsystems/meson'

class At_spi2_core < Meson
  description 'This is over DBus, tookit widgets provide their content to screen readers such as Orca'
  homepage 'https://ftp.gnome.org/pub/gnome/sources/at-spi2-core'
  version '2.60.0'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/at-spi2-core.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b9cdb0c33062bbb20b6c88a74f7a3afe49c420c91c4e2853081b4211af87fb68',
     armv7l: 'b9cdb0c33062bbb20b6c88a74f7a3afe49c420c91c4e2853081b4211af87fb68',
     x86_64: '9518405d9121068866e562178be368b757d3735f9a7670e8954b19440ef46d6c'
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
  depends_on 'libxtst' => :executable_only

  gnome
end
