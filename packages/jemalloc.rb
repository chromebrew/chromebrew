require 'package'

class Jemalloc < Package
  description 'jemalloc is a general purpose malloc(3) implementation that emphasizes fragmentation avoidance and scalable concurrency support.'
  homepage 'http://jemalloc.net/'
  version '5.2.1'
  source_url 'https://github.com/jemalloc/jemalloc/releases/download/5.2.1/jemalloc-5.2.1.tar.bz2'
  source_sha256 '34330e5ce276099e2e8950d9335db5a875689a4c6a56751ef3b1d8c537f887f6'

  binary_url ({
  })
  binary_sha256 ({
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
