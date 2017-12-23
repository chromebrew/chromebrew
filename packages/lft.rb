require 'package'

class Lft < Package
  description "LFT, short for Layer Four Traceroute, is a sort of 'traceroute' that often works much faster (than the commonly-used Van Jacobson method) and goes through many configurations of packet-filters (firewalls)."
  homepage 'http://pwhois.org/lft/'
  version '3.79'
  source_url 'https://fossies.org/linux/privat/lft-3.79.tar.gz'
  source_sha256 '08e5c7973551b529c850bffbc7152c4e5f0bcb1f07ebbb39151a7dc9a3bf9de0'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libpcap'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
