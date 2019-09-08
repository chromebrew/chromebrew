require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.15.3'
  source_url 'https://cmake.org/files/v3.15/cmake-3.15.3.tar.gz'
  source_sha256 '13958243a01365b05652fa01b21d40fa834f70a9e30efa69c02604e64f58b8f5'

  binary_url ({
  })
  binary_sha256 ({
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
