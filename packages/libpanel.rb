# Adapted from Arch Linux libpanel PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libpanel

require 'buildsystems/meson'

class Libpanel < Meson
  description 'A dock/panel library for GTK 4'
  homepage 'https://gitlab.gnome.org/GNOME/libpanel'
  version '1.0.1'
  license 'GPL3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libpanel/-/archive/1.0.1/libpanel-1.0.1.tar.bz2'
  source_sha256 '67cc028dd235f41a87d3c2514e2f6c2de56db7eda1331d228b13e6299223948c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '13d08ec057bad8372cd70f36c5bf1b282ffe6ff21504663a32f64ce954b313bc',
     armv7l: '13d08ec057bad8372cd70f36c5bf1b282ffe6ff21504663a32f64ce954b313bc',
     x86_64: 'b781b3605809ee56a39eede87fed0b1649df1770c0d3f9c2f8307bbc5cb76ef7'
  })

  depends_on 'libadwaita'
  depends_on 'gobject_introspection'
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_smartypants' => :build
  depends_on 'vala' => :build

  gnome
end
