require 'buildsystems/meson'

class At_spi2_core < Meson
  description 'This is over DBus, tookit widgets provide their content to screen readers such as Orca'
  homepage 'https://ftp.gnome.org/pub/gnome/sources/at-spi2-core'
  version '2.60.6'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/at-spi2-core.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3cf94fe3a093e38f4ce5a97dbe5d57f6eb605902db67d5a8e3e9e8dbba6902a3',
     armv7l: '3cf94fe3a093e38f4ce5a97dbe5d57f6eb605902db67d5a8e3e9e8dbba6902a3',
     x86_64: 'b07921d6c646935e5096d3550f2983aa06482cfa2eec722c80fde19407bb7a59'
  })

  depends_on 'dbus' => :library
  depends_on 'gcc_lib' # R
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'libx11' => :library
  depends_on 'libxcb' => :build
  depends_on 'libxext' => :build
  depends_on 'libxfixes' => :build
  depends_on 'libxi' => :library
  depends_on 'libxtst' => :executable
  depends_on 'libxtst' => :library

  gnome
end
