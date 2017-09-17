require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.9.1'
  source_url 'https://cmake.org/files/v3.9/cmake-3.9.1.tar.gz'
  source_sha256 'd768ee83d217f91bb597b3ca2ac663da7a8603c97e1f1a5184bc01e0ad2b12bb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.9.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.9.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.9.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.9.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0735ec6920a6598a066e9cddca144eb3e6d3d56313d766d19ce0f91eafa3f90a',
     armv7l: '0735ec6920a6598a066e9cddca144eb3e6d3d56313d766d19ce0f91eafa3f90a',
       i686: '3ed6f69859386916cd001cd3d68330b361133883a7f65146b08080b238efcb7f',
     x86_64: '2ddaca97b6f8e4973d7fe1631652734ac414e47b6e221ac126de61c0f5e12455',
  })

  depends_on 'buildessential'
  depends_on 'openssl'
  depends_on 'ncurses'

  def self.build
    if Dir.exist? '/usr/local/include/ncursesw'
      system 'sed -i "51s,$,\n  set(CURSES_INCLUDE_PATH /usr/local/include/ncursesw)," Modules/FindCurses.cmake'
    end
    system "./bootstrap"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
