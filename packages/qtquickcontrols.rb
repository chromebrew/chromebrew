# Adapted from Arch Linux qt5-quickcontrols PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/qt5-quickcontrols/trunk/PKGBUILD

require 'package'

class Qtquickcontrols < Package
  description 'Reusable Qt Quick based UI controls to create classic desktop-style user interfaces'
  homepage 'https://www.qt.io'
  version '5.15.9-eb9dead'
  license 'GPL3 LGPL3 FDL custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtquickcontrols.git'
  git_hashtag 'eb9dead185ae209dd2364d09db74d8ab613d982d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtquickcontrols/5.15.9-eb9dead_armv7l/qtquickcontrols-5.15.9-eb9dead-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtquickcontrols/5.15.9-eb9dead_armv7l/qtquickcontrols-5.15.9-eb9dead-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtquickcontrols/5.15.9-eb9dead_x86_64/qtquickcontrols-5.15.9-eb9dead-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4ba67770f5782c5aaf0e38f414b988b3b8376263e989bee216c3d19c9e953396',
     armv7l: '4ba67770f5782c5aaf0e38f414b988b3b8376263e989bee216c3d19c9e953396',
     x86_64: '4a8cfe69df169eaf5c8b3e17ecc0d25d4a5ab1831a0ce7d4a50c0f032272763a'
  })

  depends_on 'gcc' # R
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
