require 'package'

class Qttools < Package
  description 'Qt Tools'
  homepage 'https://github.com/qt/qttools'
  version '5.15.2'
  compatibility 'all'
  source_url 'http://download.qt.io/official_releases/qt/5.15/5.15.2/submodules/qttools-everywhere-src-5.15.2.tar.xz'
  source_sha256 'c189d0ce1ff7c739db9a3ace52ac3e24cb8fd6dbf234e49f075249b38f43c1cc'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/qttools-5.15.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/qttools-5.15.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/qttools-5.15.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qttools-5.15.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0d40cb342b8b31427bc976979dbc4c5bfcd8995e5bcc1e74a2a91cf4d84c2265',
     armv7l: '0d40cb342b8b31427bc976979dbc4c5bfcd8995e5bcc1e74a2a91cf4d84c2265',
       i686: '1f94a4b40c8f94d47b13445fd9dfb7abb50694cf0876d83e71287f59f36caeca',
     x86_64: '4fe6c1fcd3b4bdfbdface915f9c7d71b6c73deadbb5bb20cb5d89af8d6d9d2d2'
  })

  depends_on 'qtbase'
  depends_on 'libtinfo'

  def self.build
    # Note: This MAY NOT COMPILE with llvm installed on x86. Install dependencies,
    # disable depends, and uninstall llvm before attempting compile.
    system 'qmake -Wall -early QMAKE_CFLAGS=-flto -early QMAKE_CXXFLAGS=-flto && make'
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX.to_s
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
