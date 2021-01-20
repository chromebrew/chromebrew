require 'package'

class Qtx11extras < Package
  description 'Provides classes for developing for the X11 platform.'
  homepage 'https://www.qt.io/'
  version '5.15.1-1'
  compatibility 'all'
  source_url 'http://download.qt.io/official_releases/qt/5.15/5.15.1/submodules/qtx11extras-everywhere-src-5.15.1.tar.xz'
  source_sha256 'f7cd7c475a41840209808bf8b1de1c6587c3c74e5ae3b0969760b9ed35159e59'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/qtx11extras-5.15.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/qtx11extras-5.15.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/qtx11extras-5.15.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qtx11extras-5.15.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ea7ce2aabb51547b5bc0856c5e1ed456dc088cff9fbdf1963b4fcdb7f7b626bd',
     armv7l: 'ea7ce2aabb51547b5bc0856c5e1ed456dc088cff9fbdf1963b4fcdb7f7b626bd',
       i686: '44b9aa475e5e07e1ae93109ba7611fb881787e45a894a468d704a784dba39f36',
     x86_64: '08bd84632909341214c35adaa3857f44c111d7c182c33aee3654c34f43dad055',
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
