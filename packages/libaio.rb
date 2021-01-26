require 'package'

class Libaio < Package
  description 'Linux-native asynchronous I/O access library'
  homepage 'https://pagure.io/libaio'
  @_ver = '0.3.112'
  version @_ver
  compatibility 'all'
  source_url "https://pagure.io/libaio/archive/libaio-#{@_ver}/libaio-libaio-#{@_ver}.tar.gz"
  source_sha256 'b7cf93b29bbfb354213a0e8c0e82dfcf4e776157940d894750528714a0af2272'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libaio-0.3.112-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libaio-0.3.112-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libaio-0.3.112-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libaio-0.3.112-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'f7fc535e5d72f059e97f5b18a41b3cac20b63930d773bdc21438e170bb395e26',
      armv7l: 'f7fc535e5d72f059e97f5b18a41b3cac20b63930d773bdc21438e170bb395e26',
        i686: '95ec694e17e2c13ea263fd39711daf68d9f5e7b5e17c596e4aa52a1ce001398f',
      x86_64: '17335130827e4eb1cc2202e5dcbc8651e61f8ba32fc8264c59bf26b78a0a5545',
  })


  def self.build
    system "sed -i 's,prefix=/usr,prefix=#{CREW_PREFIX},' Makefile"
    system "sed -i 's,libdir=\$(prefix)/lib,libdir=#{CREW_LIB_PREFIX},' Makefile"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
