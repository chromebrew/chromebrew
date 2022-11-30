require 'package'

class Qtx11extras < Package
  description 'Provides classes for developing for the X11 platform.'
  homepage 'https://www.qt.io/'
  version '5.15.7-9134cdb'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception and LGPL-3'
  compatibility 'all'
  source_url 'https://invent.kde.org/qt/qt/qtx11extras.git'
  git_hashtag '9134cdba9386e408ce2ffe515ca0c3f6f6c66685'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtx11extras/5.15.7-9134cdb_armv7l/qtx11extras-5.15.7-9134cdb-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtx11extras/5.15.7-9134cdb_armv7l/qtx11extras-5.15.7-9134cdb-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtx11extras/5.15.7-9134cdb_i686/qtx11extras-5.15.7-9134cdb-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtx11extras/5.15.7-9134cdb_x86_64/qtx11extras-5.15.7-9134cdb-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '02e27baed54441a37170ed009702fe21a32da8bee1c9bebfc0248bdc5dd9daf0',
     armv7l: '02e27baed54441a37170ed009702fe21a32da8bee1c9bebfc0248bdc5dd9daf0',
       i686: 'b2baac1b14d2ddaf0fbe481f9e7a1afd9dd40dffadbe8d0aecfc4ba1969c9cf1',
     x86_64: '40c58bbed435f536cf50cb13f51625a0e2c7d72213769069e745282f94683d23'
  })

  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qtbase' # R

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
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
    Dir.chdir('src') do
      system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
    end
    Dir.chdir('src/x11extras') do
      system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
    end
  end
end
