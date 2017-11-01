require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.9.3'
  source_url 'https://cmake.org/files/v3.9/cmake-3.9.3.tar.gz'
  source_sha256 '8eaf75e1e932159aae98ab5e7491499545554be62a08cbcbc7c75c84b999f28a'

  binary_url ({
  })
  binary_sha256 ({
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
