require 'package'

class Qt5_declarative < Package
  description 'Provides QML and Quick declaratives.'
  homepage 'https://www.qt.io/'
  version '5.15.11-1b0e366'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception and LGPL-3'
  compatibility 'x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtdeclarative.git'
  git_hashtag '1b0e366092bcfae0392592c3b7891f0e47af1018' # from kde/5.15 branch

  binary_url({})
  binary_sha256({})

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R

  def self.build
    system 'qmake'
    system 'make || make'
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
  end
end
