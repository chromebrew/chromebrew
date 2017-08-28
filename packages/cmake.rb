require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.9.1'
  source_url 'https://cmake.org/files/v3.9/cmake-3.9.1.tar.gz'
  source_sha256 'd768ee83d217f91bb597b3ca2ac663da7a8603c97e1f1a5184bc01e0ad2b12bb'

  binary_url ({
  })
  binary_sha256 ({
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
