require 'package'

class Qt5_x11extras < Package
  description 'Provides classes for developing for the X11 platform.'
  homepage 'https://www.qt.io/'
  version 'kde-5.15.14-6c3605f'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtx11extras.git'
  git_hashtag '6c3605fcb3b34e55951f597e06c135d97dfa6cd7'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4f86049b53fc81981615e6a3b3a2dabbcee4b67db238c111143872604f818b31',
     armv7l: '4f86049b53fc81981615e6a3b3a2dabbcee4b67db238c111143872604f818b31',
     x86_64: '97c714e3323700056121a401bfb81270dd6022eb28fed6c08cffeac05fee9a2f'
  })

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
