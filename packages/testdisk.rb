require 'package'

class Testdisk < Package
  description 'TestDisk is powerful free data recovery software!'
  homepage 'https://www.cgsecurity.org/wiki/TestDisk'
  version '7.2'
  source_url 'https://www.cgsecurity.org/testdisk-7.2-WIP.tar.bz2'
  source_sha256 'c95dd532dad353713e8ca895a3faac31acef284f9f0fad299f69181fec583313'

  binary_url ({
  })
  binary_sha256 ({
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
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man8"
  end
end
