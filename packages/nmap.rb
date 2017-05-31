require 'package'

class Nmap < Package
  description 'Nmap (\'Network Mapper\') is a free and open source (license) utility for network discovery and security auditing.'
  homepage 'https://nmap.org/'
  version '7.31'
  source_url 'https://nmap.org/dist/nmap-7.31.tgz'
  source_sha1 'ccf1bb34463f39a645d9a924ce9e3c9e15eefbbf'

  depends_on 'buildessential'
  
  def self.build
    system "./configure --with-pcap=linux --without-zenmap"
    system "make"
  end
  
  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end         
end
