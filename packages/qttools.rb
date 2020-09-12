require 'package'

class Qttools < Package
  description 'Qt Tools'
  homepage 'https://github.com/qt/qttools'
  version '5.15.1'
  compatibility 'all'
  source_url 'http://download.qt.io/official_releases/qt/5.15/5.15.1/submodules/qttools-everywhere-src-5.15.1.tar.xz'
  source_sha256 'c98ee5f0f980bf68cbf0c94d62434816a92441733de50bd9adbe9b9055f03498'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'qtbase'
  depends_on 'sommelier'

  def self.build
    system 'qmake && make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}"
    system "cp -a lib/* #{CREW_DEST_LIB_PREFIX}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r 'bin', "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r 'examples', "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r 'include', "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r 'mkspecs', "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r 'src/linguist/phrasebooks', "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    Dir.chdir "#{CREW_DEST_PREFIX}/share/Qt-5/bin" do
      system "find . -type f -exec ln -s #{CREW_PREFIX}/share/Qt-5/bin/{} #{CREW_DEST_PREFIX}/bin/{} \\;"
    end
  end
end
