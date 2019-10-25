require 'package'

class Qtsvg < Package
  description 'Provides classes for displaying the contents of SVG files.'
  homepage 'https://www.qt.io/'
  version '5.12.3'
  source_url 'http://download.qt.io/official_releases/qt/5.12/5.12.3/submodules/qtsvg-everywhere-src-5.12.3.tar.xz'
  source_sha256 'f666438dbf6816b7534e539b95e3fa4405f11d7e2e2bbcde34f2db5ae0f27dc2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/qtsvg-5.12.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/qtsvg-5.12.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/qtsvg-5.12.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qtsvg-5.12.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8d7b4568bca5a401a53d177f4a32bf28cb8865028fe72569508015b02a356e6a',
     armv7l: '8d7b4568bca5a401a53d177f4a32bf28cb8865028fe72569508015b02a356e6a',
       i686: '980a79436c094a1e057d05e44d3e49ddea30af0917b29e9576bd340c4e699a04',
     x86_64: 'a5ec7c11247ab0c42061049ef313994c4a4ece6ac2bb6bceb1298e12114d6a8b',
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
  end
end
