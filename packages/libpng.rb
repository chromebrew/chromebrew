require 'package'

class Libpng < Package
  description 'libpng is the official PNG reference library.'
  homepage 'http://libpng.org/pub/png/libpng.html'
  version '1.6.28'
  source_url 'http://prdownloads.sourceforge.net/libpng/libpng-1.6.28.tar.gz'
  source_sha256 'b6cec903e74e9fdd7b5bbcde0ab2415dd12f2f9e84d9e4d9ddd2ba26a41623b2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libpng-1.6.28-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libpng-1.6.28-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libpng-1.6.28-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libpng-1.6.28-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '52bb5b4d50d0373795d42856bf8fe4d53f6a8353e0254739a242138b600562ec',
     armv7l: '52bb5b4d50d0373795d42856bf8fe4d53f6a8353e0254739a242138b600562ec',
       i686: '042b9ed617899e66889e216a7194868bfb286fef7864317c353258a322dcd5f6',
     x86_64: '11ada0286cff8d7ea6fb4ec22b9149beb87cf5739e32e787691c384ffebd634a',
  })

  def self.build
      system "./configure CFLAGS=\" -fPIC\""
      system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
