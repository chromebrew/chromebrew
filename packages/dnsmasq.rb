require 'package'

class Dnsmasq < Package
  description 'Lightweight, easy to configure DNS forward ,TFTP server and DHCP server'
  homepage 'https://thekelleys.org.uk/dnsmasq/doc.html'
  version '2.93'
  license 'GPL-2 or GPL-3'
  compatibility 'all'
  source_url "https://thekelleys.org.uk/dnsmasq/dnsmasq-#{version}.tar.xz"
  source_sha256 '0c00d4e5c97c8306e5fb932b348b34269c9c29a0e7df0e8e82958b407092bc19'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '702292824296ccc79a9b8f31c035ca0ae7791ece642d3602843caa56b2477a5c',
     armv7l: '702292824296ccc79a9b8f31c035ca0ae7791ece642d3602843caa56b2477a5c',
       i686: '3998248188e21b0dd99c6c9352379df918e0c92b756bdff274958219c2fd8b96',
     x86_64: '96843f71acbb663b27e93d6ba6655ea34ec2b73a4c8ccbd7fb2f79ad2411ad75'
  })

  depends_on 'glibc' => :executable

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
