require 'package'

class Qt5_svg < Package
  description 'Provides classes for displaying the contents of SVG files.'
  homepage 'https://www.qt.io/'
  version '5.15.11-7d6e373'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtsvg.git'
  git_hashtag '7d6e373c7db9c05ef586db0eb50c87cd894229ad' # from kde/5.15 branch

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
