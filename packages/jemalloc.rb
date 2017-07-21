require 'package'

class Jemalloc < Package
  description 'jemalloc is a general purpose malloc(3) implementation that emphasizes fragmentation avoidance and scalable concurrency support.'
  homepage 'http://jemalloc.net/'
  version '5.0.1'
  source_url 'https://github.com/jemalloc/jemalloc/releases/download/5.0.1/jemalloc-5.0.1.tar.bz2'
  source_sha256 '4814781d395b0ef093b21a08e8e6e0bd3dab8762f9935bbfb71679b0dea7c3e9'

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
