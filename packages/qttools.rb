require 'package'

class Qttools < Package
  description 'Qt Tools'
  homepage 'https://github.com/qt/qttools'
  version '5.12.3'
  compatibility 'all'
  source_url 'http://download.qt.io/official_releases/qt/5.12/5.12.3/submodules/qttools-everywhere-src-5.12.3.tar.xz'
  source_sha256 'c9e92d2f0d369e44bb1a60e9fa6d970f8d9893d653212305e04be5e6daec2cd8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/qttools-5.12.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/qttools-5.12.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/qttools-5.12.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qttools-5.12.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6ffa4d4c83e99e789c5aa62503d8efca8c65297a2ef3f5727fe15ee4bacd07b4',
     armv7l: '6ffa4d4c83e99e789c5aa62503d8efca8c65297a2ef3f5727fe15ee4bacd07b4',
       i686: '2483850b80bf9e529e5dd2b5213d2d926f02eb173e154ef2554d88497d8f1b6f',
     x86_64: 'e4d70c3744ce933a2628cc81c0193d34bbacfc41e540cdabdf903ecc3e69f2c1',
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
    FileUtils.cp_r 'plugins', "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.cp_r 'src/linguist/phrasebooks', "#{CREW_DEST_PREFIX}/share/Qt-5"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    Dir.chdir "#{CREW_DEST_PREFIX}/share/Qt-5/bin" do
      system "find . -type f -exec ln -s #{CREW_PREFIX}/share/Qt-5/bin/{} #{CREW_DEST_PREFIX}/bin/{} \\;"
    end
  end
end
