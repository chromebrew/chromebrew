require 'package'

class Jemalloc < Package
  description 'jemalloc is a general purpose malloc(3) implementation that emphasizes fragmentation avoidance and scalable concurrency support.'
  homepage 'http://jemalloc.net/'
  version '5.0.1-1'
  source_url 'https://github.com/jemalloc/jemalloc/releases/download/5.0.1/jemalloc-5.0.1.tar.bz2'
  source_sha256 '4814781d395b0ef093b21a08e8e6e0bd3dab8762f9935bbfb71679b0dea7c3e9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jemalloc-5.0.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jemalloc-5.0.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jemalloc-5.0.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jemalloc-5.0.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0f822a3ede3cbe6fac8d736650c0ae52ceec9e69e64746f6af51feb040baa615',
     armv7l: '0f822a3ede3cbe6fac8d736650c0ae52ceec9e69e64746f6af51feb040baa615',
       i686: '9bb85bc541cd1582955328e87a6e1dce7a1e9baf486768911efe041f0d6d6683',
     x86_64: 'c2d0a38655d5af85c08dfc2ef96881b42acb328e0a0b4d72a8c1cbfa82d61f7f',
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
