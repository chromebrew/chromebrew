require 'package'

class Thunar < Package
  description 'Thunar File Manager'
  homepage 'https://docs.xfce.org/xfce/thunar/Start'
  version '1.8.15'
  compatibility 'all'
  source_url 'https://archive.xfce.org/src/xfce/thunar/1.8/thunar-1.8.15.tar.bz2'
  source_sha256 '7624560cf21f13869804947042610aab22075146b711593f11ceb9e494277c93'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/thunar-1.8.15-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/thunar-1.8.15-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/thunar-1.8.15-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/thunar-1.8.15-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8cffe1931cc432eeeb479c1543166c82198bb8b7d7a135bbb134c0d57f13eeca',
     armv7l: '8cffe1931cc432eeeb479c1543166c82198bb8b7d7a135bbb134c0d57f13eeca',
       i686: '81334057f9499543189c6b9814d72f5c2c2459345ad49ea952e4eced09b1fb6e',
     x86_64: '09fb04bf7b2b5576ae94c300d1d03bf1d853904b75391a26779e1b4bf69b66a9',
  })

  depends_on 'exo'
  depends_on 'libexif'
  depends_on 'libgudev'
  depends_on 'libnotify'
  depends_on 'xfce4_panel'
  depends_on 'desktop_file_utilities'
  depends_on 'hicolor_icon_theme'
  depends_on 'xdg_base'
  depends_on 'wayland'
  depends_on 'wayland_protocols'

  def self.build
    system "./configure #{CREW_OPTIONS} --enable-gio-unix --enable-gudev --enable-exif --enable-pcre --disable-static --enable-notifications"
    system "make -j#{CREW_NPROC}"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/#{CREW_BUILD}-thunar", "#{CREW_DEST_PREFIX}/bin/Thunar"
  end
end
