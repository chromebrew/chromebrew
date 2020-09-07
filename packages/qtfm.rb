require 'package'

class Qtfm < Package
  description 'Lightweight desktop independent Qt file manager'
  homepage 'https://qtfm.eu/'
  version '6.2.0'
  compatibility 'all'
  source_url 'https://github.com/rodlie/qtfm/archive/6.2.0.tar.gz'
  source_sha256 '58c6af502b606e63f96e8aec96b65ca9125be18ecdd5e4680ccaf50e9c40b064'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'qtbase'
  depends_on 'imagemagick7'
  depends_on 'ffmpeg'
  depends_on 'sommelier'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'qmake',
             "PREFIX=#{CREW_PREFIX}",
             "LIBDIR=#{CREW_LIB_PREFIX}",
             "INCLUDEPATH+=/usr/local/Qt-5/include",
             "INCLUDEPATH+=/usr/local/Qt-5/include/QtGui",
             'CONFIG+=with_includes',
             'CONFIG+=with_magick',
             'CONFIG+=magick7',
             'CONFIG+=with_ffmpeg',
             'CONFIG+=sharedlib',
             '..'
      system 'make', "-j#{CREW_NPROC}"
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "INSTALL_ROOT=#{CREW_DEST_DIR}", 'install'
    end
  end
end
