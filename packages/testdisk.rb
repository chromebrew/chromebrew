require 'package'

class Testdisk < Package
  description 'TestDisk is powerful free data recovery software!'
  homepage 'https://www.cgsecurity.org/wiki/TestDisk'
  version '7.2-1'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://www.cgsecurity.org/testdisk-7.2-WIP.tar.bz2'
  source_sha256 'c95dd532dad353713e8ca895a3faac31acef284f9f0fad299f69181fec583313'

  depends_on 'apriconv'
  depends_on 'compressdoc' => :build
  depends_on 'libjpeg_turbo'
  depends_on 'ncursesw'
  depends_on 'zlibpkg'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
