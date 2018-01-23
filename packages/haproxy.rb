require 'package'

class Haproxy < Package
  description 'The Reliable, High Performance TCP/HTTP Load Balancer.'
  homepage 'http://www.haproxy.org/'
  version '1.7.9'
  source_url 'http://www.haproxy.org/download/1.7/src/haproxy-1.7.9.tar.gz'
  source_sha256 '1072337e54fa188dc6e0cfe3ba4c2200b07082e321cbfe5a0882d85d54db068e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/haproxy-1.7.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/haproxy-1.7.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/haproxy-1.7.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/haproxy-1.7.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '709ab2222103fb450310dd184b37af7181322773109e1c41c516b924cbc9c86e',
     armv7l: '709ab2222103fb450310dd184b37af7181322773109e1c41c516b924cbc9c86e',
       i686: '94849f2aee0a336997e19134d1a27f9f2a32daa57a8cccdec797ed4c9c0057f1',
     x86_64: '6bad205056d137fc998b01f229bdaa782fe2d859ef5723f2bbe73f473a95a2ff',
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
