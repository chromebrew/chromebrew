require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.19.2'
  compatibility 'all'
  source_url 'https://github.com/Kitware/CMake/releases/download/v3.19.2/cmake-3.19.2.tar.gz'
  source_sha256 'e3e0fd3b23b7fb13e1a856581078e0776ffa2df4e9d3164039c36d3315e0c7f0'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.19.2-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.19.2-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.19.2-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.19.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'ba16050036e58a4b3c5fa23865608e850eb9de865e9f5a6fac163c84adeca261',
      armv7l: 'ba16050036e58a4b3c5fa23865608e850eb9de865e9f5a6fac163c84adeca261',
        i686: 'd7d39b576dd92448b9c1440d9c35e4c4284513cb72f3576af1e282f0c5c58f22',
      x86_64: '6c0737c9d2cea24bfb4bbbb7ff0fa6139488d6f19866fd799fe5b89adaf36f7a',
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
