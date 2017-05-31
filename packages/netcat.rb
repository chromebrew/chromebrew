require 'package'

class Netcat < Package
  description 'Netcat is a featured networking utility which reads and writes data across network connections, using the TCP/IP protocol.'
  homepage 'http://netcat.sourceforge.net/'
  version '0.7.1'
  source_url 'http://downloads.sourceforge.net/project/netcat/netcat/0.7.1/netcat-0.7.1.tar.gz'
  source_sha1 'b5cbc52a7ceed2fd5c4f5081f5747130b2d0fe01'
 
  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
