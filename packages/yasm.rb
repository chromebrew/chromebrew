require 'package'

class Yasm < Package
  version '1.3.0'
  description 'Yasm is a complete rewrite of the NASM assembler under the new BSD License.'
  homepage 'http://yasm.tortall.net/'
  compatibility 'all'
  source_url 'http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz'
  source_sha256 '3dce6601b495f5b3d45b59f7d2492a340ee7e84b5beca17e48f862502bd5603f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/yasm-1.3.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/yasm-1.3.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/yasm-1.3.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/yasm-1.3.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2d6cf322742d3737864b5ce42eb3bc58a655c1d0b69551be27342c4a5a0dcf22',
     armv7l: '2d6cf322742d3737864b5ce42eb3bc58a655c1d0b69551be27342c4a5a0dcf22',
       i686: 'd040103857bf2c0f6fb4cd6120e7ed6f45891297c148acb750d0355245c568e1',
     x86_64: 'c83395c97dced0cc820642a7979c26ad830ab0f9b27eed6a8e3e13b5873bf082',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} make install"
  end
end
