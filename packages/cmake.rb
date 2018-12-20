require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.13.2'
  source_url 'https://cmake.org/files/v3.13/cmake-3.13.2.tar.gz'
  source_sha256 'c925e7d2c5ba511a69f43543ed7b4182a7d446c274c7480d0e42cd933076ae25'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.13.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.13.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.13.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.13.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c51a1a850e928be59e5c3ad5ab708fc1511001597f03413a3861e7bb5b42603d',
     armv7l: 'c51a1a850e928be59e5c3ad5ab708fc1511001597f03413a3861e7bb5b42603d',
       i686: 'b6362623145ffd0060d56db8b08f9a17b913c7e8a9012b9cd54d7924ab0fea84',
     x86_64: '266148894803c26d92a0aef1126b3cfe8c025e4d3336a3338e81f63f41c63241',
  })

  def self.build
    if Dir.exist? "#{CREW_PREFIX}/include/ncursesw"
      system 'sed -i "51s,$,\n  set(CURSES_INCLUDE_PATH ' + "#{CREW_PREFIX}/include/ncursesw" + ')," Modules/FindCurses.cmake'
    end
    system "./bootstrap --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
