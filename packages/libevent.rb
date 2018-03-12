require 'package'

class Libevent < Package
  description 'The libevent API provides a mechanism to execute a callback function when a specific event occurs on a file descriptor or after a timeout has been reached.'
  homepage 'http://libevent.org/'
  version '2.1.8-0'
  source_url 'https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz'
  source_sha256 '965cc5a8bb46ce4199a47e9b2c9e1cae3b137e8356ffdad6d94d3b9069b71dc2'


  depends_on 'openssl'

  def self.build
    system "./configure  --prefix=#{CREW_PREFIX}  --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
