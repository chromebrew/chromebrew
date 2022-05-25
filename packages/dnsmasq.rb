require 'package'

class Dnsmasq < Package
  description 'Lightweight, easy to configure DNS forward ,TFTP server and DHCP server'
  homepage 'http://www.thekelleys.org.uk/dnsmasq/doc.html'
  version '2.89'
  license 'GPL-2 or GPL-3'
  compatibility 'all'
  source_url 'http://thekelleys.org.uk/dnsmasq/dnsmasq-2.89.tar.xz'
  source_sha256 '02bd230346cf0b9d5909f5e151df168b2707103785eb616b56685855adebb609'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dnsmasq/2.89_armv7l/dnsmasq-2.89-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dnsmasq/2.89_armv7l/dnsmasq-2.89-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dnsmasq/2.89_i686/dnsmasq-2.89-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dnsmasq/2.89_x86_64/dnsmasq-2.89-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e798ec6969f5ec63d9975efbeef5f82d537fc8349f95b4151d07dd19de9792e2',
     armv7l: 'e798ec6969f5ec63d9975efbeef5f82d537fc8349f95b4151d07dd19de9792e2',
       i686: 'a73b32027305d5d9d28331624f95272c47675b25fe0be8b65ff51a3e59b0a442',
     x86_64: 'aa5c65411792ffc97c989e8b3f5e7447e12a68f7c6c992e4e4e747236e626845'
  })

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
