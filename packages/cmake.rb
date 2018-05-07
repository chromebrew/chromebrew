require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.11.1'
  source_url 'https://cmake.org/files/v3.11/cmake-3.11.1.tar.gz'
  source_sha256 '57bebc6ca4d1d42c6385249d148d9216087e0fda57a47dc5c858790a70217d0c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.11.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.11.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.11.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.11.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0a225df6e0d34cfd7b04f346f1a196af2067f2119ac00b4258ae329436337412',
     armv7l: '0a225df6e0d34cfd7b04f346f1a196af2067f2119ac00b4258ae329436337412',
       i686: '8ce6a201ffc9deead5b6e31a98c7fa4ee3d5dc149516aad95ae4ab2b2d3b2276',
     x86_64: '34fc8e28f407c16ad18952183f9f26daa9a4bb9a1872c043fbdd670eb2795015',
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
