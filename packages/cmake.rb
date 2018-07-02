require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.11.4'
  source_url 'https://cmake.org/files/v3.11/cmake-3.11.4.tar.gz'
  source_sha256 '8f864e9f78917de3e1483e256270daabc4a321741592c5b36af028e72bff87f5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.11.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.11.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.11.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.11.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '12b176c138d6034bb0c9afe305342ec6458e926d30ecf69e249fdc1e1e558c3c',
     armv7l: '12b176c138d6034bb0c9afe305342ec6458e926d30ecf69e249fdc1e1e558c3c',
       i686: 'ea3cf4cd98c36144894d10dd6a2551ed8ef0a54f097bbb2d25cfc68f5e9493d9',
     x86_64: '8c26d1c5236b28b1132aec93957292f28aadb3f6065517b3c223c9fc42b0f9ce',
  })

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
