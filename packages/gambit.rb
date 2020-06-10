require 'package'

class Gambit < Package
  description 'Efficient implementation of the Scheme programming language'
  homepage 'http://gambitscheme.org/wiki/index.php/Main_Page'
  version '4.9.3'
  compatibility 'all'
  source_url 'https://github.com/gambit/gambit/archive/v4.9.3.tar.gz'
  source_sha256 'a5e4e5c66a99b6039fa7ee3741ac80f3f6c4cff47dc9e0ff1692ae73e13751ca'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gambit-4.9.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gambit-4.9.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gambit-4.9.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gambit-4.9.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0e2b98c6d0a60f3715c6e554a4b95018cd6d665c4709892da9eafc74fd84ebd5',
     armv7l: '0e2b98c6d0a60f3715c6e554a4b95018cd6d665c4709892da9eafc74fd84ebd5',
       i686: '08bc6d954969ec3f4d3a985d9460647f4667b33609f98fe3ff6b705e09ab8260',
     x86_64: 'baa93bfbb278ac2560fbf56cb3e6339f2bf633105986b3d23f2e343eedf632e0',
  })

  def self.build
    system './configure',
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}/gambit",
             '--enable-openssl',
             '--enable-single-host',
             '--enable-multiple-versions',
             '--enable-compiler-name=gsc-gambit',
             '--enable-interpreter-name=gsi-gambit'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
