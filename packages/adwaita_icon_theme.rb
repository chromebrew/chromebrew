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
    aarch64: '565d1fd47c6f327d21fb4e589ac8037484c72424ab71c8e8dfc3da2eb932b437',
     armv7l: '565d1fd47c6f327d21fb4e589ac8037484c72424ab71c8e8dfc3da2eb932b437',
     x86_64: '4c49fd45d5be47a4c50dd0c69ff192593b602dfe8042a847dfbe2f468483c2b5'
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
