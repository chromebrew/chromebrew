require 'package'

class Jemalloc < Package
  description 'jemalloc is a general purpose malloc(3) implementation that emphasizes fragmentation avoidance and scalable concurrency support.'
  homepage 'http://jemalloc.net/'
  version '5.0.1'
  source_url 'https://github.com/jemalloc/jemalloc/releases/download/5.0.1/jemalloc-5.0.1.tar.bz2'
  source_sha256 '4814781d395b0ef093b21a08e8e6e0bd3dab8762f9935bbfb71679b0dea7c3e9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jemalloc-5.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jemalloc-5.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jemalloc-5.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jemalloc-5.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e4f7100998f6e1d586b8ff2f09a9933938400b37f2f7e1de942bf80a36dbe14f',
     armv7l: 'e4f7100998f6e1d586b8ff2f09a9933938400b37f2f7e1de942bf80a36dbe14f',
       i686: 'f5c312ec2a4f34d375f04fb2ad83320fa26331ae1522d89eda37e3a2382912d3',
     x86_64: 'f49bd69361ea2324b7cee56836f96379b40f6e25dc7633da7679e85247361a15',
  })

  depends_on 'autoconf'
  depends_on 'gawk'
  depends_on 'libxslt'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
