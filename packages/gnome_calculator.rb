require 'package'

class Gnome_calculator < Package
  description 'GNOME desktop calculator'
  homepage 'https://wiki.gnome.org/Apps/Calculator'
  @_ver = '3.38.2'
  version @_ver + '-1'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://download.gnome.org/sources/gnome-calculator/#{@_ver.rpartition('.')[0]}/gnome-calculator-#{@_ver}.tar.xz"
  source_sha256 '8c83cc6433e015d15aa2a0cf3d0b187f7adb92830d39dd2e66076c73192a316b'

  depends_on 'setuptools' => :build
  depends_on 'gtk3'
  depends_on 'gtksourceview'
  depends_on 'itstool'
  depends_on 'libgee'
  depends_on 'libsoup'
  depends_on 'wayland'

  def self.build
    system "meson #{CREW_MESON_FNO_LTO_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    system "update-mime-database #{CREW_PREFIX}/share/mime"
    system 'gdk-pixbuf-query-loaders --update-cache'
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
    
    puts <<~EOT.lightblue
      
      To use the graphical calculator, execute 'gnome-calculator'
    
      To use the command line calculator, execute 'gcalccmd'
    
    EOT
  end
end
