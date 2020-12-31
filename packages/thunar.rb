require 'package'

class Thunar < Package
  description 'Thunar File Manager'
  homepage 'https://docs.xfce.org/xfce/thunar/Start'
  version '4.16.1'
  compatibility 'all'
  source_url "https://archive.xfce.org/src/xfce/thunar/4.16/thunar-#{version}.tar.bz2"
  source_sha256 'da2d17d2cb69eb33768690b714cc232ed367cbd71eb9543aaa2a805d05dc3ce1'

  depends_on 'exo'
  depends_on 'libexif'
  depends_on 'libgudev'
  depends_on 'libnotify'
  depends_on 'xfce4_panel'
  depends_on 'desktop_file_utilities'
  depends_on 'hicolor_icon_theme'
  depends_on 'xdg_base'
  depends_on 'wayland_protocols'
  depends_on 'mesa'

  def self.build
    system "./configure #{CREW_OPTIONS} --enable-gio-unix --enable-gudev --enable-exif --enable-pcre --disable-static --enable-notifications"
    system "make -j#{CREW_NPROC}"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
    system "cat <<'EOF'> Thunar
WAYLAND_DISPLAY=wayland-0
GDK_BACKEND=wayland
DISPLAY=
#{CREW_PREFIX}/bin/#{CREW_BUILD}-thunar $@
EOF"
    system "install -Dm755 Thunar #{CREW_DEST_PREFIX}/bin/Thunar"
    # FileUtils.ln_sf "#{CREW_PREFIX}/bin/#{CREW_BUILD}-thunar", "#{CREW_DEST_PREFIX}/bin/Thunar"
  end    
end
