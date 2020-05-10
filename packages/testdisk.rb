require 'package'

class Testdisk < Package
  description 'TestDisk is powerful free data recovery software!'
  homepage 'https://www.cgsecurity.org/wiki/TestDisk'
  version '7.2'
  compatibility 'all'
  source_url 'https://www.cgsecurity.org/testdisk-7.2-WIP.tar.bz2'
  source_sha256 'c95dd532dad353713e8ca895a3faac31acef284f9f0fad299f69181fec583313'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/testdisk-7.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/testdisk-7.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/testdisk-7.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/testdisk-7.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd1d42ff50e0792de2c5ddaec3abcb5de9e7057a3d7f63f883cdf283d336850ce',
     armv7l: 'd1d42ff50e0792de2c5ddaec3abcb5de9e7057a3d7f63f883cdf283d336850ce',
       i686: 'a3da5c747e406e52ed72d119ba4c308e6465c85b594cf21be9e9e63151551bc7',
     x86_64: '8b5a399c8e43c821156eb632805fe94f0d6f81e99aaffbeb2e54f54e3a887c77',
  })

  depends_on 'apriconv'
  depends_on 'compressdoc' => :build
  depends_on 'libjpeg_turbo'
  depends_on 'ncurses'
  depends_on 'zlibpkg'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
