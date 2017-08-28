require 'package'

class Haproxy < Package
  description 'The Reliable, High Performance TCP/HTTP Load Balancer.'
  homepage 'http://www.haproxy.org/'
  version '1.7.8'
  source_url 'http://www.haproxy.org/download/1.7/src/haproxy-1.7.8.tar.gz'
  source_sha256 'ec90153ccedd20ad4015d3eaf76b502ff1f61b431d54c22b8457b5784a9ae142'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/haproxy-1.7.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/haproxy-1.7.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/haproxy-1.7.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/haproxy-1.7.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9eb798dceac782358cdb63dad096018a8b4084ed6dd305185cb5f17e3d59c556',
     armv7l: '9eb798dceac782358cdb63dad096018a8b4084ed6dd305185cb5f17e3d59c556',
       i686: 'ee9cefc0ddafff672c9f4128497ca15998402f00a7c5e51d85cdcf4922171d6b',
     x86_64: 'a4d0c929f0a58b1d2cd2fa31d3de3c0ad32ea734b8e2b866ac631392a98aeb6f',
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
