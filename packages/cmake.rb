require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  @_ver = '3.19.4'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/Kitware/CMake/releases/download/v#{@_ver}/cmake-#{@_ver}.tar.gz"
  source_sha256 '7d0232b9f1c57e8de81f38071ef8203e6820fe7eec8ae46a1df125d88dbcc2e1'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.19.4-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.19.4-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.19.4-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.19.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '2fadd859e81c8db71411692c6cef4efbd53daa3c70b5d8739f7d15de290fdffb',
      armv7l: '2fadd859e81c8db71411692c6cef4efbd53daa3c70b5d8739f7d15de290fdffb',
        i686: '155a845f77398d932b257c1e1d88d88ddb9aadd3475a07dfef7254eec9ec1216',
      x86_64: '378988eb97d00f0c8b57e1c2992a1a597c2ec640d58d0f16be9caab203fd69cc',
  })

  depends_on 'llvm' => :build

  def self.patch
    if Dir.exist? "#{CREW_PREFIX}/include/ncursesw"
      system 'sed -i "51s,$,\n  set(CURSES_INCLUDE_PATH ' + "#{CREW_PREFIX}/include/ncursesw" + ')," Modules/FindCurses.cmake'
    end
  end

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
      ./bootstrap --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
