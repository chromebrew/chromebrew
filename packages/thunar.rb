require 'package'

class Thunar < Package
  description 'Thunar File Manager'
  homepage 'https://docs.xfce.org/xfce/thunar/Start'
  version '4.17.3'
  license 'GPL-2+ and LGPL-2+'
  compatibility 'aarch64,armv7l,x86_64'
  source_url "https://archive.xfce.org/src/xfce/thunar/#{version.rpartition('.')[0]}/thunar-#{version}.tar.bz2"
  source_sha256 '4580913d6c88003dbffc7e6d98a843ca0ae0fd1c5fa7b1e49fef565f33c7bea7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/thunar/4.17.3_armv7l/thunar-4.17.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/thunar/4.17.3_armv7l/thunar-4.17.3-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/thunar/4.17.3_x86_64/thunar-4.17.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '4cd11110afd9b2b55ce2c167a494e95fd49e5b44ecece194e2561ea5e9b93c19',
     armv7l: '4cd11110afd9b2b55ce2c167a494e95fd49e5b44ecece194e2561ea5e9b93c19',
     x86_64: 'f567c97ed456b27374b465283081605bb70d6b4a7ff84851580c45891f02945c'
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
