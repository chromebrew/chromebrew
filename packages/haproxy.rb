require 'package'

class Haproxy < Package
  description 'The Reliable, High Performance TCP/HTTP Load Balancer.'
  homepage 'http://www.haproxy.org/'
  version '1.9.8'
  source_url 'http://www.haproxy.org/download/1.9/src/haproxy-1.9.8.tar.gz'
  source_sha256 '2d9a3300dbd871bc35b743a83caaf50fecfbf06290610231ca2d334fd04c2aee'

  binary_url ({
      i686: 'https://dl.bintray.com/chromebrew/chromebrew/haproxy-1.9.8-chromeos-i686.tar.xz',
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/haproxy-1.9.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
      i686: '895f482eb4f01aa8b846f253064280c6b42b886add6432b65e228b07593d8508',
    x86_64: 'a3db1613a3c363a4f09de71efcecbc70fc08efff257f1dd74fd6863c429d59a3',
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
