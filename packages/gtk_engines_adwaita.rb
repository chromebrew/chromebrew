require 'buildsystems/autotools'

class Gtk_engines_adwaita < Autotools
  description 'Adwaita GTK+2 theme engine.'
  homepage 'https://git.gnome.org/browse/gnome-themes-standard/'
  version '3.27.92'
  license 'LGPL-2.1+'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://github.com/GNOME/gnome-themes-extra/archive/3.27.92.tar.gz'
  source_sha256 'c2c2b02e6826d51de4e6e53afffbdb0ec301ef776df91944574fdc42b558cecb'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'e5b8a68fcf3d91a95867f727e788b51575cf919b794877cca8e34b5e582ebfee',
     armv7l: 'e5b8a68fcf3d91a95867f727e788b51575cf919b794877cca8e34b5e582ebfee',
     x86_64: '403ef26ed4d75165d0e5133af688555f6d076ed662f4ccab8ec301b7dd1de60f'
  })

  depends_on 'gtk3'
  depends_on 'gtk2'
  depends_on 'librsvg'
  depends_on 'gdk_pixbuf'
  depends_on 'cairo'

  gnome
end
