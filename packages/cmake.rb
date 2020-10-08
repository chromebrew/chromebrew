require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.18.3'
  compatibility 'all'
  source_url 'https://cmake.org/files/v3.18/cmake-3.18.3.tar.gz'
  source_sha256 '2c89f4e30af4914fd6fb5d00f863629812ada848eee4e2d29ec7e456d7fa32e5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.18.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.18.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.18.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.18.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4f70a81794bd2262f94783f07cba30c763d33831dd8543bc6071f2cafbb10ed0',
     armv7l: '4f70a81794bd2262f94783f07cba30c763d33831dd8543bc6071f2cafbb10ed0',
       i686: '238aff93e40dd21e7bbde3f3642dccaaf212b932dade2015b7bd3106ce23c2ad',
     x86_64: 'c9abf8e948ef06d62f5b2f4924e2e057833d0c805fd009cd75190b910d0fdaa3',
  })

  depends_on 'llvm' => :build

  def self.patch
    if Dir.exist? "#{CREW_PREFIX}/include/ncursesw"
      system 'sed -i "51s,$,\n  set(CURSES_INCLUDE_PATH ' + "#{CREW_PREFIX}/include/ncursesw" + ')," Modules/FindCurses.cmake'
    end
  end

  def self.build
    system "./bootstrap --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
