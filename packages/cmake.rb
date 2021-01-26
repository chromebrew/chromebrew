require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  @_ver = '3.19.3'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/Kitware/CMake/releases/download/v#{@_ver}/cmake-#{@_ver}.tar.gz"
  source_sha256 '3faca7c131494a1e34d66e9f8972ff5369e48d419ea8ceaa3dc15b4c11367732'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.19.3-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.19.3-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.19.3-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.19.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'f7c3464b04d34ba0e80a9dc00c8a79c7755dfa1002530c9ed3eba52babacf85d',
      armv7l: 'f7c3464b04d34ba0e80a9dc00c8a79c7755dfa1002530c9ed3eba52babacf85d',
        i686: 'ee8e96b017d69a9235f65cc72b64451dfefe903a53455aceffacdabe3111f6da',
      x86_64: '6d6f640ac421c0e93086368b829587a6439e555b6926b4ac337f381cbb65a8bf',
  })

  depends_on 'llvm' => :build

  def self.patch
    if Dir.exist? "#{CREW_PREFIX}/include/ncursesw"
      system 'sed -i "51s,$,\n  set(CURSES_INCLUDE_PATH ' + "#{CREW_PREFIX}/include/ncursesw" + ')," Modules/FindCurses.cmake'
    end
  end

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      ./bootstrap --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
