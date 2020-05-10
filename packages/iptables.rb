require 'package'

class Iptables < Package
  description 'iptables is the userspace command line program used to configure the Linux 2.4.x and later packet filtering ruleset.'
  homepage 'https://www.netfilter.org/projects/iptables/'
  version '1.8.3'
  compatibility 'all'
  source_url 'https://www.netfilter.org/projects/iptables/files/iptables-1.8.3.tar.bz2'
  source_sha256 'a23cac034181206b4545f4e7e730e76e08b5f3dd78771ba9645a6756de9cdd80'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/iptables-1.8.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/iptables-1.8.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/iptables-1.8.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/iptables-1.8.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '18c2cdd028a017bd6e7fa02ebc1f41158fa3793873bcd33a3054d746a7655be1',
     armv7l: '18c2cdd028a017bd6e7fa02ebc1f41158fa3793873bcd33a3054d746a7655be1',
       i686: '7d19db312bd7d3ebad6e90049f03b656add0abf7f55f299a2243316136a2e130',
     x86_64: 'fbef75acb3252c55f30712ac902662a1c2968932e167df82173ba64cd333e45e',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --disable-nftables"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
