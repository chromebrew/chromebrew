require 'package'

class Haproxy < Package
  description 'The Reliable, High Performance TCP/HTTP Load Balancer.'
  homepage 'http://www.haproxy.org/'
  version '1.9.8'
  source_url 'http://www.haproxy.org/download/1.9/src/haproxy-1.9.8.tar.gz'
  source_sha256 '2d9a3300dbd871bc35b743a83caaf50fecfbf06290610231ca2d334fd04c2aee'

  depends_on 'openssl'
  depends_on 'pcre'

  def self.build
    system "make TARGET=linux26 USE_OPENSSL=1 USE_PCRE=1 USE_ZLIB=1"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
