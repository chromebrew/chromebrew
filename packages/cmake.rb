require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.10.1'
  source_url 'https://cmake.org/files/v3.10/cmake-3.10.1.tar.gz'
  source_sha256 '7be36ee24b0f5928251b644d29f5ff268330a916944ef4a75e23ba01e7573284'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.10.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.10.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.10.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.10.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bbdc47f0ee67e500c6cab439b9443dc0d21f2d472709b6cb9232490a8d7e9254',
     armv7l: 'bbdc47f0ee67e500c6cab439b9443dc0d21f2d472709b6cb9232490a8d7e9254',
       i686: '47a1dd635316052f383a36949a49decb0ca6ba57d40d5f118c0361e5dacf52ce',
     x86_64: '77c23449a2a8e4a9f98069b330d2e186a5845bba78a4899d7a84840b378c3b7f',
  })

  depends_on 'buildessential'
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
