require 'package'

class Nmap < Package
  description 'Nmap (\'Network Mapper\') is a free and open source (license) utility for network discovery and security auditing.'
  homepage 'https://nmap.org/'
  version '7.60'
  source_url 'https://nmap.org/dist/nmap-7.60.tar.bz2'
  source_sha256 'a8796ecc4fa6c38aad6139d9515dc8113023a82e9d787e5a5fb5fa1b05516f21'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nmap-7.60-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nmap-7.60-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nmap-7.60-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nmap-7.60-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '591755bc42bce6bfdb20859758ab66bbb02dca6a290d6fa97d46d9539805e9ac',
     armv7l: '591755bc42bce6bfdb20859758ab66bbb02dca6a290d6fa97d46d9539805e9ac',
       i686: '107dbd1fdf981d53a62697fd326844e7df4d0796da9ee29f1000f512d3229f03',
     x86_64: '12eb815ec4bc47ac0d778575c7125907421937396fa491745d5ab48486380550',
  })

  depends_on 'buildessential'

  def self.build
    system "./configure --with-pcap=linux --without-zenmap"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
