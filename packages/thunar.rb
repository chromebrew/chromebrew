require 'package'

class Thunar < Package
  description 'Thunar File Manager'
  homepage 'https://docs.xfce.org/xfce/thunar/Start'
  version '1.8.16'
  compatibility 'all'
  source_url "https://archive.xfce.org/src/xfce/thunar/1.8/thunar-#{version}.tar.bz2"
  source_sha256 '221338b1cbf14cbee2b9091f9b4e4f47cf6bc9513bbb113762da7ca4f8173c4c'

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
  depends_on 'xcb_util'

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
