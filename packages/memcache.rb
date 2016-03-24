require 'package'

class Memcache < Package
  version '1.4.24'
  source_url 'http://www.memcached.org/files/memcached-1.4.24.tar.gz'
  source_sha1 '32a798a37ef782da10a09d74aa1e5be91f2861db'
  
  depends_on 'libevent'

  def self.build
    system "./configure --libdir=/usr/local/lib#{SHORTARCH}/ CC=\"gcc -m#{SHORTARCH}\" CFLAGS=\" -fPIC\" --disable-coverage"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
