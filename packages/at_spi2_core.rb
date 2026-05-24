require 'buildsystems/meson'

class At_spi2_core < Meson
  description 'This is over DBus, tookit widgets provide their content to screen readers such as Orca'
  homepage 'https://ftp.gnome.org/pub/gnome/sources/at-spi2-core'
  version '2.60.4'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/at-spi2-core.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bd7eed12f230a9100576a25eaa44d9eb50791b20489b5154fed22dbbcedb9f0a',
     armv7l: 'bd7eed12f230a9100576a25eaa44d9eb50791b20489b5154fed22dbbcedb9f0a',
     x86_64: '0d653c6bf1c05ffeb7651c925f9355a4861dd81fa1454b27c2d0e58476207850'
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
