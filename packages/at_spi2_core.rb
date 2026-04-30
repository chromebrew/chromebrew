require 'buildsystems/meson'

class At_spi2_core < Meson
  description 'This is over DBus, tookit widgets provide their content to screen readers such as Orca'
  homepage 'https://ftp.gnome.org/pub/gnome/sources/at-spi2-core'
  version '2.60.3'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/at-spi2-core.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a5bcf1355c80dbfdb82d9057eb8fb8b4f285951360eed34b0d50748e4c6f21d2',
     armv7l: 'a5bcf1355c80dbfdb82d9057eb8fb8b4f285951360eed34b0d50748e4c6f21d2',
     x86_64: '0323e9a841906b833f77a2d5b909e87051df5082a635a2825b9dd45b262db1e7'
  })

  depends_on 'dbus' => :library
  depends_on 'gcc_lib' # R
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
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
