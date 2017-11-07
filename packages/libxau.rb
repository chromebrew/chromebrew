require 'package'

class Libxau < Package
  description 'xau library for libX11'
  homepage 'https://x.org'
  version '1.0.8'
  source_url 'https://www.x.org/archive/individual/lib/libXau-1.0.8.tar.gz'
  source_sha256 'c343b4ef66d66a6b3e0e27aa46b37ad5cab0f11a5c565eafb4a1c7590bc71d7b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxau-1.0.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxau-1.0.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxau-1.0.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxau-1.0.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2f6026d23eddeb0ee904e2833075f27781ca8fed5b374a800641a04a6f55883e',
     armv7l: '2f6026d23eddeb0ee904e2833075f27781ca8fed5b374a800641a04a6f55883e',
       i686: '3c26b592e53c958237030da201ca9a630e02ce241fef21397a055c29aa7d9509',
     x86_64: 'df36a2ee46e3f9ed704e610337cdaa22f915107e58f716755604b4b743f689f8',
  })
  
  depends_on 'xproto'
  
  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
