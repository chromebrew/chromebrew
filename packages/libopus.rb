require 'package'

class Libopus < Package
  description 'Opus is a totally open, royalty-free, highly versatile audio codec.'
  homepage 'http://opus-codec.org/'
  version '1.2.1'
  compatibility 'all'
  source_url 'https://archive.mozilla.org/pub/opus/opus-1.2.1.tar.gz'
  source_sha256 'cfafd339ccd9c5ef8d6ab15d7e1a412c054bf4cb4ecbbbcc78c12ef2def70732'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libopus-1.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libopus-1.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libopus-1.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libopus-1.2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7929d1a7b49da919aedd9b3e2fe8cd7a221535d93c35a01dfd561aa449365dbb',
     armv7l: '7929d1a7b49da919aedd9b3e2fe8cd7a221535d93c35a01dfd561aa449365dbb',
       i686: '75fb863728da71393412626a5944bfac8a716e6d938eb3ee36d3b080318fc577',
     x86_64: '317439fc79b79ff47626a5c5da9a7a86c55711960dddc8d8f89f3226b4d6fbbf',
  })

  def self.build
    system "./configure  \
	    --prefix=#{CREW_PREFIX} \
	    --libdir=#{CREW_LIB_PREFIX} \
            --enable-shared \
            --enable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
