require 'package'

class Qt5_script < Package
  description 'Qt Script Tools'
  homepage 'https://www.qt.io/'
  version '5.15.15'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtscript.git'
  git_hashtag "v#{version}-lts"

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
