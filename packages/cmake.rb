require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.11.0'
  source_url 'https://cmake.org/files/v3.11/cmake-3.11.0.tar.gz'
  source_sha256 'c313bee371d4d255be2b4e96fd59b11d58bc550a7c78c021444ae565709a656b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.11.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.11.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.11.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.11.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '003e4e09cc4dc61adb047cd66c88040db1603648ca7e61acb913f4a0a33c317f',
     armv7l: '003e4e09cc4dc61adb047cd66c88040db1603648ca7e61acb913f4a0a33c317f',
       i686: '0848647b3c55242f53c6a0d932e3946f4f8aee7402e0b9568bce6522e836b75d',
     x86_64: 'a43c913c2b564d7ab54e75fe1e631a75d01c312ca3e211022942aaa47b7f766e',
  })

  depends_on 'libuv'
  depends_on 'openssl'
  depends_on 'ncurses'

  def self.build
    if Dir.exist? "#{CREW_PREFIX}/include/ncursesw"
      system 'sed -i "51s,$,\n  set(CURSES_INCLUDE_PATH ' + "#{CREW_PREFIX}/include/ncursesw" + ')," Modules/FindCurses.cmake'
    end
    system './bootstrap',
      "--prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
