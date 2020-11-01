require 'package'

class Pixman < Package
  description 'Pixman is a low-level software library for pixel manipulation, providing features such as image compositing and trapezoid rasterization.'
  homepage 'http://www.pixman.org/'
  version '0.40.0-0'
  compatibility 'all'
  source_url 'https://www.cairographics.org/releases/pixman-0.40.0.tar.gz'
  source_sha256 '6d200dec3740d9ec4ec8d1180e25779c00bc749f94278c8b9021f5534db223fc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pixman-0.40.0-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pixman-0.40.0-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pixman-0.40.0-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pixman-0.40.0-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fbf99db1fcf954a8932ba8590964e6029b13e0bd08fbed118eb368d4263e4b77',
     armv7l: 'fbf99db1fcf954a8932ba8590964e6029b13e0bd08fbed118eb368d4263e4b77',
       i686: 'ba6b20c7263f551506d65ac72a7d1f334dc492e8dbf1970d184c393db3ecb71b',
     x86_64: 'a3c1b4c722e598ae10571fe8ef00dddc431ac6d833980f6f859b093a9ac385d1',
  })

  depends_on 'llvm' => ':build'
  depends_on 'libpng'

  def self.build
    ENV['CFLAGS'] = "-fuse-ld=lld"
    ENV['CXXFLAGS'] = "-fuse-ld=lld"
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
