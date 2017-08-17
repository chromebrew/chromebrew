require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.9.0'
  source_url 'https://cmake.org/files/v3.9/cmake-3.9.0.tar.gz'
  source_sha256 '167701525183dbb722b9ffe69fb525aa2b81798cf12f5ce1c020c93394dfae0f'

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
