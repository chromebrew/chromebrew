require 'package'

class Qtx11extras < Package
  description 'Provides classes for developing for the X11 platform.'
  homepage 'https://www.qt.io/'
  version '5.15.1-1'
  compatibility 'all'
  source_url 'http://download.qt.io/official_releases/qt/5.15/5.15.1/submodules/qtx11extras-everywhere-src-5.15.1.tar.xz'
  source_sha256 'f7cd7c475a41840209808bf8b1de1c6587c3c74e5ae3b0969760b9ed35159e59'

  binary_url ({
  })
  binary_sha256 ({
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
