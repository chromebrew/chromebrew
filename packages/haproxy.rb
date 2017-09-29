require 'package'

class Haproxy < Package
  description 'The Reliable, High Performance TCP/HTTP Load Balancer.'
  homepage 'http://www.haproxy.org/'
  version '1.7.9'
  source_url 'http://www.haproxy.org/download/1.7/src/haproxy-1.7.9.tar.gz'
  source_sha256 '1072337e54fa188dc6e0cfe3ba4c2200b07082e321cbfe5a0882d85d54db068e'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'openssl'
  depends_on 'pcre'

  def self.build
    system "make TARGET=linux26 USE_OPENSSL=1 USE_PCRE=1 USE_ZLIB=1"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
