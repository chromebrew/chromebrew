require 'package'

class Libgnome_games_support < Package
  description 'libgnome-games-support is a small library intended for internal use by GNOME Games.'
  homepage 'https://gitlab.gnome.org/GNOME/libgnome-games-support'
  @_app = name.tr('_', '-')
  @_fullver = '1.8.0'
  @_mainver = @_fullver.rpartition('.')[0]
  @_url = "https://download.gnome.org/sources/#{@_app}/#{@_mainver}/#{@_app}-#{@_fullver}"
  version @_fullver
  source_url "#{@_url}.tar.xz"
  source_sha256 `curl -Ls #{@_url}.sha256sum | tail -n1 | cut -d ' ' -f1`.chomp
  
  depends_on 'gtk3'
  depends_on 'libgee'
  depends_on 'clutter'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
