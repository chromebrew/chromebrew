require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.15.3'
  source_url 'https://cmake.org/files/v3.15/cmake-3.15.3.tar.gz'
  source_sha256 '13958243a01365b05652fa01b21d40fa834f70a9e30efa69c02604e64f58b8f5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.15.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.15.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.15.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.15.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1e5013ede20f3acd89cf323c9254f85338adf860160502ba980e3614862d73dc',
     armv7l: '1e5013ede20f3acd89cf323c9254f85338adf860160502ba980e3614862d73dc',
       i686: 'd8b48d3d78a4c0095697d177faef99ea219093d73f18d921198dc8eff0a8869c',
     x86_64: '1c9f297e531e5d4b6b35a927e81e74ddf1669a9f44290c1f181532ff474be183',
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
