require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.16.0'
  source_url 'https://cmake.org/files/v3.16/cmake-3.16.0.tar.gz'
  source_sha256 '6da56556c63cab6e9a3e1656e8763ed4a841ac9859fefb63cbe79472e67e8c5f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.16.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.16.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.16.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.16.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9cb171530fbf62c483fbbb6311da02f77718b05f7a62ea79eac8238edd189516',
     armv7l: '9cb171530fbf62c483fbbb6311da02f77718b05f7a62ea79eac8238edd189516',
       i686: '03b373b0891dcd883b6f1d397785366b8e94d33a6fa88f4e591780d8d5bb8fb0',
     x86_64: '5fa7550151e4861114f93d968e7ddd30f7494767953c79ed0ea291fe87845437',
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
