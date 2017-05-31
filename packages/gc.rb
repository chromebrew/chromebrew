require 'package'

class Gc < Package
  description 'A garbage collector for C and C++.'
  homepage 'http://www.hboehm.info/gc/'
  version '7.2g'
  source_url 'http://www.hboehm.info/gc/gc_source/gc-7.2g.tar.gz'
  source_sha1 'd470f6c0dcb55f8a4f26199731edf006eba5b85c'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" 
  end
end
