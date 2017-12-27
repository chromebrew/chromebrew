require 'package'

class Testdisk < Package
  description 'TestDisk is powerful free data recovery software!'
  homepage 'https://www.cgsecurity.org/wiki/TestDisk'
  version '7.1'
  source_url 'https://www.cgsecurity.org/testdisk-7.1-WIP.tar.bz2'
  source_sha256 '910d597b07e1da96aa73189a6f3121e38cb5bef857036d481ceaae7900da7429'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'compressdoc' => :build
  depends_on 'ncurses'
  depends_on 'apriconv'
  depends_on 'libjpeg'
  depends_on 'zlibpkg'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man8"
  end
end
