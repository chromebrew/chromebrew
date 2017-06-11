require 'package'

class Libslz < Package
  description 'SLZ is a fast and memory-less stream compressor which produces an output that can be decompressed with zlib or gzip.'
  homepage 'https://github.com/haproxy/libslz'
  version '1.1.0'
  source_url 'http://git.1wt.eu/web?p=libslz.git;a=snapshot;h=afa04ae1f976957cf36287cc5370998d0559bc63;sf=tbz2'
  source_sha1 '20d8a90c6a0949bfb15547ead0636e416366ac44'

  def self.build
    system "make PREFIX=/usr/local"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" 
  end
end
