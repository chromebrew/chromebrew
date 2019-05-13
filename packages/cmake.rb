require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.14.3'
  source_url 'https://cmake.org/files/v3.14/cmake-3.14.3.tar.gz'
  source_sha256 '215d0b64e81307182b29b63e562edf30b3875b834efdad09b3fcb5a7d2f4b632'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.14.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.14.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.14.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.14.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '53ff9ffbb8894a4fa0951125223001085f3854058c83485baa99305b37a40f10',
     armv7l: '53ff9ffbb8894a4fa0951125223001085f3854058c83485baa99305b37a40f10',
       i686: '720e5aeafd1435966efe5979a1a88025540c792a71227473a351be61aabd8362',
     x86_64: '68bb956136478169cc74d43e59a3c055d9e565c6f0b93a1fcbf7e56f3912d580',
  })

  def self.build
    if Dir.exist? "#{CREW_PREFIX}/include/ncursesw"
      system 'sed -i "51s,$,\n  set(CURSES_INCLUDE_PATH ' + "#{CREW_PREFIX}/include/ncursesw" + ')," Modules/FindCurses.cmake'
    end
    system "./bootstrap --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
