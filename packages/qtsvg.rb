require 'package'

class Qtsvg < Package
  description 'Provides classes for displaying the contents of SVG files.'
  homepage 'https://www.qt.io/'
  version '5.15.1'
  compatibility 'all'
  source_url 'http://download.qt.io/official_releases/qt/5.15/5.15.1/submodules/qtsvg-everywhere-src-5.15.1.tar.xz'
  source_sha256 '308160223c0bd7492d56fb5d7b7f705bfb130947ac065bf39280ec6d7cbe4f6a'

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
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r Dir.glob('lib/*'), "#{CREW_DEST_LIB_PREFIX}"
    FileUtils.cp_r 'examples', "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r 'include', "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r 'mkspecs', "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r 'plugins', "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r 'src', "#{CREW_DEST_PREFIX}/share/Qt-5"
  end
end
