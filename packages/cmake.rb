require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.12.2'
  source_url 'https://cmake.org/files/v3.12/cmake-3.12.2.tar.gz'
  source_sha256 '0f97485799e51a7070cc11494f3e02349b0fc3a24cc12b082e737bf67a0581a4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.12.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.12.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.12.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.12.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8c69b2eb83e6591925ba720049e18418ccb58d8fa217285159fb9a0d5caf4788',
     armv7l: '8c69b2eb83e6591925ba720049e18418ccb58d8fa217285159fb9a0d5caf4788',
       i686: '753b5f083571e63727f4706b6bd453cf07db7dff7c4853bfcad1a03c179922c5',
     x86_64: 'bd60b37bb2f1df504af1e73577be7980c9cbc6aa4fb15e46143e25f1ef1e8aea',
  })

  def self.build
    if Dir.exist? "#{CREW_PREFIX}/include/ncursesw"
      system 'sed -i "51s,$,\n  set(CURSES_INCLUDE_PATH ' + "#{CREW_PREFIX}/include/ncursesw" + ')," Modules/FindCurses.cmake'
    end
    system './bootstrap',
      "--prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
