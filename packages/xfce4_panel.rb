require 'package'

class Xfce4_panel < Package
  description 'Next generation panel for the XFCE desktop environment'
  homepage 'https://xfce.org/'
  version '4.16.3'
  license 'GPL-2+ and LGPL-2.1+'
  compatibility 'all'
  source_url 'https://archive.xfce.org/src/xfce/xfce4-panel/4.16/xfce4-panel-4.16.3.tar.bz2'
  source_sha256 '5934eaed8a76da52c29b734ccd79600255420333dd6ebd8fd9f066379af1e092'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xfce4_panel/4.16.3_armv7l/xfce4_panel-4.16.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xfce4_panel/4.16.3_armv7l/xfce4_panel-4.16.3-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xfce4_panel/4.16.3_i686/xfce4_panel-4.16.3-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xfce4_panel/4.16.3_x86_64/xfce4_panel-4.16.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'be479ecd57ca0a60f2ca69ea39f4a65d240dae52f72f36da7e7280dbe007768c',
     armv7l: 'be479ecd57ca0a60f2ca69ea39f4a65d240dae52f72f36da7e7280dbe007768c',
       i686: '34d5df943fb926b7a0a87f222163cd532f320da80e74dda59131cbd8835bd8c7',
     x86_64: 'fb4ddea55c05ed590a0c0b5d6bf383197182af9be828f9324279f3d3c9c8d694'
  })

  depends_on 'libwnck'
  depends_on 'libxfce4ui'
  depends_on 'xfconf'
  depends_on 'garcon'
  depends_on 'exo'
  depends_on 'gtk3'

  def self.patch
    system 'filefix'
  end

  def self.build
    system <<~BUILD
      [ -x autogen.sh ] && env NOCONFIGURE='1' ./autogen.sh
      env #{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
        --disable-static \
        --enable-gio-unix

      make
    BUILD
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    system 'gtk-update-icon-cache', '-f', '-t', "#{CREW_PREFIX}/share/icons/hicolor"
  end
end
