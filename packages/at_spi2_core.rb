require 'buildsystems/meson'

class At_spi2_core < Meson
  description 'This is over DBus, tookit widgets provide their content to screen readers such as Orca'
  homepage 'https://ftp.gnome.org/pub/gnome/sources/at-spi2-core'
  version '2.62.0.1'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/at-spi2-core.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f80e12db9dc03c303511542af4d4f254e5ff041b98005f8c4ffd4638c9e72ad9',
     armv7l: 'f80e12db9dc03c303511542af4d4f254e5ff041b98005f8c4ffd4638c9e72ad9',
     x86_64: 'da93627089a271fde76c417082e82dab053844e20fc2e2ab0dfb4a0ad6369c77'
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
