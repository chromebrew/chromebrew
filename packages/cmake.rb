require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.18.1'
  compatibility 'all'
  source_url 'https://cmake.org/files/v3.18/cmake-3.18.1.tar.gz'
  source_sha256 'c0e3338bd37e67155b9d1e9526fec326b5c541f74857771b7ffed0c46ad62508'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.18.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.18.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.18.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.18.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9eca3f0dfb8a1519473368a44b32cc84f0f3329a047c4d99496bd038c5305c2f',
     armv7l: '9eca3f0dfb8a1519473368a44b32cc84f0f3329a047c4d99496bd038c5305c2f',
       i686: 'e4934520df848a6ff1f6adffde6bc7a38d12c815da58b4e830556632231452d4',
     x86_64: 'f677d8a51575abd0ddff4e9c5560c43c730c16f7e792a0ab9f6db329d0b057da',
  })

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
