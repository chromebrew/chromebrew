require 'package'

class Iptables < Package
  description 'iptables is the userspace command line program used to configure the Linux 2.4.x and later packet filtering ruleset.'
  homepage 'https://www.netfilter.org/projects/iptables/'
  version '1.6.1'
  source_url 'https://www.netfilter.org/projects/iptables/files/iptables-1.6.1.tar.bz2'
  source_sha256 '0fc2d7bd5d7be11311726466789d4c65fb4c8e096c9182b56ce97440864f0cf5'

  def self.build
    system './configure \
            --disable-nftables'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
