require 'package'

class Nmap < Package
  description 'Nmap (\'Network Mapper\') is a free and open source (license) utility for network discovery and security auditing.'
  homepage 'https://nmap.org/'
  version '7.70'
  source_url 'https://nmap.org/dist/nmap-7.70.tar.bz2'
  source_sha256 '847b068955f792f4cc247593aca6dc3dc4aae12976169873247488de147a6e18'

  depends_on 'buildessential' => :build
  depends_on 'filecmd' => :build

  def self.build
    #fixup "/usr/bin/file" -> "#{CREW_PREFIX}/bin/file" in the configure scripts
    system "sed -i s#/usr/bin/file##{CREW_DEST_PREFIX}/bin/file#g libdnet-stripped/configure" 
    system "./configure --with-pcap=linux --without-zenmap --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
