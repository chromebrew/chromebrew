require 'package'

class Iptables < Package
  description 'iptables is the userspace command line program used to configure the Linux 2.4.x and later packet filtering ruleset.'
  homepage 'https://www.netfilter.org/projects/iptables/'
  version '1.6.1'
  source_url 'https://www.netfilter.org/projects/iptables/files/iptables-1.6.1.tar.bz2'
  source_sha256 '0fc2d7bd5d7be11311726466789d4c65fb4c8e096c9182b56ce97440864f0cf5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/iptables-1.6.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/iptables-1.6.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/iptables-1.6.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/iptables-1.6.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4a72a30c1e6d29706a68473a8814461912f04c408e2738edb963667ad9e3a591',
     armv7l: '4a72a30c1e6d29706a68473a8814461912f04c408e2738edb963667ad9e3a591',
       i686: '4289bf6ce4a37636ce84bc47dbe5ceb96c1bc6ea5f08991ca018b3e40ad3fefc',
     x86_64: '19b2a357f5247dd9237311f9aafb206d151650525668a540bd0e5b48149193e2',
  })

  def self.build
    system './configure \
            --disable-nftables'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
