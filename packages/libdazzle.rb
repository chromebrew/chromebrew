require 'buildsystems/meson'

class Libdazzle < Meson
  description 'The libdazzle library is a companion library to GObject and Gtk+.'
  homepage 'https://gitlab.gnome.org/GNOME/libdazzle/'
  version '3.44.0'
  license 'GPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libdazzle.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '52e3f53104ecfd23518fd1d74be8029ceee5e888f1b0f87356f660ca2ef1b61e',
     armv7l: '52e3f53104ecfd23518fd1d74be8029ceee5e888f1b0f87356f660ca2ef1b61e',
     x86_64: 'da118b278df9520003ffd8e7e2fdcebc28ab553b6a3c0b9491637b886ef919c5'
  })

  depends_on 'cairo'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gtk3'
  depends_on 'pango'
  depends_on 'vala' => :build
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R

  gnome
end
