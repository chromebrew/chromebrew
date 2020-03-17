require 'package'

class Qtsvg < Package
  description 'Provides classes for displaying the contents of SVG files.'
  homepage 'https://www.qt.io/'
  version '5.12.3-1'
  source_url 'http://download.qt.io/official_releases/qt/5.12/5.12.3/submodules/qtsvg-everywhere-src-5.12.3.tar.xz'
  source_sha256 'f666438dbf6816b7534e539b95e3fa4405f11d7e2e2bbcde34f2db5ae0f27dc2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/qtsvg-5.12.3-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/qtsvg-5.12.3-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/qtsvg-5.12.3-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qtsvg-5.12.3-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c89fb9e2a3031c2375dfb0fe46ab0b25850cd7c54fbe8ac147fdbbe1c572930d',
     armv7l: 'c89fb9e2a3031c2375dfb0fe46ab0b25850cd7c54fbe8ac147fdbbe1c572930d',
       i686: '808c77d05d0ebdf489bb3c99dd6ac89c52349e05df101781ca7fd4d97aa02688',
     x86_64: 'e775106f346d65f528a55fa473cd45c3862bbb903a54268f0d8a754ef6574f5a',
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
