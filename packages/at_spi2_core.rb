require 'buildsystems/meson'

class At_spi2_core < Meson
  description 'This is over DBus, tookit widgets provide their content to screen readers such as Orca'
  homepage 'https://ftp.gnome.org/pub/gnome/sources/at-spi2-core'
  version '2.58.3'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/at-spi2-core.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0841e1ff1754a275cabdef77feca999056741d3b87d2acd9992f67a4c1ec5dce',
     armv7l: '0841e1ff1754a275cabdef77feca999056741d3b87d2acd9992f67a4c1ec5dce',
     x86_64: '5deec07cd42d951e86a3944d46ff0b8d0a110302d1b0063c1b8c59648cad1865'
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
