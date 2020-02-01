require 'package'

class Qtx11extras < Package
  description 'Provides classes for developing for the X11 platform.'
  homepage 'https://www.qt.io/'
  version '5.12.3-1'
  source_url 'http://download.qt.io/official_releases/qt/5.12/5.12.3/submodules/qtx11extras-everywhere-src-5.12.3.tar.xz'
  source_sha256 '85e3ae5177970c2d8656226d7535d0dff5764c100e55a79a59161d80754ba613'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/qtx11extras-5.12.3-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/qtx11extras-5.12.3-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/qtx11extras-5.12.3-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qtx11extras-5.12.3-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '730db647ee53c29484da0ee0bfdf9ffd5f239c5155dbe1664b9d776c9bffd55b',
     armv7l: '730db647ee53c29484da0ee0bfdf9ffd5f239c5155dbe1664b9d776c9bffd55b',
       i686: 'ad8cd860ab1b1846973e490b76bb015a8dd5ad13f874a9c8ae45f634db244011',
     x86_64: '0eafd80bc09b178f93b0553352098a281ad90f88323121becb0b98842bc980a2',
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
    FileUtils.cp_r 'src', "#{CREW_DEST_PREFIX}/share/Qt-5"
  end
end
