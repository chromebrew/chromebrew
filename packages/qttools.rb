require 'package'

class Qttools < Package
  description 'Qt Tools'
  homepage 'https://github.com/qt/qttools'
  version '5.15.0'
  compatibility 'all'
  source_url 'http://download.qt.io/official_releases/qt/5.15/5.15.0/submodules/qttools-everywhere-src-5.15.0.tar.xz'
  source_sha256 'ddbcb49aab3a2e3672582c6e2e7bec0058feff790f67472343c79e2895e0e437'

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
