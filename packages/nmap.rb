require 'package'

class Nmap < Package
  description 'Nmap (\'Network Mapper\') is a free and open source (license) utility for network discovery and security auditing.'
  homepage 'https://nmap.org/'
  version '7.80'
  source_url 'https://nmap.org/dist/nmap-7.80.tar.bz2'
  source_sha256 'fcfa5a0e42099e12e4bf7a68ebe6fde05553383a682e816a7ec9256ab4773faa'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    #fixup "/usr/bin/file" -> "#{CREW_PREFIX}/bin/file" in the configure scripts
    system "sed -i s#/usr/bin/file##{CREW_DEST_PREFIX}/bin/file#g libdnet-stripped/configure" 
    system "./configure --with-pcap=linux --without-zenmap --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
