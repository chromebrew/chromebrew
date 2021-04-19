require 'package'

class Thunar < Package
  description 'Thunar File Manager'
  homepage 'https://docs.xfce.org/xfce/thunar/Start'
  @_ver = '4.17.1'
  version @_ver
  license 'GPL-2+ and LGPL-2+'
  compatibility 'all'
  source_url "https://archive.xfce.org/src/xfce/thunar/#{@_ver.rpartition('.')[0]}/thunar-#{@_ver}.tar.bz2"
  source_sha256 '33f99656d5f01b8ec6c3faa9a9f645c264cd460029ad08d96ba76925c43f2571'

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
