# Adapted from Arch Linux qt5-webchannel PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/qt5-webchannel/trunk/PKGBUILD

require 'buildsystems/qmake'

class Qt5_webchannel < Qmake
  description 'Provides access to QObject or QML objects from HTML clients for seamless integration of Qt applications with HTML/JavaScript clients'
  homepage 'https://www.qt.io'
  version '5.15.11-f84887c'
  license 'GPL3 LGPL3 FDL custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtwebchannel.git'
  git_hashtag 'f84887c1aee4ab04af375e639ae965c9ea2186a5' # from kde/5.15 branch

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_webchannel/5.15.11-f84887c_armv7l/qt5_webchannel-5.15.11-f84887c-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_webchannel/5.15.11-f84887c_armv7l/qt5_webchannel-5.15.11-f84887c-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_webchannel/5.15.11-f84887c_x86_64/qt5_webchannel-5.15.11-f84887c-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '379dd10cef54171ed23624632714751d98e4663bb4162c6c04a8117ce479508b',
     armv7l: '379dd10cef54171ed23624632714751d98e4663bb4162c6c04a8117ce479508b',
     x86_64: '88f6941f88078e1cac8d3fab3d78a78782f8727d7669a81bc2cbd413ee70642d'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
end
