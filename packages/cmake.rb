require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.9.3'
  source_url 'https://cmake.org/files/v3.9/cmake-3.9.3.tar.gz'
  source_sha256 '8eaf75e1e932159aae98ab5e7491499545554be62a08cbcbc7c75c84b999f28a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.9.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.9.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.9.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cmake-3.9.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fb2be8ed6f668631e8485db0f8108b24733387b889a7138732ce11c82fa61dca',
     armv7l: 'fb2be8ed6f668631e8485db0f8108b24733387b889a7138732ce11c82fa61dca',
       i686: 'd8cff8d8c51739f79f966c10c33cd32d9411656157683390ad5b7c520f0282d3',
     x86_64: '64ddab4fa9877f229b7e7398773659e258156bb13c5b0f831a91609fedb4de9e',
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
