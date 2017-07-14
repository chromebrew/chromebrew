require 'package'

class Nmap < Package
  description 'Nmap (\'Network Mapper\') is a free and open source (license) utility for network discovery and security auditing.'
  homepage 'https://nmap.org/'
  version '7.50'
  source_url 'https://nmap.org/dist/nmap-7.50.tgz'
  source_sha256 '40febe4a4e4b583aabcdd8cfceb6ae0f366dbb2fede96e4a529340bdb6d24776'

  depends_on 'buildessential'

  def self.build
    system "./configure --with-pcap=linux --without-zenmap"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
