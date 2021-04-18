require 'package'

class Clutter_gtk < Package
  description 'The Clutter Gtk package is a library providing facilities to integrate Clutter into GTK+ applications.'
  homepage 'https://wiki.gnome.org/Projects/Clutter'
  compatibility 'all'
  @_ver = '1.8.4'
  version @_ver + '-1'
  license 'LGPL-2.1+'
  source_url "https://download.gnome.org/sources/clutter-gtk/#{@_ver.rpartition('.')[0]}/clutter-gtk-#{@_ver}.tar.xz"
  source_sha256 '521493ec038973c77edcb8bc5eac23eed41645117894aaee7300b2487cb42b06'

  depends_on 'gtk3'
  depends_on 'libgee'
  depends_on 'clutter'

  def self.build
    system "meson #{CREW_MESON_FNO_LTO_OPTIONS} builddir"
    system 'meson', 'configure', 'builddir'
    system 'ninja', '-C', 'builddir'
  end

  def self.install
    system 'env', "DESTDIR=#{CREW_DEST_DIR}", 'ninja', '-C', 'builddir', 'install'
  end
end
