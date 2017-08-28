require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.9.0'
  source_url 'https://cmake.org/files/v3.9/cmake-3.9.0.tar.gz'
  source_sha256 '167701525183dbb722b9ffe69fb525aa2b81798cf12f5ce1c020c93394dfae0f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.9.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.9.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.9.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.9.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cedb60b66b4224baf0c1b7b4c7f6c7fba9fc88c42d0b97bbc18aa70215180420',
     armv7l: 'cedb60b66b4224baf0c1b7b4c7f6c7fba9fc88c42d0b97bbc18aa70215180420',
       i686: 'bacc959acecf7a05d58d2e94ae6669203e26135c28a1acd81b49c53e55b4cba2',
     x86_64: '0d169a61d4dca18cd4d49a52063725bccd19b3c625b2dbd43b454ef1a4a3bf3d',
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
