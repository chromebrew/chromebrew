require 'package'

class Qtdeclarative < Package
  description 'Provides QML and Quick declaratives.'
  homepage 'https://www.qt.io/'
  version '5.12.3'
  compatibility 'all'
  source_url 'http://download.qt.io/official_releases/qt/5.12/5.12.3/submodules/qtdeclarative-everywhere-src-5.12.3.tar.xz'
  source_sha256 '839881cd6996e35c351bc7d560372ebb91e61f3688957c33248c4f31ea007fa7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/qtdeclarative-5.12.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/qtdeclarative-5.12.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/qtdeclarative-5.12.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qtdeclarative-5.12.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '19d4b0f1ed081e5295866383c384d1d749e2bdc07d792ca56bb22b0cde308d56',
     armv7l: '19d4b0f1ed081e5295866383c384d1d749e2bdc07d792ca56bb22b0cde308d56',
       i686: '4ac64dd69106135cc64acac9a1409c2c4616f39b1417acc49bfb9d7b59218b98',
     x86_64: 'e868bd1392e0043eac88bc65032a742f7cb04369afa3619f0db68553a5e40551',
  })

  depends_on 'python27'
  depends_on 'qtbase'

  def self.build
    system 'qmake && make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r Dir.glob('lib/*'), "#{CREW_DEST_LIB_PREFIX}"
    FileUtils.cp_r 'include', "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r 'mkspecs', "#{CREW_DEST_PREFIX}/share/Qt-5"
  end
end
