require 'package'

class Nmap < Package
  description 'Nmap (\'Network Mapper\') is a free and open source (license) utility for network discovery and security auditing.'
  homepage 'https://nmap.org/'
  version '7.50'
  source_url 'https://nmap.org/dist/nmap-7.50.tgz'
  source_sha1 '9e77da9079489e86db9634e87efbd88500de9c65'

  depends_on 'buildessential'
  
  def self.build
    system "./configure --with-pcap=linux --without-zenmap"
    system "make"
  end
  
  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end         
end
