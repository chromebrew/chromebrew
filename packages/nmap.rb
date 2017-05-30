require 'package'

class Nmap < Package
  description 'Nmap ('Network Mapper') is a free and open source (license) utility for network discovery and security auditing.'
  homepage 'https://nmap.org/'
  version '7.31'
  source_url 'https://nmap.org/dist/nmap-7.31.tgz' # Software source tarball url  
  source_sha1 'ccf1bb34463f39a645d9a924ce9e3c9e15eefbbf'

  depends_on 'buildessential'
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure --with-pcap=linux --without-zenmap" 
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end         
end
