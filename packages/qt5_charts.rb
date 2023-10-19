require 'package'

class Qt5_charts < Package
  description 'Qt Charts'
  homepage 'https://www.qt.io/'
  version '5.15.11-e17308d'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtcharts.git'
  git_hashtag 'e17308d5ce83a8b66aeeaaaf16ce16d4ee6b2826' # from kde/5.15 branch

  binary_url({})
  binary_sha256({})

  depends_on 'qt5_base'

  def self.build
    system 'qmake'
    system 'make'
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
  end
end
