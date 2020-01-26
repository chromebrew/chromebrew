require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.16.3'
  source_url 'https://cmake.org/files/v3.16/cmake-3.16.3.tar.gz'
  source_sha256 'e54f16df9b53dac30fd626415833a6e75b0e47915393843da1825b096ee60668'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.16.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.16.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.16.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.16.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ad08eeacaf54d48e0e926667bde7138225f0559e24c31d894547bf2e5369ab01',
     armv7l: 'ad08eeacaf54d48e0e926667bde7138225f0559e24c31d894547bf2e5369ab01',
       i686: '5902f1320df14c8140669fc01c042463e3592691958793650f220601dfab6c22',
     x86_64: 'c00f519bdd2cc7c9553f28c3af690320ab81cacf8b95644bfd1a4021114e9ba3',
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
