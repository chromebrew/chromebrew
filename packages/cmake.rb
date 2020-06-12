require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.17.1'
  compatibility 'all'
  source_url 'https://cmake.org/files/v3.17/cmake-3.17.1.tar.gz'
  source_sha256 '3aa9114485da39cbd9665a0bfe986894a282d5f0882b1dea960a739496620727'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.17.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.17.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.17.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.17.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6ebfeed065e9a823bfbd070e6d02535623320cc3322d22c862078a4501258bc8',
     armv7l: '6ebfeed065e9a823bfbd070e6d02535623320cc3322d22c862078a4501258bc8',
       i686: '8abe180a6b867916ece6d368690a93014e571010595b70fd0266c2be41abe2c6',
     x86_64: '844675c631ce4ab9bd1df28d746aad298699822a4c807dc8e1ea3f3edd1e70b7',
  })

  def self.patch
    if Dir.exist? "#{CREW_PREFIX}/include/ncursesw"
      system 'sed -i "51s,$,\n  set(CURSES_INCLUDE_PATH ' + "#{CREW_PREFIX}/include/ncursesw" + ')," Modules/FindCurses.cmake'
    end
  end

  def self.build
    system "./bootstrap --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
