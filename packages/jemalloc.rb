require 'package'

class Jemalloc < Package
  description 'jemalloc is a general purpose malloc(3) implementation that emphasizes fragmentation avoidance and scalable concurrency support.'
  homepage 'http://jemalloc.net/'
  version '5.2.1'
  compatibility 'all'
  source_url 'https://github.com/jemalloc/jemalloc/releases/download/5.2.1/jemalloc-5.2.1.tar.bz2'
  source_sha256 '34330e5ce276099e2e8950d9335db5a875689a4c6a56751ef3b1d8c537f887f6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jemalloc-5.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jemalloc-5.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jemalloc-5.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jemalloc-5.2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bc626c680f09555d7909d4cb13eac39b321ac930b8deb68e5e5dd9e24ac95e55',
     armv7l: 'bc626c680f09555d7909d4cb13eac39b321ac930b8deb68e5e5dd9e24ac95e55',
       i686: '6f27f415d4db08b3c108c7d53cd93b2d473751e1cc8c3514086e9392ff59c6ef',
     x86_64: '5cd68973fac52dceefe6bd0cd50d1ecb43538206013c4e8c148c9581d1ec753e',
  })

  depends_on 'libxslt'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
