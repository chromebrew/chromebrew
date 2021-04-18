require 'package'

class Thunar < Package
  description 'Thunar File Manager'
  homepage 'https://docs.xfce.org/xfce/thunar/Start'
  @_ver = '4.17.1'
  version @_ver
  license 'GPL-2+ and LGPL-2+'
  compatibility 'all'
  source_url "https://archive.xfce.org/src/xfce/thunar/#{@_ver.rpartition('.')[0]}/thunar-#{@_ver}.tar.bz2"
  source_sha256 'da2d17d2cb69eb33768690b714cc232ed367cbd71eb9543aaa2a805d05dc3ce1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/thunar-4.16.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/thunar-4.16.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/thunar-4.16.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/thunar-4.16.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f72859ef9d34c9f53b027e3ff4f939d53dfd02e2e14fa1ccba7272857dff6846',
     armv7l: 'f72859ef9d34c9f53b027e3ff4f939d53dfd02e2e14fa1ccba7272857dff6846',
       i686: 'a9968a493f18165318d3c1580e7aef64af66872290eb9f80d3164b3a1d4f06bd',
     x86_64: 'a07083925abfeb69f6e960869a61da8039b8afa0a79c9601f312cdb750ccfb86',
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

  def self.build
    system <<~CONFIGURE
      #{CREW_ENV_OPTIONS} \
      ./configure #{CREW_OPTIONS} \
      --enable-gio-unix \
      --enable-gudev \
      --enable-exif \
      --enable-pcre \
      --disable-static \
      --enable-notifications
    CONFIGURE
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
