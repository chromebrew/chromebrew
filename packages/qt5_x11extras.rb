require 'package'

class Qt5_x11extras < Package
  description 'Provides classes for developing for the X11 platform.'
  homepage 'https://www.qt.io/'
  version '5.15.11-5fb2e06'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtx11extras.git'
  git_hashtag '5fb2e067a38d3583684310130f5d8aad064f512f' # from kde/5.15 branch

  binary_url({})
  binary_sha256({})

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R

  def self.build
    # The simple build doesn't work, which is why we have this recursive
    # nonsense.
    system 'qmake qtx11extras.pro'
    system 'make'
    Dir.chdir('src') do
      system 'qmake src.pro'
      system 'make'
    end
    Dir.chdir('src/x11extras') do
      system 'qmake x11extras.pro'
      system 'make'
    end
  end

  def self.install
    system 'make', "prefix=#{CREW_PREFIX}", "INSTALL_ROOT=#{CREW_DEST_DIR}", 'install'
    Dir.chdir('src') do
      system 'make', "prefix=#{CREW_PREFIX}", "INSTALL_ROOT=#{CREW_DEST_DIR}", 'install'
    end
    Dir.chdir('src/x11extras') do
      system 'make', "prefix=#{CREW_PREFIX}", "INSTALL_ROOT=#{CREW_DEST_DIR}", 'install'
    end
  end
end
