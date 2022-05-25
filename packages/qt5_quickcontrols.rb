# Adapted from Arch Linux qt5-quickcontrols PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/qt5-quickcontrols/trunk/PKGBUILD

require 'buildsystems/qmake'

class Qt5_quickcontrols < Qmake
  description 'Reusable Qt Quick based UI controls to create classic desktop-style user interfaces'
  homepage 'https://www.qt.io'
  version '5.15.11-dcc9055'
  license 'GPL3 LGPL3 FDL custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtquickcontrols.git'
  git_hashtag 'dcc90558d9c0cba41eec7df290943994289b0e87' # from kde/5.15 branch
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_quickcontrols/5.15.11-dcc9055_armv7l/qt5_quickcontrols-5.15.11-dcc9055-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_quickcontrols/5.15.11-dcc9055_armv7l/qt5_quickcontrols-5.15.11-dcc9055-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_quickcontrols/5.15.11-dcc9055_x86_64/qt5_quickcontrols-5.15.11-dcc9055-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0bdf33ff6a84b4fbd3bcbb2785ce792d602591dc63204b1c74fb73c09745ff2a',
     armv7l: '0bdf33ff6a84b4fbd3bcbb2785ce792d602591dc63204b1c74fb73c09745ff2a',
     x86_64: 'd240e406d28b18840c479b193b90a6c02b637b55be993b391e659d5d338acfbf'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
end
