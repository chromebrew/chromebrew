require 'package'

class Qt5_declarative < Package
  description 'Provides QML and Quick declaratives.'
  homepage 'https://www.qt.io/'
  version '5.15.11-1b0e366'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtdeclarative.git'
  git_hashtag '1b0e366092bcfae0392592c3b7891f0e47af1018' # from kde/5.15 branch

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_declarative/5.15.11-1b0e366_x86_64/qt5_declarative-5.15.11-1b0e366-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: 'efb6a6eb5bce1b11dab4d35c5a8855efef2d432b06f24e97fce7e697654add90'
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
