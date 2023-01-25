require 'package'

class Qtlocation < Package
  description 'Qt Location and Positioning'
  homepage 'https://www.qt.io/'
  version '5.15.7-f920a6c'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'all'
  source_url 'https://invent.kde.org/qt/qt/qtlocation.git'
  git_hashtag 'f920a6cc2931402023840c223fce2fed321e28ea'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtlocation/5.15.7-f920a6c_armv7l/qtlocation-5.15.7-f920a6c-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtlocation/5.15.7-f920a6c_armv7l/qtlocation-5.15.7-f920a6c-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtlocation/5.15.7-f920a6c_i686/qtlocation-5.15.7-f920a6c-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtlocation/5.15.7-f920a6c_x86_64/qtlocation-5.15.7-f920a6c-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3a36632c9be6115855132ef781d0853eb1e797efd9c4bc1dec23622ffb3e4dc6',
     armv7l: '3a36632c9be6115855132ef781d0853eb1e797efd9c4bc1dec23622ffb3e4dc6',
       i686: '5833b4f1478eed73c0000f8f0fb08ae03a109d3c978b83e24f41cfa056c3ebd6',
     x86_64: '43fb59928d9ddea0cc558407395a5c25611555867bfe42e3101573c8df2c6d43'
  })

  depends_on 'qtbase' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'qtbase' # R

  def self.build
    system 'qmake'
    system 'make'
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
  end
end
