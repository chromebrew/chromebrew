require 'package'

class Libpng < Package
  description 'libpng is the official PNG reference library.'
  homepage 'http://libpng.org/pub/png/libpng.html'
  version '1.6.32'
  source_url 'http://prdownloads.sourceforge.net/libpng/libpng-1.6.32.tar.gz'
  source_sha256 '1a8ae5c8eafad895cc3fce78fbcb6fdef663b8eb8375f04616e6496360093abb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libpng-1.6.32-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libpng-1.6.32-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libpng-1.6.32-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libpng-1.6.32-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '575871d19e38d2cc4e51889bd3f7866b12dd52d9929d66830065c0f490c3a7e7',
     armv7l: '575871d19e38d2cc4e51889bd3f7866b12dd52d9929d66830065c0f490c3a7e7',
       i686: 'd401afe08f7e1ff6b78e6a12cf89a71214d880bb876a71bd5f764fa787db8c3e',
     x86_64: 'aadb3ac7f63711ccd3410a9775053fc9730d7e4462d39efed0c9e0db93fb5bce',
  })

  def self.build
      system "./configure CFLAGS=\" -fPIC\""
      system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
