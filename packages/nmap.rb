require 'package'

class Nmap < Package
  description 'Nmap (\'Network Mapper\') is a free and open source (license) utility for network discovery and security auditing.'
  homepage 'https://nmap.org/'
  version '7.70'
  source_url 'https://nmap.org/dist/nmap-7.70.tar.bz2'
  source_sha256 '847b068955f792f4cc247593aca6dc3dc4aae12976169873247488de147a6e18'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nmap-7.70-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nmap-7.70-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nmap-7.70-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nmap-7.70-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7cc3c71f49254d9cd809f7de8ade5c26b9a07e826244fb2df0817fe00c593420',
     armv7l: '7cc3c71f49254d9cd809f7de8ade5c26b9a07e826244fb2df0817fe00c593420',
       i686: '5e7cb838b232fb999cb7684e0ba8b21a61850c3107d74c748c0c7ac2e58dfe0f',
     x86_64: '27d2b3bdf89573224f0c1436e534540e4cb8a8a74aceef0ce5e8a0987462ae94',
  })

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
