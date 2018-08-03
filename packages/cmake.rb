require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.12'
  source_url 'https://cmake.org/files/v3.12/cmake-3.12.0.tar.gz'
  source_sha256 'd0781a90f6cdb9049d104ac16a150f9350b693498b9dea8a0331e799db6b9d69'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.12-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.12-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '93827f90c17c1394cadda69ed9df7cedc4779b8e62ad582068c793546b8cd768',
     armv7l: '93827f90c17c1394cadda69ed9df7cedc4779b8e62ad582068c793546b8cd768',
       i686: '5bba9a1131a563a3236792a2035125656552e0026124f7170ac8048345b9ef6d',
     x86_64: 'e23172aaae71b3a9d8cf6ceb2b125dfc60910b026e8d7dc2a650f0554795e4de',
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
