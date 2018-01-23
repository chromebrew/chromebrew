require 'package'

class Testdisk < Package
  description 'TestDisk is powerful free data recovery software!'
  homepage 'https://www.cgsecurity.org/wiki/TestDisk'
  version '7.1'
  source_url 'https://www.cgsecurity.org/testdisk-7.1-WIP.tar.bz2'
  source_sha256 '910d597b07e1da96aa73189a6f3121e38cb5bef857036d481ceaae7900da7429'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/testdisk-7.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/testdisk-7.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/testdisk-7.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/testdisk-7.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bbad6e298493e44ecea59ed07081c284d9533006fb68f16869f28bdcc2bb4dea',
     armv7l: 'bbad6e298493e44ecea59ed07081c284d9533006fb68f16869f28bdcc2bb4dea',
       i686: 'a80c70f716b4d227c8d283abbc6b73e375c5818a04e9b1b79c18c9508bc17e0e',
     x86_64: '852cf726e057917fc7056c7828db350ba4ee79df4ed2e0423885a1781e52e206',
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
