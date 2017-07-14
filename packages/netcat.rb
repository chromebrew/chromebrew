require 'package'

class Netcat < Package
  description 'Netcat is a featured networking utility which reads and writes data across network connections, using the TCP/IP protocol.'
  homepage 'http://netcat.sourceforge.net/'
  version '0.7.1'
  source_url 'http://downloads.sourceforge.net/project/netcat/netcat/0.7.1/netcat-0.7.1.tar.gz'
  source_sha256 '30719c9a4ffbcf15676b8f528233ccc54ee6cba96cb4590975f5fd60c68a066f'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
