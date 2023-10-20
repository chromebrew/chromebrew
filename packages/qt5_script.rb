require 'package'

class Qt5_script < Package
  description 'Qt Script Tools'
  homepage 'https://www.qt.io/'
  version '5.15.15'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtscript.git'
  git_hashtag "v#{version}-lts"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_script/5.15.15_armv7l/qt5_script-5.15.15-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_script/5.15.15_armv7l/qt5_script-5.15.15-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_script/5.15.15_x86_64/qt5_script-5.15.15-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1e87319717e320ee6492ada9ec42a5a99ddcfe4bd52bf75e843452492e562813',
     armv7l: '1e87319717e320ee6492ada9ec42a5a99ddcfe4bd52bf75e843452492e562813',
     x86_64: '9ee14951c5f44448c0e7c8787d66cadd91ac6ccfda8568dc9afcb39975b26a28'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R

  def self.build
    system 'qmake'
    system 'make'
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
  end
end
