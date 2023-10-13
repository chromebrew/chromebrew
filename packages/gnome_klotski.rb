require 'package'

class Gnome_klotski < Package
  description 'A puzzle game for GNOME.'
  homepage 'https://wiki.gnome.org/Apps/Klotski'
  @_ver = '3.38.2'
  version "#{@_ver}-1"
  license 'GPL-3+ and FDL-1.1+'
  compatibility 'all'
  source_url "https://download.gnome.org/sources/gnome-klotski/#{@_ver.rpartition('.')[0]}/gnome-klotski-#{@_ver}.tar.xz"
  source_sha256 '91637845649f3ca709d29f71ee775b946d1112087209f32264e8fad21a0ca0e2'

  depends_on 'clutter_gtk'
  depends_on 'gsound'
  depends_on 'librsvg'
  depends_on 'libgnome_games_support'

  def self.build
    system "meson setup #{CREW_MESON_FNO_LTO_OPTIONS} builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
