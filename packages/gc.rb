require 'package'

class Gc < Package
  description 'A garbage collector for C and C++.'
  homepage 'http://www.hboehm.info/gc/'
  version '7.2g'
  source_url 'http://www.hboehm.info/gc/gc_source/gc-7.2g.tar.gz'
  source_sha256 '584e29e2f1be4a389ca30f78dcd2c991031e7d1e1eb3d7ce2a0f975218337c2f'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
