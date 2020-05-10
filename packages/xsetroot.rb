require 'package'

class Xsetroot < Package
  description 'Root window parameter setting utility for X'
  homepage 'https://www.x.org/archive/X11R7.5/doc/man/man1/xsetroot.1.html'
  version '1.1.2'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/app/xsetroot-1.1.2.tar.bz2'
  source_sha256 '10c442ba23591fb5470cea477a0aa5f679371f4f879c8387a1d9d05637ae417c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xsetroot-1.1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xsetroot-1.1.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xsetroot-1.1.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xsetroot-1.1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '370530cc44d12e66cf83faa17fbac1aec5e44abddcf09802d3ec83cd6863832c',
     armv7l: '370530cc44d12e66cf83faa17fbac1aec5e44abddcf09802d3ec83cd6863832c',
       i686: '861082f1b69cd7cd54925d84d7bbdd152ccce378e80dac0171fba0c27f9e871a',
     x86_64: 'ebd15859bebe9ecfcf8bc954c1ae5072ff8d184b96398991478a70b3d38cd1e7',
  })

  depends_on 'xbitmaps'
  depends_on 'libxcursor'
  depends_on 'libxmu'

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
