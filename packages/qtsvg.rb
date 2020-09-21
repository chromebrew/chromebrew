require 'package'

class Qtsvg < Package
  description 'Provides classes for displaying the contents of SVG files.'
  homepage 'https://www.qt.io/'
  version '5.15.1'
  compatibility 'all'
  source_url 'http://download.qt.io/official_releases/qt/5.15/5.15.1/submodules/qtsvg-everywhere-src-5.15.1.tar.xz'
  source_sha256 '308160223c0bd7492d56fb5d7b7f705bfb130947ac065bf39280ec6d7cbe4f6a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/qtsvg-5.15.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/qtsvg-5.15.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/qtsvg-5.15.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qtsvg-5.15.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '45a4e115d43f59daa636a53050ef477da6e790cda70872cb9c1c07c4963e2337',
     armv7l: '45a4e115d43f59daa636a53050ef477da6e790cda70872cb9c1c07c4963e2337',
       i686: 'c2fef5e314f284a1a731b7274890056331dd812605c1614fd62024d7fd0648dc',
     x86_64: '4b833b5a94e5b5daa251a57b5f94c46b806b8b605a8e1cd77fb4a9ae3ffacbf7',
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
