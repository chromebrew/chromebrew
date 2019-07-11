require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.14.5'
  source_url 'https://cmake.org/files/v3.14/cmake-3.14.5.tar.gz'
  source_sha256 '505ae49ebe3c63c595fa5f814975d8b72848447ee13b6613b0f8b96ebda18c06'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.14.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.14.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.14.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.14.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd07a9fe9e229760fb27ef66b4c32021293e6b47dbf26f24220c264b23c3f4014',
     armv7l: 'd07a9fe9e229760fb27ef66b4c32021293e6b47dbf26f24220c264b23c3f4014',
       i686: '76c3548ddcc06811e74a4811c40fa2e2b03ed16be4ab374a9797e350f13fe38d',
     x86_64: 'ee3c221fb737141c8ca18418732d9b8ef7a0f0729b4990161690e88555b10412',
  })

  def self.build
    if Dir.exist? "#{CREW_PREFIX}/include/ncursesw"
      system 'sed -i "51s,$,\n  set(CURSES_INCLUDE_PATH ' + "#{CREW_PREFIX}/include/ncursesw" + ')," Modules/FindCurses.cmake'
    end
    system "./bootstrap --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
