require 'package'

class Nanomsg < Package
  description 'nanomsg is a socket library that provides several common communication patterns.'
  homepage 'http://nanomsg.org/'
  version '1.0,0'
  source_url 'https://github.com/nanomsg/nanomsg/archive/1.0.0.tar.gz'
  source_sha256 '24afdeb71b2e362e8a003a7ecc906e1b84fd9f56ce15ec567481d1bb33132cc7'

  depends_on 'cmake'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
