# Adapted from Arch Linux libpanel PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libpanel

require 'package'

class Libpanel < Package
  description 'A dock/panel library for GTK 4'
  homepage 'https://gitlab.gnome.org/GNOME/libpanel'
  version '1.0.1'
  license 'GPL3'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libpanel/-/archive/1.0.1/libpanel-1.0.1.tar.bz2'
  source_sha256 '67cc028dd235f41a87d3c2514e2f6c2de56db7eda1331d228b13e6299223948c'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpanel/1.0.1_armv7l/libpanel-1.0.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpanel/1.0.1_armv7l/libpanel-1.0.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpanel/1.0.1_i686/libpanel-1.0.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpanel/1.0.1_x86_64/libpanel-1.0.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '13d08ec057bad8372cd70f36c5bf1b282ffe6ff21504663a32f64ce954b313bc',
     armv7l: '13d08ec057bad8372cd70f36c5bf1b282ffe6ff21504663a32f64ce954b313bc',
       i686: '2b1d5f64d12a0c12d6722b4a7d5dce92ecfaeee56644ed49bfe8b586d0947ea1',
     x86_64: 'b781b3605809ee56a39eede87fed0b1649df1770c0d3f9c2f8307bbc5cb76ef7'
  })

  depends_on 'libadwaita'
  depends_on 'gobject_introspection'
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_smartypants' => :build
  depends_on 'vala' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
