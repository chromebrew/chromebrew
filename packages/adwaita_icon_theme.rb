require 'buildsystems/meson'

class Adwaita_icon_theme < Meson
  description 'Theme consisting of a set of icons for GTK+'
  homepage 'https://gitlab.gnome.org/GNOME/adwaita-icon-theme'
  version '46.rc'
  license 'LGPL-3 and CC-BY-SA-4.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/adwaita-icon-theme.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b9758f5261c1e37870387bd852928a74bb57c1d49482405730b3e9ce58c06a50',
     armv7l: 'b9758f5261c1e37870387bd852928a74bb57c1d49482405730b3e9ce58c06a50',
     x86_64: '1ab8a6010d91bb3dd6e4a7f844ed505f8b3f4cd3dba5f607818ac486ad65019b'
  })

  depends_on 'cantarell_fonts' # L
  depends_on 'gdk_pixbuf' => :build
  depends_on 'gtk3' => :build
  depends_on 'librsvg' => :build
  depends_on 'vala' => :build
  depends_on 'xdg_base'

  gnome

  def self.postinstall
    # This is skipped when DESTDIR is set during build.
    system "gtk-update-icon-cache -qtf #{CREW_PREFIX}/share/icons/Adwaita" if File.file?("#{CREW_PREFIX}/bin/gtk-update-icon-cache")
  end
end
