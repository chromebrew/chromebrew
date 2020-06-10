require 'package'

class Libxrender < Package
  description 'X Rendering Extension client library.'
  homepage 'http://www.x.org'
  version '0.9.10-0'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/lib/libXrender-0.9.10.tar.gz'
  source_sha256 '770527cce42500790433df84ec3521e8bf095dfe5079454a92236494ab296adf'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxrender-0.9.10-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxrender-0.9.10-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxrender-0.9.10-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxrender-0.9.10-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f6a33f234184d2dae8646449940234d749deefffb7148a141ac09a402a054e22',
     armv7l: 'f6a33f234184d2dae8646449940234d749deefffb7148a141ac09a402a054e22',
       i686: '883bce06a7813a3640258c2d1f9f81bac128330a34726691d8c5e76959525e40',
     x86_64: '561c5a0e8f4b0cd4d9b7e1f7c2b53901e687d3be91e0dfdcb93f3c2184f61dbc',
  })

  depends_on 'libx11'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
