require 'package'

class Haproxy < Package
  description 'The Reliable, High Performance TCP/HTTP Load Balancer.'
  homepage 'http://www.haproxy.org/'
  version '1.7.2'
  source_url 'http://www.haproxy.org/download/1.7/src/haproxy-1.7.2.tar.gz'
  source_sha1 'b022485e28b96b673e3116a69d8922cb7367a81f'
  
  depends_on "openssl"
  depends_on "pcre"

  def self.build
    system "make TARGET=linux26 USE_OPENSSL=1 USE_PCRE=1 USE_ZLIB=1"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" 
  end
end
