# Adapted from Arch Linux qt5-webchannel PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/qt5-webchannel/trunk/PKGBUILD

require 'buildsystems/qmake'

class Qt5_webchannel < Qmake
  description 'Provides access to QObject or QML objects from HTML clients for seamless integration of Qt applications with HTML/JavaScript clients'
  homepage 'https://www.qt.io'
  version '5.15.11-f84887c-1'
  license 'GPL3 LGPL3 FDL custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtwebchannel.git'
  git_hashtag 'f84887c1aee4ab04af375e639ae965c9ea2186a5' # from kde/5.15 branch

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_webchannel/5.15.11-f84887c-1_armv7l/qt5_webchannel-5.15.11-f84887c-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_webchannel/5.15.11-f84887c-1_armv7l/qt5_webchannel-5.15.11-f84887c-1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_webchannel/5.15.11-f84887c-1_x86_64/qt5_webchannel-5.15.11-f84887c-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '90a95da431935e73b986f26185ea64f557341bc337dda5ecaffccc5b5120d462',
     armv7l: '90a95da431935e73b986f26185ea64f557341bc337dda5ecaffccc5b5120d462',
     x86_64: '504cb7151f15ca9dd4b27674477dcb7d1d6e4dfdbef7d0b7b3d59954352e961d'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
end
