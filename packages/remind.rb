require 'package'

class Remind < Package
  description 'Remind is a sophisticated calendar and alarm program.'
  homepage 'https://www.roaringpenguin.com/products/remind'
  version '03.01.15'
  compatibility 'all'
  source_url 'https://www.roaringpenguin.com/files/download/remind-03.01.15.tar.gz'
  source_sha256 '8adab4c0b30a556c34223094c5c74779164d5f3b8be66b8039f44b577e678ec1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/remind-03.01.15-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/remind-03.01.15-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/remind-03.01.15-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/remind-03.01.15-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '65bae63d254189573223d8771b257e8a0186ee6bfcfb8c97a7df74995e4fe042',
     armv7l: '65bae63d254189573223d8771b257e8a0186ee6bfcfb8c97a7df74995e4fe042',
       i686: '833cf2d86df2ed62af3056d7633a7c133bd289a459d10ad39e7160575dc2ad25',
     x86_64: '93144719846bf23d63c0b31c688ce5815b74e6600fe034d9c783cdd6887c7b0f',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
