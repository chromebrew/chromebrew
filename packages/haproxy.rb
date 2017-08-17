require 'package'

class Haproxy < Package
  description 'The Reliable, High Performance TCP/HTTP Load Balancer.'
  homepage 'http://www.haproxy.org/'
  version '1.7.8'
  source_url 'http://www.haproxy.org/download/1.7/src/haproxy-1.7.8.tar.gz'
  source_sha256 'ec90153ccedd20ad4015d3eaf76b502ff1f61b431d54c22b8457b5784a9ae142'

  depends_on 'openssl'
  depends_on 'pcre'

  def self.build
    system "make TARGET=linux26 USE_OPENSSL=1 USE_PCRE=1 USE_ZLIB=1"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
