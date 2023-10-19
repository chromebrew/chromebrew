require 'package'

class Qtx11extras < Package
  description 'Provides classes for developing for the X11 platform.'
  homepage 'https://www.qt.io/'
  version '5.15.9-8bba77a'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtx11extras.git'
  git_hashtag '8bba77a558049727d1bc88736dd03d1b5c41cead'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtx11extras/5.15.9-8bba77a_armv7l/qtx11extras-5.15.9-8bba77a-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtx11extras/5.15.9-8bba77a_armv7l/qtx11extras-5.15.9-8bba77a-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtx11extras/5.15.9-8bba77a_x86_64/qtx11extras-5.15.9-8bba77a-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f38d4a7b21e22ab58b571fb48fda4a2175a6a9426c4bec45d69aecf540dece17',
     armv7l: 'f38d4a7b21e22ab58b571fb48fda4a2175a6a9426c4bec45d69aecf540dece17',
     x86_64: '225bf24774fd718bcbc89c0b681a56c05d65eeb054662f05dc52ae44e6f1aae2'
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
