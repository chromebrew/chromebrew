# Adapted from Arch Linux qt5-webchannel PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/qt5-webchannel/trunk/PKGBUILD

require 'package'

class Qtwebchannel < Package
  description 'Provides access to QObject or QML objects from HTML clients for seamless integration of Qt applications with HTML/JavaScript clients'
  homepage 'https://www.qt.io'
  version '5.15.9-c508ffb'
  license 'GPL3 LGPL3 FDL custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtwebchannel.git'
  git_hashtag 'c508ffb1996eeddfd10dda493974746e6b375080'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtwebchannel/5.15.9-c508ffb_armv7l/qtwebchannel-5.15.9-c508ffb-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtwebchannel/5.15.9-c508ffb_armv7l/qtwebchannel-5.15.9-c508ffb-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtwebchannel/5.15.9-c508ffb_x86_64/qtwebchannel-5.15.9-c508ffb-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7e826edb3047072671e38a9bf062f3803cfc07c06fe8d002797495d5b787025d',
     armv7l: '7e826edb3047072671e38a9bf062f3803cfc07c06fe8d002797495d5b787025d',
     x86_64: 'e702fa7fee745f72374c288142701667d446d7615781f777fbe7fad396df92b3'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qtbase' # R
  depends_on 'qtdeclarative' # R

  def self.build
    system 'qmake'
    system 'make'
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
  end
end
