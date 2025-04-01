require 'package'

class Qt5_x11extras < Package
  description 'Provides classes for developing for the X11 platform.'
  homepage 'https://www.qt.io/'
  kde_5_15_githash = '0c61151bf14e5b4c74187608b6b47b9d0d6ca745'
  version "kde-5.15.16-#{kde_5_15_githash[0, 7]}"
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception and LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtx11extras.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'efd50af83a61451f16ee14f6f82558c8f0e54557a9c66828b57f4ce82d2db316',
     armv7l: 'efd50af83a61451f16ee14f6f82558c8f0e54557a9c66828b57f4ce82d2db316',
     x86_64: 'c9d2490aa4b6ed718cfef7e55e3254b84db3a8cbe5c2a38dd4d66c2bbbe33808'
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
