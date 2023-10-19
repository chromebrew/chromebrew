require 'package'

class Qt5_serialport < Package
  description 'Qt Serial Port'
  homepage 'https://www.qt.io/'
  version '5.15.11-3380465'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtserialport.git'
  git_hashtag '3380465d5d4977326616c5e57789a81681be650e' # from kde/5.15 branch

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
