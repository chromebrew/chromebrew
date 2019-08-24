require 'package'

class Iptables < Package
  description 'iptables is the userspace command line program used to configure the Linux 2.4.x and later packet filtering ruleset.'
  homepage 'https://www.netfilter.org/projects/iptables/'
  version '1.8.3'
  source_url 'https://www.netfilter.org/projects/iptables/files/iptables-1.8.3.tar.bz2'
  source_sha256 'a23cac034181206b4545f4e7e730e76e08b5f3dd78771ba9645a6756de9cdd80'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --disable-nftables"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
