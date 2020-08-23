require 'package'

class Thunar < Package
  description 'Thunar File Manager'
  homepage 'https://docs.xfce.org/xfce/thunar/Start'
  version '1.8.15'
  compatibility 'all'
  source_url 'https://archive.xfce.org/src/xfce/thunar/1.8/thunar-1.8.15.tar.bz2'
  source_sha256 '7624560cf21f13869804947042610aab22075146b711593f11ceb9e494277c93'

  depends_on 'exo'
  depends_on 'libexif'
  depends_on 'libgudev'
  depends_on 'libnotify'
  depends_on 'xfce4_panel'
  depends_on 'desktop_file_utilities'
  depends_on 'hicolor_icon_theme'
  depends_on 'xdg_base'

  def self.build
      system "./configure #{CREW_OPTIONS} --enable-gio-unix --enable-gudev --enable-exif --enable-pcre --disable-static --enable-notifications"
      system "make -j#{CREW_NPROC}"
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
      FileUtils.ln_sf "#{CREW_PREFIX}/bin/#{CREW_BUILD}-thunar", "#{CREW_DEST_PREFIX}/bin/Thunar"
  end
end
