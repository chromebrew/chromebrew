require 'package'

class Iptables < Package
  description 'iptables is the userspace command line program used to configure the Linux 2.4.x and later packet filtering ruleset.'
  homepage 'https://www.netfilter.org/projects/iptables/'
  version '1.6.1-1'
  source_url 'https://www.netfilter.org/projects/iptables/files/iptables-1.6.1.tar.bz2'
  source_sha256 '0fc2d7bd5d7be11311726466789d4c65fb4c8e096c9182b56ce97440864f0cf5'

  binary_url ({
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/iptables-1.6.1-1-chromeos-x86_64.tar.xz',
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/iptables-1.6.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/iptables-1.6.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/iptables-1.6.1-1-chromeos-i686.tar.xz',
  })
  binary_sha256 ({
     x86_64: 'db40420fd3c926cf252232c19f4c07c35769ed2fa496350e88a4ff2a0422edee',
    aarch64: '72c2d7c0c065ac6b4d3f98463e8accde960b67e9584c9c9a82043d71f5ef9dcd',
     armv7l: '72c2d7c0c065ac6b4d3f98463e8accde960b67e9584c9c9a82043d71f5ef9dcd',
       i686: '7c9eedcc3dd9e2657bdfbf0efcebe5e39762a36def97c3b531c93913c1ec29a0',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --disable-nftables"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
