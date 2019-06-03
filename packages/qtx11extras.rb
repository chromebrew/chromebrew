require 'package'

class Qtx11extras < Package
  description 'Provides classes for developing for the X11 platform.'
  homepage 'https://www.qt.io/'
  version '5.12.3'
  source_url 'http://download.qt.io/official_releases/qt/5.12/5.12.3/submodules/qtx11extras-everywhere-src-5.12.3.tar.xz'
  source_sha256 '85e3ae5177970c2d8656226d7535d0dff5764c100e55a79a59161d80754ba613'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/qtx11extras-5.12.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/qtx11extras-5.12.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/qtx11extras-5.12.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qtx11extras-5.12.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f88300f9d8d06dd02a44570832881dcc79e40a41e41a3e418122512eacce6f99',
     armv7l: 'f88300f9d8d06dd02a44570832881dcc79e40a41e41a3e418122512eacce6f99',
       i686: 'a2151e5240dafae30e73e7b2998b7b4c216478d780e4534540f48f817f5ee3a4',
     x86_64: 'd0f65e142afaad622feb7fc8f25c04f3aed698677634115106ad4be3a3f75671',
  })

  depends_on 'qtbase'

  def self.build
    system 'qmake && make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}"
    system "cp -a lib/* #{CREW_DEST_LIB_PREFIX}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r 'include', "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r 'mkspecs', "#{CREW_DEST_PREFIX}/share/Qt-5"
  end
end
