require 'package'

class Qtdeclarative < Package
  description 'Provides QML and Quick declaratives.'
  homepage 'https://www.qt.io/'
  version '5.15.1'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'http://download.qt.io/official_releases/qt/5.15/5.15.1/submodules/qtdeclarative-everywhere-src-5.15.1.tar.xz'
  source_sha256 '7e30f0ccba61f9d71720b91d7f7523c23677f23cd96065cb71df1b0df329d768'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/qtdeclarative-5.15.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/qtdeclarative-5.15.1-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qtdeclarative-5.15.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e95739560c1a124ddc52362945327cb60a1fc0bda568ca15011848750b8554d9',
     armv7l: 'e95739560c1a124ddc52362945327cb60a1fc0bda568ca15011848750b8554d9',
     x86_64: '44824e25081beff3552b35a09de7ae0948d8040199e6acadcfeb765e2451a68a',
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
