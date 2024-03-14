require 'buildsystems/meson'

class At_spi2_core < Meson
  description 'This is over DBus, tookit widgets provide their content to screen readers such as Orca'
  homepage 'http://www.freedesktop.org/'
  version '2.51.91'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/at-spi2-core.git'
  git_hashtag "AT_SPI2_CORE_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2a4ee7292ec50f043da9c1017b275d97947e340c31406887a0a04b568827b83f',
     armv7l: '2a4ee7292ec50f043da9c1017b275d97947e340c31406887a0a04b568827b83f',
     x86_64: '2565d850954209c289f12dccfcb3c5e088cbcbe3d44eeec33bbe3addc7b5fbaf'
  })

  depends_on 'dbus' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
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
